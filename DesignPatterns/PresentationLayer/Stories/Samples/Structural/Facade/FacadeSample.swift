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

// Subsystems
class GoogleAnalytics {
    func trackEvent(_ event: String) {
        print("Google Analytics: Tracking event '\(event)'")
    }
}

class FirebaseAnalytics {
    func logEvent(_ event: String) {
        print("Firebase: Logging event '\(event)'")
    }
}

// Facade
class AnalyticsFacade {
    private let googleAnalytics = GoogleAnalytics()
    private let firebaseAnalytics = FirebaseAnalytics()

    func logEvent(_ event: String) {
        googleAnalytics.trackEvent(event)
        firebaseAnalytics.logEvent(event)
    }
}
