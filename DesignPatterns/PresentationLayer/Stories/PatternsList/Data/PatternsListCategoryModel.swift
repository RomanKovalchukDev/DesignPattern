//
//  PatternsListCategoryModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 19.01.2025.
//

import Foundation

enum PatternsListCategoryModel: Hashable {
    case creational
    case structural
    case behavioral
    case architectural
    
    var displayTitle: String {
        switch self {
        case .creational:
            return .localizable(.creationalPaternCategory)
            
        case .structural:
            return .localizable(.structuralPaternCategory)
            
        case .behavioral:
            return .localizable(.behavioralPaternCategory)
            
        case .architectural:
            return .localizable(.architecturalPaternCategory)
        }
    }
    
    init(model: DesignPatternCategory) {
        switch model {
        case .creational:
            self = .creational
            
        case .structural:
            self = .structural
            
        case .behavioral:
            self = .behavioral
            
        case .architectural:
            self = .architectural
        }
    }
}
