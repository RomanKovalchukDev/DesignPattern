//
//  MementoSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 - editor, with undo function
 - game save / restore state
 - navigation save / restore state
 - files changes history
 */

// MARK: - Sample

import SwiftUI

class TextEditorViewModel: ObservableObject {
    struct Memento {
        let state: String
    }
    
    @Published private(set) var text: String = ""
    private var history: [Memento] = []
    private var currentIndex: Int = 0

    func updateText(_ newText: String) {
        if currentIndex < history.count - 1 {
            history = Array(history.prefix(upTo: currentIndex + 1))
        }
        
        text = newText
        history.append(Memento(state: text))
        currentIndex = history.count - 1
    }

    func undo() {
        guard currentIndex > 0 else {
            return
        }
        
        currentIndex -= 1
        text = history[currentIndex].state
    }

    func redo() {
        guard currentIndex < history.count - 1 else {
            return
        }
        
        currentIndex += 1
        text = history[currentIndex].state
    }
}

struct TextEditorView: View {
    @StateObject private var viewModel = TextEditorViewModel()
    @State private var inputText: String = ""

    var body: some View {
        VStack(spacing: 16) {
            TextField("Enter text", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text("Current Text: \(inputText)")
                .font(.headline)
                .padding()

            HStack(spacing: 16) {
                Button(
                    action: {
                        viewModel.undo()
                        inputText = viewModel.text
                    },
                    label: {
                        Text("Undo")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                )

                Button(
                    action: {
                        viewModel.redo()
                        inputText = viewModel.text
                    },
                    label: {
                        Text("Redo")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                )
            }
            
            Button(
                action: {
                    viewModel.updateText(inputText)
                },
                label: {
                    Text("Save state")
                        .padding()
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            )
        }
        .padding()
    }
}

struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
    }
}
