# Command

## Overview

The Command pattern encapsulates a request as an object, letting you parameterize clients with different requests, queue or log requests, and support undoable operations.

## Swift Implementation

### CommandSample.swift

```swift
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

```

### CreateOrderCommand.swift

```swift
//
//  CreateOrderCommand.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 28.01.2025.
//

import Foundation

protocol OrderCommandType {
    func execute(on order: inout Order) throws
    func undo(on order: inout Order) throws
}

final class CreateOrderCommand: OrderCommandType {
    func execute(on order: inout Order) {
        order.status = "Created"
        debugPrint("Order status: \(order.status)")
    }

    func undo(on order: inout Order) {
        order.status = "None"
        debugPrint("Order creation undone. Status: \(order.status)")
    }
}

final class PayOrderCommand: OrderCommandType {
    func execute(on order: inout Order) {
        order.isPaid = true
        debugPrint("Order paid")
    }

    func undo(on order: inout Order) {
        order.isPaid = false
        debugPrint("Payment undone")
    }
}

final class PlaceOrderCommand: OrderCommandType {
    func execute(on order: inout Order) {
        order.isPlaced = true
        debugPrint("Order placed")
    }

    func undo(on order: inout Order) {
        order.isPlaced = false
        debugPrint("Order placement undone")
    }
}

final class TransactionCommand: OrderCommandType {
    private var commands: [OrderCommandType] = []

    func add(command: OrderCommandType) {
        commands.append(command)
    }

    func execute(on order: inout Order) throws {
        for command in commands {
           try command.execute(on: &order)
        }
    }

    func undo(on order: inout Order) throws {
        for command in commands.reversed() {
            try command.undo(on: &order)
        }
    }
}

```

## Key Points

- Study the code structure and relationships between components
- Notice how the pattern promotes loose coupling and flexibility
- Consider when this pattern would be useful in your own projects
- Experiment by modifying the code to fit your use cases
