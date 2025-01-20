//
//  DesignPatternModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 18.01.2025.
//

struct DesignPatternModel {
    let name: String
    let category: DesignPatternCategory
    let shortDescription: String
    let intent: String
    let applicability: String
    let structure: String
    let participants: [String]
    let collaboration: String
    let implementation: String
    let knownUses: [String]
    let relatedPatterns: [String]
    
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
    
    init(response: DesignPatternResponse) {
        self.name = response.name
        self.category = DesignPatternCategory(response: response.category)
        self.shortDescription = response.shortDescription
        self.intent = response.intent
        self.applicability = response.applicability
        self.structure = response.structure
        self.participants = response.participants
        self.collaboration = response.collaboration
        self.implementation = response.implementation
        self.knownUses = response.knownUses
        self.relatedPatterns = response.relatedPatterns
    }
}
