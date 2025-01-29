//
//  CommandSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 Most common use cases:
 - parameterizing ui element actions
 - queue tasks
 - track opertion history
 - Chain actions that should work with transaction logic
 */

// MARK: - Sample

// MARK: - Command Protocol

// MARK: - Order Object

struct Order {
    var status: String = "Created"
    var isPaid: Bool = false
    var isPlaced: Bool = false
}

// MARK: - Second sample

// Game with gold system

protocol CommandType {
    func execute() -> Int
}

struct FaceEnemyCommand: CommandType {
    func execute() -> Int {
        10
    }
}

struct UnlockSomethingCommand: CommandType {
    func execute() -> Int {
        -10
    }
}

// MARK: - UI Helper

import SwiftUI

struct CommandGameView: View {
    @State private var gold: Int = 100 // Starting gold

    private let faceEnemyCommand = FaceEnemyCommand()
    private let unlockSomethingCommand = UnlockSomethingCommand()

    var body: some View {
        VStack(spacing: 20) {
            Text("Gold: \(gold)")
                .font(.largeTitle)
                .padding()

            HStack(spacing: 20) {
                Button(
                    action: {
                        execute(command: faceEnemyCommand)
                    },
                    label: {
                        Text("Face Enemy")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                )

                Button(
                    action: {
                        execute(command: unlockSomethingCommand)
                    },
                    label: {
                        Text("Unlock Something")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                )
            }
            .frame(maxWidth: .infinity)

            Spacer()
        }
        .padding()
    }

    private func execute(command: CommandType) {
        let change = command.execute()
        gold += change
    }
}

// MARK: - Preview

struct CommandGameView_Previews: PreviewProvider {
    static var previews: some View {
        CommandGameView()
    }
}
