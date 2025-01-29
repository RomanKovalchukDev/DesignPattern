//
//  VisitorSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 Analytics loggin, exporting data, validation
 */

protocol ExportVisitable: Hashable {
    func accept(visitor: ExportVisitor)
}

protocol ExportVisitor {
    var result: String { get }
    
    func visitUser(_ user: VisitorUser)
    func visitOrder(_ order: VisitorOrder)
}

final class VisitorUser: ExportVisitable {
    let name: String
    let email: String

    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    static func == (lhs: VisitorUser, rhs: VisitorUser) -> Bool {
        lhs.name == rhs.name && lhs.email == rhs.email
    }

    func accept(visitor: ExportVisitor) {
        visitor.visitUser(self)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(email)
    }
}

class VisitorOrder: ExportVisitable {
    let orderId: String
    let amount: Double

    init(orderId: String, amount: Double) {
        self.orderId = orderId
        self.amount = amount
    }
    
    static func == (lhs: VisitorOrder, rhs: VisitorOrder) -> Bool {
        lhs.orderId == rhs.orderId && lhs.amount == rhs.amount
    }

    func accept(visitor: ExportVisitor) {
        visitor.visitOrder(self)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(orderId)
        hasher.combine(amount)
    }
}

class JSONExportVisitor: ExportVisitor {
    private(set) var result: String = ""

    func visitUser(_ user: VisitorUser) {
        result = "{\"name\": \"\(user.name)\", \"email\": \"\(user.email)\"}"
    }

    func visitOrder(_ order: VisitorOrder) {
        result = "{\"orderId\": \"\(order.orderId)\", \"amount\": \(order.amount)}"
    }
}

class XMLExportVisitor: ExportVisitor {
    private(set) var result: String = ""

    func visitUser(_ user: VisitorUser) {
        result = "<user><name>\(user.name)</name><email>\(user.email)</email></user>"
    }

    func visitOrder(_ order: VisitorOrder) {
        result = "<order><orderId>\(order.orderId)</orderId><amount>\(order.amount)</amount></order>"
    }
}

import SwiftUI

struct VisitorSampleView: View {
    
    @State private var exportResult: String = ""
    
    private let data: [any ExportVisitable] = [
        VisitorUser(name: "Jhon", email: "jhon99@gmail.com"),
        VisitorOrder(orderId: UUID().uuidString, amount: 10)
    ]

    private let jsonExporter = JSONExportVisitor()
    private let xmlExporter = XMLExportVisitor()
    
    var body: some View {
        VStack {
            Text("Export result:")
                .font(.headline)
            
            Text(exportResult)
            
            HStack {
                Button(
                    action: {
                        performExport(with: jsonExporter)
                    },
                    label: {
                        Text("Export as JSON")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                )
                
                Button(
                    action: {
                        performExport(with: xmlExporter)
                    },
                    label: {
                        Text("Export as XML")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                )
            }
        }
    }
    
    private func performExport(with exporter: any ExportVisitor) {
        var arrayResult: [String] = []
        
        for datum in data {
            if let user = datum as? VisitorUser {
                exporter.visitUser(user)
            }
            
            if let order = datum as? VisitorOrder {
                exporter.visitOrder(order)
            }
            
            arrayResult.append(exporter.result)
        }
        
        exportResult = arrayResult.joined(separator: "\n")
    }
}

#Preview {
    VisitorSampleView()
}
