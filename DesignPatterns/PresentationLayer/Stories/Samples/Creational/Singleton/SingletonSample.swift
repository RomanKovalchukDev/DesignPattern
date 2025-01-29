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
