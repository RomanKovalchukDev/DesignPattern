//
//  PatternsListViewModelType.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 19.01.2025.
//

import SwiftUI

protocol PatternsListViewModelType: ObservableObject {
    var patternSections: [PatternsListSectionModel] { get }
    var message: AppMessageDisplayModel? { get set }
    
    func loadPatterns()
    func togleSectionVisibility(for section: PatternsListSectionModel)
    func patternSelected(_ pattern: PatternsListDisplayModel)
}
