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
    var patternSections: [PatternsListSectionModel] = []
    
    var message: AppMessageDisplayModel?

    @StateObject private var router: Router<RootRoute>
    @ForceInject private var patternsRepository: any DesignPatternsRepositoryType
    
    // MARK: - Life cycle
    
    init(router: Router<RootRoute>) {
        _router = StateObject(wrappedValue: router)
    }
    
    // MARK: - Methods(public)
        
    func loadPatterns() {
        do {
            let models = try patternsRepository.getDesignPatters()
            let mappedModels = models.map(PatternsListDisplayModel.init)
            let sections = Dictionary(grouping: mappedModels, by: \.category)
                .map { (key: PatternsListCategoryModel, value: [PatternsListDisplayModel]) in
                    PatternsListSectionModel(category: key, items: value, isExpanded: false)
                }
            
            patternSections = sections
        }
        catch {
            message = AppMessageDisplayModel(error: error.localizedDescription)
        }
    }
    
    func togleSectionVisibility(for section: PatternsListSectionModel) {
        guard let index = patternSections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        patternSections[index].isExpanded.toggle()
    }
    
    func patternSelected(_ pattern: PatternsListDisplayModel) {
        router.routeTo(.patternDetails(model: pattern.rawData))
    }
}
