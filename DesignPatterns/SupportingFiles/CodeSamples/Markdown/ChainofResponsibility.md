# Chain of Responsibility

## Overview

The Chain of Responsibility pattern avoids coupling the sender of a request to its receiver by giving more than one object a chance to handle the request.

## Swift Implementation

### ChainOfResponsibilitySample.swift

```swift
//
//  ChainOfResponsibilitySample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 Most common use cases:
 - validation
 - error handling
 - data fetching from different sources
 - loggin of events, network for ex.
 - processing user roles
 */

// MARK: - Samples

import UIKit
import SwiftUI

struct PostCreateData {
    let name: String?
    let content: String?
    let postImage: Data?
}

enum ValidationResult {
    case valid
    case notValid(errorMessage: String)
}

// MARK: - Validators

// MARK: - View

struct PostCreateDataFormView: View {

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Post Details")) {
                    TextField("Name", text: $name)
                        .onChange(of: name) { validateForm() }

                    TextEditor(text: $content)
                        .frame(height: 150)
                        .onChange(of: content) { validateForm() }
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                }

                Section(header: Text("Post Image")) {
                    if let image = postImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(8)
                    }
                    else {
                        Button("Select Image") {
                            showImagePicker.toggle()
                        }
                    }
                }

                if let validationMessage = validationMessage {
                    Section(header: Text("Validation Error")) {
                        Text(validationMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Edit Post")
        }
    }
    
    @State private var name: String = ""
    @State private var content: String = ""
    @State private var postImage: UIImage?
    @State private var showImagePicker: Bool = false
    @State private var validationMessage: String?
    
    private var rootValidator: (any PostValidatorType)?
    
    init() {
        setupValidators()
    }
    
    private mutating func setupValidators() {
        let nameValidator = PostNameValidator()
        let contentValidator = PostContentValidator()
        let imageValidator = PostImageValidator()
        nameValidator.next = contentValidator
        contentValidator.next = imageValidator
        
        self.rootValidator = nameValidator
    }
    
    // Validation logic
    private func validateData(_ data: PostCreateData) -> ValidationResult {
        rootValidator?.validate(data: data) ?? .notValid(errorMessage: "Validation not setuped")
    }

    private func validateForm() {
        let tempData = PostCreateData(
            name: name.isEmpty ? nil : name,
            content: content.isEmpty ? nil : content,
            postImage: postImage?.jpegData(compressionQuality: 1.0)
        )
        
        let validationResult = validateData(tempData)
        
        switch validationResult {
        case .valid:
            self.validationMessage = "Valid"
            
        case .notValid(let errorMessage):
            self.validationMessage = errorMessage
        }
    }
}

struct PostCreateDataFormView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreateDataFormView()
    }
}

// MARK: - Sample 2, data fetching

struct PostFetchingView: View {
    @State private var posts: [PostModel] = []
    
    var body: some View {
        NavigationView {
            List(posts, id: \.id) { post in
                VStack {
                    Text(post.name)
                        .font(.headline)
                    Text(post.contennt)
                        .font(.subheadline)
                }
            }
            .task {
                do {
                    let posts = try await postRepository.getData()
                    
                    await MainActor.run {
                        self.posts = posts
                    }
                }
                catch {
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
    
    private let postRepository = PostRepository()
}

#Preview {
    PostFetchingView()
}

```

### PostModel.swift

```swift
//
//  PostModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 28.01.2025.
//

import Foundation

struct PostModel {
    let id: String
    let name: String
    let contennt: String
    let imageURL: URL?
}

protocol PostProviderType: AnyObject {
    var next: PostProviderType? { get set }
    
    func getData() async throws -> [PostModel]
}

final class LocalDataProvider: PostProviderType {
    var next: (any PostProviderType)?
    
    func getData() async throws -> [PostModel] {
        do {
            let data = [PostModel(id: "123", name: "Name", contennt: "Content", imageURL: nil)]
            
            return data
        }
        catch {
            if let next = next {
                return try await next.getData()
            }
            else {
                throw error
            }
        }
    }
}

final class RemoteDataProvider: PostProviderType {
    enum TestError: LocalizedError {
        case networkError
    }
    
    var next: (any PostProviderType)?
    
    func getData() async throws -> [PostModel] {
        do {
            // Perform some fetching from the server
            throw TestError.networkError
        }
        catch {
            if let next = next {
                return try await next.getData()
            }
            else {
                throw error
            }
        }
    }
}

final class PostRepository {
    private var rootDataProvider: (any PostProviderType)?
    
    init() {
        setup()
    }
    
    func getData() async throws -> [PostModel] {
        try await rootDataProvider?.getData() ?? []
    }
    
    private func setup() {
        let local = LocalDataProvider()
        let remote = RemoteDataProvider()
        remote.next = local
        
        self.rootDataProvider = remote
    }
}

```

### PostValidatorType.swift

```swift
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

```

## Key Points

- Study the code structure and relationships between components
- Notice how the pattern promotes loose coupling and flexibility
- Consider when this pattern would be useful in your own projects
- Experiment by modifying the code to fit your use cases
