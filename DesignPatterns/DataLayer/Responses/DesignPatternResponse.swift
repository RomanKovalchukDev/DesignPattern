//
//  DesignPatternResponse.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 18.01.2025.
//

struct DesignPatternResponse: Decodable {
    let name: String
    let category: DesignPatternCategoryResponse
    let shortDescription: String
    let intent: String
    let applicability: String
    let structure: String
    let participants: [String]
    let collaboration: String?
    let implementation: String
    let knownUses: [String]
    let relatedPatterns: [String]
}
