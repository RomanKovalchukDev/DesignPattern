//
//  RootView.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 17.01.2025.
//

import SwiftUI

struct RootView<ViewModel: RootViewModelType>: View {
    
    // MARK: - Properties(public)
    
    var body: some View {
        Text(String(localizable: .rootScreenTitle))
    }
        
    // MARK: - Properties(private)
    
    @StateObject private var viewModel: ViewModel
    
    // MARK: - Life cycle
    
    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
}

#Preview {
    RootView(viewModel: RootViewModel())
}
