//
//  DesignPatternCategoryResponse.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 18.01.2025.
//

enum DesignPatternCategoryResponse: String, Decodable {
    case creational = "Creational"
    case behavioral = "Behavioral"
    case structural = "Structural"
    case architectural = "Architectural"
}
