//
//  FacadeSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 02.02.2025.
//

/*
 Facade used to have one more level of the abstraction above the services, to handle how they should cooperate between one another, our repositories could be considered a facade pattern samples.
 */

import Foundation

enum AnalyticsEventType {
    case testEvent
}

protocol AnalyticsProviderType: AnyObject {
    
    /// Track an event with the given event type.
    /// - Parameter event: The event to track.
    func trackEvent(_ event: AnalyticsEventType)
    
    /// Clear user data that is being tracked by the analytics provider.
    func clearUser()
    
    /// Update user data being tracked by the analytics provider with the given ID and user data.
    /// - Parameters:
    ///   - id: The ID of the user.
    ///   - userData: The user data to update.
    func updateUser(with id: String, userData: [String: Any])
}

protocol AnalyticsServiceType: AnyObject {
    init(analyticsProviders: [AnalyticsProviderType])
    
    func logEvent(_ event: AnalyticsEventType)
}

/// App analytics service implementation
final class AnalyticsService: NSObject, AnalyticsServiceType {
        
    private let providers: [any AnalyticsProviderType]
    
    /// Initializes an instance of an analytics service with the given parameters.
    /// - Parameter analyticsProviders: An array of objects that conform to the `AnalyticsProviderType` protocol.
    init(analyticsProviders: [AnalyticsProviderType]) {
        self.providers = analyticsProviders
        
        super.init()
        
        subscribeToListeners()
    }
    
    /// Logs an event to all the analytics providers.
    /// - Parameter event: An `AnalyticsEventType` that defines the event to log.
    func logEvent(_ event: AnalyticsEventType) {
        for provider in providers {
            provider.trackEvent(event)
        }
    }
    
    /// Method that listens to user events
    private func subscribeToListeners() {
    }
}
