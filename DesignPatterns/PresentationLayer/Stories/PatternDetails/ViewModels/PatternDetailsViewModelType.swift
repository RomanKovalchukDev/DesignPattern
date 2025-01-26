//
//  PatternDetailsViewModelType.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

import SwiftUI

protocol PatternDetailsViewModelType: ObservableObject, AppMessagableViewModelType {
    var name: String { get }
    var categoryName: String { get }
    var displayDescription: String { get }
}
