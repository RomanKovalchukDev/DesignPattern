//
//  ProductType.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 28.01.2025.
//

import Foundation

protocol ProductType {
    var id: String { get }
    var description: String { get }
    var name: String { get }
    var price: Decimal { get }
}

struct ProductionProduct: ProductType {
    let id: String = UUID().uuidString
    let description: String = "Real product"
    let name: String = "Product 1"
    let price: Decimal = 10.0
}

struct DevProduct: ProductType {
    let id: String = UUID().uuidString
    let description: String = "Fake product"
    let name: String = "NOT REAL"
    let price: Decimal = 100.0
}
