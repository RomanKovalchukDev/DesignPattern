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
    
    var category: PatternsListCategoryDisplayModel {
        PatternsListCategoryDisplayModel(model: rawData.category)
    }
    
    var rawData: DesignPatternModel
}

extension PatternsListDisplayModel {
    static func getStub(withTitle title: String, category: DesignPatternCategory) -> PatternsListDisplayModel {
        let rawData = DesignPatternModel(name: title, category: category)
        return PatternsListDisplayModel(rawData: rawData)
    }
}

extension DesignPatternModel {
    init(
        name: String,
        category: DesignPatternCategory,
        shortDescription: String = "",
        intent: String = "",
        applicability: String = "",
        structure: String = "",
        participants: [String] = [],
        collaboration: String = "",
        implementation: String = "",
        knownUses: [String] = [],
        relatedPatterns: [String] = []
    ) {
        self.name = name
        self.category = category
        self.shortDescription = shortDescription
        self.intent = intent
        self.applicability = applicability
        self.structure = structure
        self.participants = participants
        self.collaboration = collaboration
        self.implementation = implementation
        self.knownUses = knownUses
        self.relatedPatterns = relatedPatterns
    }
}
