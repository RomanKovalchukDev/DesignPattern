//
//  PatternDetailSectionType.swift
//  DesignPatterns
//
//  Created by Claude Code on 03.04.2026.
//

import Foundation

enum PatternDetailSectionType: String, CaseIterable, Identifiable {
    case overview
    case structure
    case diagram
    case code

    // MARK: - Properties(public)

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .overview:
            return "Overview"

        case .structure:
            return "Structure"

        case .diagram:
            return "Diagram"

        case .code:
            return "Code"
        }
    }
}
