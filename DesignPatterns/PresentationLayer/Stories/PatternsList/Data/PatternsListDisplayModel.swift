//
//  PatternsListDisplayModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 19.01.2025.
//

import Foundation

struct PatternsListDisplayModel: Identifiable {
    let id: String = UUID().uuidString
    
    var title: String {
        rawData.name
    }
    
    var category: PatternsListCategoryModel {
        PatternsListCategoryModel(model: rawData.category)
    }
    
    var rawData: DesignPatternModel
}
