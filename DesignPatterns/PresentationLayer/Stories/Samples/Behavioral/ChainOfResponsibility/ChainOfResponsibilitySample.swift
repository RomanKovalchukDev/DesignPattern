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
