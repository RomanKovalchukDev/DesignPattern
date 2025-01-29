//
//  ProductViewFactory.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 28.01.2025.
//

import SwiftUI

protocol ProductViewFactory {
    func getProductExtendedView(for product: ProductType) -> AnyView
    func getProductView(for product: ProductType) -> AnyView
}

final class IphoneProductsViewFactory: ProductViewFactory {
    func getProductView(for product: ProductType) -> AnyView {
        AnyView(
            HStack {
                Text(product.name)
                Spacer()
                Text(product.price.formatted(.currency(code: "USA")))
            }
                .padding()
                .frame(minHeight: 40)
                .background(Color.cyan.opacity(0.5))
        )
    }
    
    func getProductExtendedView(for product: ProductType) -> AnyView {
        AnyView(
            Text("Product extended view")
        )
    }
}

final class IPadProductsViewFactory: ProductViewFactory {
    func getProductView(for product: ProductType) -> AnyView {
        AnyView(
            HStack {
                Text(product.name)
                    .padding(.trailing, 4)
                Text(product.description)
                Spacer()
                Text(product.price.formatted(.currency(code: "USA")))
            }
                .padding()
                .frame(minHeight: 100)
                .background(Color.green.opacity(0.1))
        )
    }
    
    func getProductExtendedView(for product: ProductType) -> AnyView {
        AnyView(
            Text("Product extended view")
        )
    }
}
