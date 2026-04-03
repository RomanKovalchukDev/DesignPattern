# Facade

## Overview

The Facade pattern provides a unified interface to a set of interfaces in a subsystem, making the subsystem easier to use.

## Swift Implementation

### FacadeSample.swift

```swift
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

```

## Key Points

- Study the code structure and relationships between components
- Notice how the pattern promotes loose coupling and flexibility
- Consider when this pattern would be useful in your own projects
- Experiment by modifying the code to fit your use cases
