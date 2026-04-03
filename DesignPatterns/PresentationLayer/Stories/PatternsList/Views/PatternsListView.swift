//
//  PatternsListView.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 19.01.2025.
//

import SwiftUI
import Combine
import SwiftMessages
import SFSafeSymbols

struct PatternsListView<ViewModel: PatternsListViewModelType>: View {
    
    // MARK: - Aliases
    
    typealias ViewModelCreateAction = () -> ViewModel
    
    // MARK: - Properties(public)
    
    var body: some View {
        createListView()
            .navigationTitle("Patterns")
            .task {
                await viewModel.loadPatterns()
            }
    }
    
    // MARK: - Properties(private)
    
    @StateObject private var viewModel: ViewModel
    
    // MARK: - Life cycle
    
    init(viewModel: @autoclosure @escaping ViewModelCreateAction) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private func createListView() -> some View {
        List {
            ForEach(viewModel.patternSections) { section in
                Section(header: createSectionHeaderView(for: section)) {
                    if section.isExpanded {
                        ForEach(section.items) { item in
                            createPatternView(for: item)
                        }
                    }
                }
            }
        }
        .refreshable {
            await viewModel.loadPatterns()
        }
        .listSectionSpacing(.zero)
        .listStyle(.insetGrouped)
    }
    
    @ViewBuilder
    private func createSectionHeaderView(for section: PatternsListSectionDisplayModel) -> some View {
        HStack {
            Image(systemSymbol: section.category.rawData.icon)
                .font(.system(size: 20))
                .foregroundStyle(section.category.rawData.displayColor)

            Text(section.category.displayTitle)
                .font(.headline)
                .foregroundStyle(section.category.rawData.displayColor)

            Spacer()

            Image(
                systemSymbol: section.isExpanded ? SFSymbol.chevronUp : SFSymbol.chevronDown
            )
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(section.category.rawData.displayColor)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(minWidth: 50)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(section.category.rawData.displayColor.opacity(0.1))
        )
        .onTapGesture {
            viewModel.toggleSectionVisibility(for: section)
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
    }
    
    @ViewBuilder
    private func createPatternView(for pattern: PatternsListDisplayModel) -> some View {
        PatternCardView(pattern: pattern)
            .onTapGesture {
                viewModel.patternSelected(pattern)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .listRowBackground(Color.clear)
    }
}

struct PatternsListView_Previews: PreviewProvider {
    static var previews: some View {
        PatternsListView(viewModel: MockPatternsListViewModel())
    }
}
