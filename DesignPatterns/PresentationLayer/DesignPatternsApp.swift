//
//  DesignPatternsApp.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 17.01.2025.
//

import SwiftUI

@main
struct DesignPatternsApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RootViewModel())
        }
    }
}
