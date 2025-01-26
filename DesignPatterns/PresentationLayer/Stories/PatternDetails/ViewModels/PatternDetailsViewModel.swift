//
//  PatternDetailsViewModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

import SwiftUI
import Combine

extension DesignPatternCategory {
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
}

extension DesignPatternModel {
    var detailsDescription: String {
        let participantsText = "Pattern participants: \n-" + participants.joined(separator: "\n-")
        let descriptionFields: [String] = [
            shortDescription,
            intent,
            applicability,
            structure,
            participantsText,
            collaboration ?? "",
            implementation
        ]
        
        return descriptionFields.joined(separator: "\n")
    }
}

final class PatternDetailsViewModel: PatternDetailsViewModelType {
    
    // MARK: - Properties(public)
    
    @Published var name: String
    @Published var categoryName: String
    @Published var displayDescription: String
    @Published var message: AppMessageDisplayModel?
    
    // MARK: - Properties(private)
    
    @StateObject private var router: Router<RootRoute>
    
    private let rawData: DesignPatternModel
    
    // MARK: - Life cycle
    
    init(rawData: DesignPatternModel, router: Router<RootRoute>) {
        self.rawData = rawData
        self.name = rawData.name
        self.categoryName = rawData.category.displayTitle
        self.displayDescription = rawData.detailsDescription
        self._router = StateObject(wrappedValue: router)
    }
}
