# Singleton

## Overview

The Singleton pattern ensures only one instance of a class exists at a time. While widely popular in iOS infrastructure, it's now often considered an antipattern. Use it sparingly, mainly for services in views.

## Swift Implementation

### SingletonSample.swift

```swift
//
//  SingletonSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 This pattern used to ensure only one object used at the same time. Was widely popular in ios infrastructure. Now it kinda considered as antipattern.
 I'm using this patter when i need to use some service in the view
 */

import UIKit
import SwiftUI

protocol ImageLoader {
    func loadImage() async throws -> UIImage
}

final class SomeLibraryImageLoader: ImageLoader {
    static let shared = SomeLibraryImageLoader()
    
    func loadImage() async throws -> UIImage {
        UIImage()
    }
}

struct SingletonSampleView: View {
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
            }
            else {
                Text("Loading...")
            }
        }
        .task {
            image = try? await SomeLibraryImageLoader.shared.loadImage()
        }
    }
    
    @State private var image: UIImage?
}

```

## Common Uses in iOS

- `URLSession.shared`
- `FileManager.default`
- `UserDefaults.standard`
- `NotificationCenter.default`
## Key Points

- Study the code structure and relationships between components
- Notice how the pattern promotes loose coupling and flexibility
- Consider when this pattern would be useful in your own projects
- Experiment by modifying the code to fit your use cases
