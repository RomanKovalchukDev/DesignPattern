//
//  PatternsListSectionModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 19.01.2025.
//

import Foundation

struct PatternsListSectionModel: Identifiable {
    let id: String = UUID().uuidString
    let category: PatternsListCategoryModel
    let items: [PatternsListDisplayModel]
    var isExpanded: Bool
}
