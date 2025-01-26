//
//  DesignPatternsApp.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 17.01.2025.
//

import SwiftUI
import NerdzInject

@main
struct DesignPatternsApp: App {
    
    // MARK: - Properties(public)
    
    var body: some Scene {
        WindowGroup {
            RoutingView(RootRoute.self) { router in
                router.view(for: .patternList)
            }
        }
    }
    
    // MARK: - Internal types
    
    init() {
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
