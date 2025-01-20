//
//  RootRoutingView.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 19.01.2025.
//

import SwiftUI
import NerdzInject

struct RootRoutingView: View {
    
    @StateObject var router: Router<RootRoute>
    
    var body: some View {
        RoutingView(RootRoute.self) { router in
            router.view(for: .patternList)
        }
    }
    
    // MARK: - Life cycle
    
    init(router: Router<RootRoute>) {
        _router = StateObject(wrappedValue: router)
        
        setup()
    }
    
    // MARK: - Methods(private)
    
    private func setup() {
        setupDependencies()
    }
    
    private func setupDependencies() {
        NerdzInject.shared.registerObject(DesignPatternsRepository(), for: (any DesignPatternsRepositoryType).self)
    }
}
