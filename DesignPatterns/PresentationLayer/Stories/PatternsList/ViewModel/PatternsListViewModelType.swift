//
//  PatternsListViewModelType.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 19.01.2025.
//

import SwiftUI

@MainActor
protocol PatternsListViewModelType: ObservableObject, AppMessagableViewModelType {
    var patternSections: [PatternsListSectionDisplayModel] { get }
    
    func loadPatterns() async
    func toggleSectionVisibility(for section: PatternsListSectionDisplayModel)
    func patternSelected(_ pattern: PatternsListDisplayModel)
}
