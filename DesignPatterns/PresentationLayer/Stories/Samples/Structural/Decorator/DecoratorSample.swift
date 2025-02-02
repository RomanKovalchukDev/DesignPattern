//
//  DecoratorSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 02.02.2025.
//

/*
 Any stream related feature, example Combine events with mappers, with catching errors etc. View decorators that modify them.
 */

import SwiftUI

// MARK: - Decorator Protocol
protocol ViewDecorator {
    func apply(to view: AnyView) -> AnyView
}

// MARK: - Concrete Decorators
struct BorderDecorator: ViewDecorator {
    let color: Color
    let width: CGFloat

    func apply(to view: AnyView) -> AnyView {
        AnyView(
            view
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(color, lineWidth: width)
                )
        )
    }
}

struct ShadowDecorator: ViewDecorator {
    let color: Color
    let radius: CGFloat

    func apply(to view: AnyView) -> AnyView {
        AnyView(
            view
                .shadow(color: color, radius: radius)
        )
    }
}

struct PaddingDecorator: ViewDecorator {
    let paddingValue: CGFloat

    func apply(to view: AnyView) -> AnyView {
        AnyView(
            view
                .padding(paddingValue)
        )
    }
}

// MARK: - Core View
struct DecoratedTextView {
    private let text: Text
    private var decorators: [ViewDecorator] = []

    init(_ text: String) {
        self.text = Text(text)
    }

    mutating func addDecorator(_ decorator: ViewDecorator) {
        decorators.append(decorator)
    }

    func build() -> AnyView {
        var decoratedView: AnyView = AnyView(text.font(.title).foregroundColor(.white))
        
        for decorator in decorators {
            decoratedView = decorator.apply(to: decoratedView)
        }
        
        return decoratedView
    }
}

// MARK: - SwiftUI View
struct DecoratorSampleView: View {
    var view: some View {
        var decoratedText = DecoratedTextView("Hello, Decorator Pattern!")
        
        decoratedText.addDecorator(BorderDecorator(color: .blue, width: 3))
        decoratedText.addDecorator(ShadowDecorator(color: .gray, radius: 5))
        decoratedText.addDecorator(PaddingDecorator(paddingValue: 20))
        
        return decoratedText.build()
            .background(Color.blue)
            .cornerRadius(10)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            view
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

// MARK: - Preview
struct DecoratorSampleView_Previews: PreviewProvider {
    static var previews: some View {
        DecoratorSampleView()
    }
}
