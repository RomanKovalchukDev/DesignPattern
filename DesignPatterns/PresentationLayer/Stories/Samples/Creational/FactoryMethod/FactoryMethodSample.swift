//
//  FactoryMethodSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

/*
 Most common use case for this is creating ui components,
 that would return different ui component in the child classses.
 This pattern oftenly mistaken with the other pattern abstract factory, or just factory.
 - Creation of the object, then creation of the different object in child classes. Ex, creation different type of users
 */

// MARK: - Sample

import SwiftUI

// MARK: - Factory Protocol

protocol AppButtonFactoryType {
    func createButton(action: @escaping () -> Void, title: String) -> Button<Text>
}

// MARK: - Concrete Factory: Primary Button

struct PrimaryButtonFactory: AppButtonFactoryType {
    func createButton(action: @escaping () -> Void, title: String) -> Button<Text> {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.blue)
        }
    }
}

// MARK: - Concrete Factory: Secondary Button

struct SecondaryButtonFactory: AppButtonFactoryType {
    func createButton(action: @escaping () -> Void, title: String) -> Button<Text> {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.red)
        }
    }
}

struct FactoryMethodSampleView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            buttonFactory.createButton(
                action: {
                    debugPrint("Primary Button Pressed")
                },
                title: "Primary Button"
            )
            
            buttonFactory.createButton(
                action: {
                    debugPrint("Secondary Button Pressed")
                },
                title: "Secondary Button"
            )
        }
        .padding()
    }
    
    private let buttonFactory: AppButtonFactoryType
    
    init(buttonFactory: AppButtonFactoryType) {
        self.buttonFactory = buttonFactory
    }
}

struct FactoryMethodExampleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FactoryMethodSampleView(buttonFactory: PrimaryButtonFactory())
            FactoryMethodSampleView(buttonFactory: SecondaryButtonFactory())
        }
    }
}

// https://stackoverflow.com/questions/5739611/what-are-the-differences-between-abstract-factory-and-factory-design-patterns
