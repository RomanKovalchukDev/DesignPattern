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
