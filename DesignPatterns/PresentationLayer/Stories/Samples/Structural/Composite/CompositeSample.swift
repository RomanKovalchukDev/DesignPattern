//
//  CompositeSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 02.02.2025.
//

/*
 Used to work with tree data structures.
 */

import SwiftUI

// MARK: - Composite Pattern Implementation

protocol ShapeComponent {
    var id: UUID { get }
    
    func drawView(fillColor: Color) -> AnyView
}

// MARK: - Leafs (Circle and Square)

final class Square: ShapeComponent {
    let id = UUID()
    
    func drawView(fillColor: Color) -> AnyView {
        AnyView(
            Rectangle()
                .fill(fillColor)
                .frame(width: 100, height: 100)
                .overlay(
                    Text("Square")
                        .foregroundColor(.white)
                        .bold()
                )
        )
    }
}

final class Circle: ShapeComponent {
    let id = UUID()
    
    func drawView(fillColor: Color) -> AnyView {
        AnyView(
            Ellipse()
                .fill(fillColor)
                .frame(width: 100, height: 100)
                .overlay(
                    Text("Circle")
                        .foregroundColor(.white)
                        .bold()
                )
        )
    }
}

// MARK: - Composite (Whiteboard)

final class Whiteboard: ShapeComponent {
    let id = UUID()
    private var shapes: [ShapeComponent] = []
    
    init(_ shapes: ShapeComponent...) {
        self.shapes = shapes
    }
    
    func drawView(fillColor: Color) -> AnyView {
        AnyView(
            HStack(spacing: 20) {
                ForEach(shapes, id: \.id) { shape in
                    shape.drawView(fillColor: fillColor)
                }
            }
        )
    }
}

// MARK: - SwiftUI View

struct CompositeView: View {
    @State private var whiteboard = Whiteboard(Circle(), Square(), Circle())
    @State private var selectedColor: Color = .red
    
    private let colors: [Color] = [.red, .green, .blue, .yellow, .orange]
    
    var body: some View {
        VStack {
            whiteboard.drawView(fillColor: selectedColor)
            
            Spacer().frame(height: 20)
            
            Button(
                action: {
                    self.selectedColor = colors.randomElement() ?? .red
                },
                label: {
                    Text("Redraw Shapes")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            )
        }
        .padding()
    }
}

// MARK: - Preview

struct CompositeView_Previews: PreviewProvider {
    static var previews: some View {
        CompositeView()
    }
}
