# Flyweight

## Overview

The Flyweight pattern uses sharing to support large numbers of fine-grained objects efficiently, minimizing memory usage.

## Swift Implementation

### FlyweightSample.swift

```swift
//
//  FlyweightSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 02.02.2025.
//

/*
 used to optimize a big memory usage
 */

import SwiftUI

class Icon {
    let imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    func displayIcon() -> Image {
        Image(systemName: imageName)
    }
}

class IconFactory {
    private var icons: [String: Icon] = [:]

    func getIcon(named imageName: String) -> Icon {
        if let cachedIcon = icons[imageName] {
            return cachedIcon
        }
        let newIcon = Icon(imageName: imageName)
        icons[imageName] = newIcon
        return newIcon
    }
}

// SwiftUI View to Demonstrate Flyweight Pattern
struct FlyweightView: View {
    private let iconFactory = IconFactory()
    private let iconNames = ["star.fill", "heart.fill", "bell.fill", "star.fill", "heart.fill"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Flyweight Pattern - Reuse Icons")
                .font(.headline)

            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                ForEach(iconNames, id: \.self) { iconName in
                    let icon = iconFactory.getIcon(named: iconName)
                    icon.displayIcon()
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

// SwiftUI Preview
struct FlyweightView_Previews: PreviewProvider {
    static var previews: some View {
        FlyweightView()
    }
}

```

## Key Points

- Study the code structure and relationships between components
- Notice how the pattern promotes loose coupling and flexibility
- Consider when this pattern would be useful in your own projects
- Experiment by modifying the code to fit your use cases
