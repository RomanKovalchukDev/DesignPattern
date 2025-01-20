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
        List {
            ForEach(viewModel.patternSections) { section in
                Section(header: createSectionHeaderView(for: section)) {
                    ForEach(section.items) { item in
                        createPatternView(for: item)
                            .background(Color.red)
                    }
                }
            }
        }
        .background(Color(.antiFlashWhite))
        .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
        .onAppear {
            Task {
                viewModel.loadPatterns()
            }
        }
//        .swiftMessage(message: $viewModel.message) { message in
//            Text(message.text)
//                .foregroundStyle(Color.red)
//                .background(Color(.accent))
//        }
    }
    
    // MARK: - Properties(private)
    
    @StateObject private var viewModel: ViewModel
    
    // MARK: - Life cycle
    
    init(viewModel: @autoclosure @escaping ViewModelCreateAction) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    // MARK: - Views
    
    @ViewBuilder
    func createSectionHeaderView(for section: PatternsListSectionModel) -> some View {
        HStack {
            Text(section.category.displayTitle)
            Spacer()
            Image(systemSymbol: section.isExpanded ? SFSymbol.arrowUp : SFSymbol.arrowDown)
                .tint(Color(.midnightGreen))
        }.background(Color(.accent))
    }
    
    @ViewBuilder
    func createPatternView(for pattern: PatternsListDisplayModel) -> some View {
        Text(pattern.title)
            .background(Color(.antiFlashWhite))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .listRowBackground(Color.green)
            .listRowSeparator(.hidden)
//            .frame(alignment: .leading)
            .onTapGesture {
                viewModel.patternSelected(pattern)
            }
    }
}

class Mock: PatternsListViewModelType {
    var patternSections: [PatternsListSectionModel] = [
        PatternsListSectionModel(
            category: .architectural,
            items: [
                PatternsListDisplayModel(rawData: DesignPatternModel(name: "XD", category: .architectural)),
                PatternsListDisplayModel(rawData: DesignPatternModel(name: "XD", category: .architectural)),
                PatternsListDisplayModel(rawData: DesignPatternModel(name: "XD", category: .architectural))
            ],
            isExpanded: true
        )
    ]
    
    var message: AppMessageDisplayModel?
    
    func loadPatterns() {
//        patternSections =
    }
    
    func togleSectionVisibility(for section: PatternsListSectionModel) {
    }
    
    func patternSelected(_ pattern: PatternsListDisplayModel) {
    }
}

#Preview {
    let model = DesignPatternModel(name: "Test", category: .architectural)
    let test = PatternsListDisplayModel(rawData: model)
    let section = PatternsListSectionModel(category: .architectural, items: [test], isExpanded: false)
    PatternsListView<Mock>(viewModel: Mock())
}
