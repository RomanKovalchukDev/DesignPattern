# Prototype

## Overview

The Prototype pattern creates new objects by copying existing ones. In Swift, this can be implemented using NSCopying protocol or copy initializers.

## Swift Implementation

### PrototypeSample.swift

```swift
//
//  PrototypeSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

/*
 This pattern is used when you need to copy any object. Foundation has protocol NSCopying, that you could implement by your type.
 There is also implementation of copy init that you could implement. I don't like the approach of NSCopying due to
 */

// MARK: - Sample

import Foundation

protocol Clonable {
    func clone() -> Self
}

final class User: NSCopying, Clonable {
    let id: Int
    let name: String
    let age: Int
    
    init(id: Int, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
    
    init(user: User) {
        self.id = user.id
        self.name = user.name
        self.age = user.age
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        User(id: self.id, name: self.name, age: self.age)
    }
    
    func clone() -> User {
        User(id: self.id, name: self.name, age: self.age)
    }
}

```

## Key Points

- Study the code structure and relationships between components
- Notice how the pattern promotes loose coupling and flexibility
- Consider when this pattern would be useful in your own projects
- Experiment by modifying the code to fit your use cases
