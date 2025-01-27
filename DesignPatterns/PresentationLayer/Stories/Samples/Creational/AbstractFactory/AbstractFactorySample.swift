//
//  AbstractFactorySample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

/*
 Most common use cases of abstract factory:
  - platform or environment dependent views (different views for the ios / android, iphone / ipad), (different way of showing the error message for the dev / prod builds);
  - platform or environment dependent services (different analytics provider for prod / stage, different storages for app target or test target)
  - different animation depending on env
 */

import SwiftUI

// MARK: - Data

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

// MARK: - View factory

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
        fatalError("Not implemented yet")
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
        fatalError("Not implemented yet")
    }
}

// MARK: - Data factory

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

// MARK: - Show how to use

/// Your real view
struct ProductsDetailsView: View {
    
    var body: some View {
        productViewFactory.getProductView(for: productDataFactory.getSomeProduct())
    }
    
    private let productViewFactory: any ProductViewFactory
    private let productDataFactory: any ProductDataFactory
    
    init(productViewFactory: any ProductViewFactory, productDataFactory: ProductDataFactory) {
        self.productViewFactory = productViewFactory
        self.productDataFactory = productDataFactory
    }
}

/// Helper view just ot show up dynamic switch
struct ProductDetailsPreviewView: View {
    @State private var isProduction: Bool = true
    @State private var isIphone: Bool = false
    
    private var viewFactory: ProductViewFactory {
        isIphone ? IphoneProductsViewFactory() : IPadProductsViewFactory()
    }
    
    private var dataFactory: ProductDataFactory {
        isProduction ? ProductionProductFactory() : DevProductFactory()
    }
    
    var body: some View {
        VStack {
            Toggle(isOn: $isIphone) {
                isIphone ? Text("Switch to ipad") : Text("Switch to iphone")
            }
            
            Toggle(isOn: $isProduction) {
                isProduction ? Text("Prod") : Text("Dev")
            }
            
            ProductsDetailsView(productViewFactory: viewFactory, productDataFactory: dataFactory)
        }
    }
}

struct ProductsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsPreviewView()
    }
}
