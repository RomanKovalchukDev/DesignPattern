//
//  MediatorSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 - handling complex flows (chats etc.)
 - views sync
 - game logic coordinator
 */

// MARK: - Sample

import Foundation

protocol ChatUserType: AnyObject, Identifiable {
    func sendMessage(message: String)
    func receiveMessage(message: String)
}

final class ChatUser: ChatUserType {
    
    var id: String = UUID().uuidString
    
    private var mediator: any ChatMediatorType
    private var name: String
    
    init(name: String, mediator: any ChatMediatorType) {
        self.mediator = mediator
        self.name = name
    }
    
    func sendMessage(message: String) {
        mediator.sendMessage(message: message, user: self)
    }
    
    func receiveMessage(message: String) {
        debugPrint("\(name) received message: \(message)")
    }
}

protocol ChatMediatorType {
    func sendMessage(message: String, user: any ChatUserType)
}

final class ChatRoom: ObservableObject, ChatMediatorType {
    private var users: [any ChatUserType] = []
    
    func addUser(user: any ChatUserType) {
        users.append(user)
    }
    
    func sendMessage(message: String, user: any ChatUserType) {
        for participant in users where participant.id != user.id {
            participant.receiveMessage(message: message)
        }
    }
}

// MARK: - View example

import SwiftUI

struct ChatRoomView: View {
    
    @StateObject private var chatRoom = ChatRoom()
    @State private var user1Message = ""
    @State private var user2Message = ""
    @State private var messages: [String] = []
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Chat Room")
                .font(.largeTitle)
                .padding(.top)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(messages, id: \.self) { message in
                        Text(message)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
            .frame(minWidth: 300, maxHeight: 400)
            .border(Color.gray, width: 1)
            
            HStack {
                Text("User 1")
                TextField("Enter your message", text: $user1Message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                
                Button(
                    action: {
                        let user = ChatUser(name: "User1", mediator: chatRoom)
                        chatRoom.addUser(user: user)
                        user.sendMessage(message: user1Message)
                        messages.append("User1: \(user1Message)")
                        user1Message = ""
                    },
                    label: {
                        Text("Send")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                )
            }
            .padding()
            
            HStack {
                Text("User 2")
                TextField("Enter your message", text: $user2Message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                
                Button(
                    action: {
                        let user = ChatUser(name: "User2", mediator: chatRoom)
                        chatRoom.addUser(user: user)
                        user.sendMessage(message: user2Message)
                        messages.append("User2: \(user2Message)")
                        user2Message = ""
                    },
                    label: {
                        Text("Send")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                )
            }
            .padding()
        }
        .padding()
        .onAppear {
            setupChatRoom()
        }
    }
    
    private func setupChatRoom() {
        // Set up users and add them to the chat room
        let user1 = ChatUser(name: "User1", mediator: chatRoom)
        let user2 = ChatUser(name: "User2", mediator: chatRoom)
        
        chatRoom.addUser(user: user1)
        chatRoom.addUser(user: user2)
    }
}

struct ChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomView()
    }
}
