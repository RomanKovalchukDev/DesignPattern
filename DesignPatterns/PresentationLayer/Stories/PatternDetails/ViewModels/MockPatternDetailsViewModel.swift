//
//  MockPatternDetailsViewModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

import SwiftUI

@Observable
final class MockPatternDetailsViewModel: PatternDetailsViewModelType {
    var name: String = "Pattern"
    var categoryName: String = "Category"
    var displayDescription: String = "Description"
    var message: AppMessageDisplayModel?
}
