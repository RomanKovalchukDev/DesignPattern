# Interpreter

## Overview

The Interpreter pattern defines a representation for a language's grammar along with an interpreter that uses the representation to interpret sentences in the language.

## Swift Implementation

### InterpreterSample.swift

```swift
//
//  InterpreterSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 Use cases:
 - any expression processing, html to attributed string parser, math expression parser, programming language parser;
 - formatting could be done using this pattern
 */

import SwiftUI

protocol NumberInterpreteur {
    func interpret(number: Decimal) -> String?
}

final class AppPriceInterpreter: NumberInterpreteur {
    
    private let shortingTrashhold: Decimal = 1_000
    
    private let fullNumberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }()
    
    private let shortNubmerFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }()
        
    func interpret(number: Decimal) -> String? {
        if abs(number) > shortingTrashhold {
            return shortNubmerFormatter.string(from: NSDecimalNumber(decimal: number))
        }
        else {
            return fullNumberFormatter.string(from: NSDecimalNumber(decimal: number))
        }
    }
}

```

## Key Points

- Study the code structure and relationships between components
- Notice how the pattern promotes loose coupling and flexibility
- Consider when this pattern would be useful in your own projects
- Experiment by modifying the code to fit your use cases
