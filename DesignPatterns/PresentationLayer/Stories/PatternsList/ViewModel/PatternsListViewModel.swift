//
//  PatternsListViewModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 19.01.2025.
//

import SwiftUI
import Combine
import NerdzInject

final class PatternsListViewModel: PatternsListViewModelType {
    
    // MARK: - Properties(public)
    
    @Published @MainActor var message: AppMessageDisplayModel?
    @Published @MainActor var patternSections: [PatternsListSectionDisplayModel] = []
    
    // MARK: - Properties(private)

    private let router: Router<RootRoute>
    
    // MARK: - Dependencies
    
    @ForceInject private var patternsRepository: any DesignPatternsRepositoryType
    
    // MARK: - Life cycle
    
    init(router: Router<RootRoute>) {
        self.router = router
    }
    
    // MARK: - Methods(public)
        
    func loadPatterns() async {
        do {
            let models = try patternsRepository.getDesignPatters()
            let mappedModels = models.map(PatternsListDisplayModel.init)
            
            let sections = Dictionary(grouping: mappedModels, by: \.category)
                .map { (key: PatternsListCategoryDisplayModel, value: [PatternsListDisplayModel]) in
                    PatternsListSectionDisplayModel(category: key, items: value, isExpanded: true)
                }
                .sorted(by: { $0.category.sortOrder < $1.category.sortOrder })
            
            await MainActor.run { [weak self] in
                self?.patternSections = sections
            }
        }
        catch {
            await MainActor.run { [weak self] in
                self?.message = AppMessageDisplayModel(error: error.localizedDescription)
            }
        }
    }
    
    func toggleSectionVisibility(for section: PatternsListSectionDisplayModel) {
        guard let index = patternSections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        patternSections[index].isExpanded.toggle()
    }
    
    func patternSelected(_ pattern: PatternsListDisplayModel) {
        router.routeTo(.patternDetails(model: pattern.rawData))
    }
}
