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
            Text(section.category.displayTitle)
            Spacer()
            Image(
                systemSymbol: section.isExpanded ? SFSymbol.arrowUp : SFSymbol.arrowDown
            )
            .tint(Color(.midnightGreen))
        }
        .frame(minWidth: 50)
        .onTapGesture {
            viewModel.toggleSectionVisibility(for: section)
        }
        .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
    }
    
    @ViewBuilder
    private func createPatternView(for pattern: PatternsListDisplayModel) -> some View {
        Text(pattern.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .onTapGesture {
                viewModel.patternSelected(pattern)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
    }
}

struct PatternsListView_Previews: PreviewProvider {
    static var previews: some View {
        PatternsListView(viewModel: MockPatternsListViewModel())
    }
}
