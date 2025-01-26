//
//  AppMessagableViewModelType.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 25.01.2025.
//

import SwiftUI

@MainActor
protocol AppMessagableViewModelType: ObservableObject {
    var message: AppMessageDisplayModel? { get set }
}
