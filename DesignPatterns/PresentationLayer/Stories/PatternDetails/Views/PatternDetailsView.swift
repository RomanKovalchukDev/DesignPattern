//
//  PatternDetailsView.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

import SwiftUI

struct PatternDetailsView<ViewModel: PatternDetailsViewModelType>: View {
    // MARK: - Aliases
    
    typealias ViewModelCreateAction = () -> ViewModel
    
    // MARK: - Properties(public)
    
    var body: some View {
        createDetailsView()
            .navigationTitle(viewModel.name)
    }
    
    // MARK: - Properties(private)
    
    @StateObject private var viewModel: ViewModel
    
    // MARK: - Life cycle
    
    init(viewModel: @autoclosure @escaping ViewModelCreateAction) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private func createDetailsView() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                // Category with smaller, secondary text style
                Text(.localizable(.patternDetailsCattegory(viewModel.categoryName)))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Description with readable font and line spacing
                Text(.localizable(.patternDetailsDescription(viewModel.displayDescription)))
                    .font(.body)
                    .lineSpacing(4)
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground))
    }
}

struct PatternDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PatternDetailsView(viewModel: MockPatternDetailsViewModel())
    }
}
