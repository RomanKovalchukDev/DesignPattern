//
//  PatternsListSectionDisplayModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 19.01.2025.
//

import Foundation

struct PatternsListSectionDisplayModel: Identifiable {
    let id: String = UUID().uuidString
    let category: PatternsListCategoryDisplayModel
    let items: [PatternsListDisplayModel]
    var isExpanded: Bool
}

extension PatternsListSectionDisplayModel {
    static func getStub(for category: DesignPatternCategory, numberOfItems: Int) -> PatternsListSectionDisplayModel {
        let mappedCategory: PatternsListCategoryDisplayModel = .init(model: category)
        
        let items = (0..<numberOfItems).map { index in
            PatternsListDisplayModel.getStub(withTitle: "Item \(index)", category: category)
        }
        
        return PatternsListSectionDisplayModel(category: mappedCategory, items: items, isExpanded: true)
    }
}
