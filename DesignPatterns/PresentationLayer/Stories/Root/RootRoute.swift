//
//  RootRoute.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 19.01.2025.
//

import SwiftUI

enum RootRoute: Routable {
    case patternList
    case patternDetails(model: DesignPatternModel)
    
    // MARK: - Properties(public)
    
    var navigationType: NavigationType {
        .push
    }
    
    // MARK: - Methods(static)
    
    static func == (lhs: RootRoute, rhs: RootRoute) -> Bool {
        switch (lhs, rhs) {
        case (.patternList, .patternList):
            return true
            
        case (.patternDetails(let lhsModel), .patternDetails(let rhsModel)):
            return lhsModel.name == rhsModel.name
            
        default:
            return false
        }
    }
    
    // MARK: - Methods(public)
    
    @MainActor
    @ViewBuilder
    func viewToDisplay(router: Router<RootRoute>) -> some View {
        switch self {
        case .patternList:
            createPatternListView(with: router)
            
        case .patternDetails(let model):
            createPatternDetailsView(with: router, for: model)
        }
    }
    
    // MARK: - Methods(private)
    
    @MainActor
    @ViewBuilder
    private func createPatternListView(with router: Router<RootRoute>) -> some View {
        PatternsListView(viewModel: PatternsListViewModel(router: router))
    }
    
    @MainActor
    @ViewBuilder
    private func createPatternDetailsView(
        with router: Router<RootRoute>,
        for model: DesignPatternModel
    ) -> some View {
        PatternDetailsView(viewModel: PatternDetailsViewModel(rawData: model, router: router))
    }
}
