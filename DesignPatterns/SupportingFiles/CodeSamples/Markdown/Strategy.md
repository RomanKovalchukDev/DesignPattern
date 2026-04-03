# Strategy

## Overview

The Strategy pattern defines a family of algorithms, encapsulates each one, and makes them interchangeable, letting the algorithm vary independently from clients that use it.

## Swift Implementation

### StrategySample.swift

```swift
//
//  StrategySample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 Different implementation of the same actions, payments using different services, auth using different services, loggin events using different services. Building routes for different traveling methods.
 */

protocol PaymentStrategy {
    func pay(amount: Double)
}

class CreditCardPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using Credit Card.")
    }
}

class PayPalPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using PayPal.")
    }
}

class PaymentProcessor {
    private var strategy: PaymentStrategy

    init(strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    func setStrategy(_ strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    func processPayment(amount: Double) {
        strategy.pay(amount: amount)
    }
}

```

## Common Uses in iOS

- `UITableView` data source and delegate
- Sorting algorithms
- Animation strategies
- Validation strategies
## Key Points

- Study the code structure and relationships between components
- Notice how the pattern promotes loose coupling and flexibility
- Consider when this pattern would be useful in your own projects
- Experiment by modifying the code to fit your use cases
