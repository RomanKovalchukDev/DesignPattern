//
//  MockPatternDetailsViewModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

import SwiftUI
import SFSafeSymbols

@Observable
final class MockPatternDetailsViewModel: PatternDetailsViewModelType {
    var name: String = "Singleton"
    var categoryName: String = "Creational"
    var categoryColor: Color = .blue
    var categoryIcon: SFSymbol = .starCircleFill
    var displayDescription: String = "Ensures a class has only one instance and provides a global point of access to it."
    var intent: String = "Restrict the instantiation of a class to one single instance, providing a global point of access to that instance."
    var applicability: String = "Use when exactly one instance of a class is needed to control actions or states throughout an application."
    var structure: String = "Involves a class that maintains a static reference to its single instance and a method to retrieve it."
    var participants: [String] = [
        "Singleton: Defines the static method for accessing the instance",
        "Client: Requests the Singleton instance whenever needed"
    ]
    var collaboration: String? = "The client interacts with the singleton instance by calling a static method."
    var implementation: String = "Create a private static variable for the instance and a public static method to return the instance."
    var knownUses: [String] = [
        "Managing shared resources such as networking clients or database connections",
        "App-wide settings or configurations",
        "Logging systems"
    ]
    var relatedPatterns: [String] = [
        "Abstract Factory: May use Singleton when a single factory instance is required",
        "Lazy Initialization: Often used with Singleton to delay creation"
    ]
    var message: AppMessageDisplayModel?
}
