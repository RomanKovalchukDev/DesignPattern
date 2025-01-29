//
//  ProductDataFactory.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 28.01.2025.
//

protocol ProductDataFactory {
    func getSomeProduct() -> ProductType
}

final class ProductionProductFactory: ProductDataFactory {
    func getSomeProduct() -> any ProductType {
        ProductionProduct()
    }
}

final class DevProductFactory: ProductDataFactory {
    func getSomeProduct() -> any ProductType {
        DevProduct()
    }
}
