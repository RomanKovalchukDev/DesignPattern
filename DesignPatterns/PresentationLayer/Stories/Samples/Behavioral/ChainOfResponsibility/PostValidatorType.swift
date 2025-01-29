//
//  PostValidatorType.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 28.01.2025.
//

import Foundation

protocol PostValidatorType: AnyObject {
    var next: (any PostValidatorType)? { get set }
    
    func validate(data: PostCreateData) -> ValidationResult
}

final class PostNameValidator: PostValidatorType {
    var next: (any PostValidatorType)?
    
    func validate(data: PostCreateData) -> ValidationResult {
        if data.name?.isEmpty ?? true {
            return .notValid(errorMessage: "Name is required")
        }
        else if data.name?.count ?? .zero > 100 {
            return .notValid(errorMessage: "Name too long")
        }
        else {
            return next?.validate(data: data) ?? .valid
        }
    }
}

final class PostContentValidator: PostValidatorType {
    var next: (any PostValidatorType)?
    
    func validate(data: PostCreateData) -> ValidationResult {
        if data.content?.isEmpty ?? true {
            return .notValid(errorMessage: "Content is required")
        }
        else if data.name?.count ?? .zero > 1_000 {
            return .notValid(errorMessage: "Content should be less than 1000 characters")
        }
        else {
            return next?.validate(data: data) ?? .valid
        }
    }
}

final class PostImageValidator: PostValidatorType {
    var next: (any PostValidatorType)?
    
    func validate(data: PostCreateData) -> ValidationResult {
        if data.postImage?.count ?? .zero > 10_000_000 {
            return .notValid(errorMessage: "Image too large")
        }
        else {
            return next?.validate(data: data) ?? .valid
        }
    }
}
