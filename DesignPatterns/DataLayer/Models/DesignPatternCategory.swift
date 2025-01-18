//
//  DesignPatternCategory.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 18.01.2025.
//

enum DesignPatternCategory {
    case creational
    case structural
    case behavioral
    case architectural
    
    init(response: DesignPatternCategoryResponse) {
        switch response {
        case .creational:
            self = .creational
            
        case .behavioral:
            self = .behavioral
            
        case .structural:
            self = .structural
            
        case .architectural:
            self = .architectural
        }
    }
}
