//
//  PatternsListCategoryDisplayModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 19.01.2025.
//

import Foundation

enum PatternsListCategoryDisplayModel: Hashable {
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
    
    var sortOrder: Int {
        switch self {
        case .creational:
            return 1
            
        case .structural:
            return 2
            
        case .behavioral:
            return 3
            
        case .architectural:
            return 4
        }
    }
}

extension PatternsListCategoryDisplayModel {
    
    var rawData: DesignPatternCategory {
        switch self {
        case .creational:
            return .creational
            
        case .structural:
            return .structural
            
        case .behavioral:
            return .behavioral
            
        case .architectural:
            return .architectural
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
