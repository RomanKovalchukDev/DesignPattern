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
