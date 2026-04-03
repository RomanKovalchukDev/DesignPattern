//
//  PatternDetailsViewModelType.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

import SwiftUI
import SFSafeSymbols

protocol PatternDetailsViewModelType: ObservableObject, AppMessagableViewModelType {
    var name: String { get }
    var categoryName: String { get }
    var categoryColor: Color { get }
    var categoryIcon: SFSymbol { get }
    var displayDescription: String { get }
    var intent: String { get }
    var applicability: String { get }
    var structure: String { get }
    var participants: [String] { get }
    var collaboration: String? { get }
    var implementation: String { get }
    var knownUses: [String] { get }
    var relatedPatterns: [String] { get }
}
