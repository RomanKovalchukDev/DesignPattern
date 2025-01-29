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
