//
//  BridgeSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 02.02.2025.
//

/*
 The Bridge pattern is especially useful when dealing with cross-platform apps, supporting multiple types of database servers or working with several API providers of a certain kind (for example, cloud platforms, social networks, etc.)
 */

import SwiftUI

protocol Theme {
    var backgroundColor: Color { get }
    var foregroundColor: Color { get }
}

class LightTheme: Theme {
    var backgroundColor: Color { .white }
    var foregroundColor: Color { .black }
}

class DarkTheme: Theme {
    var backgroundColor: Color { .black }
    var foregroundColor: Color { .white }
}

protocol ThemedComponent {
    var theme: Theme { get }
    
    func renderView() -> AnyView
}

class ThemedButton: ThemedComponent {
    let theme: Theme
    let title: String
    
    init(theme: Theme, title: String) {
        self.theme = theme
        self.title = title
    }
    
    func renderView() -> AnyView {
        AnyView(
            Button(
                action: {
                    debugPrint("\(self.title) button pressed")
                },
                label: {
                    Text(title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(theme.backgroundColor)
                        .foregroundColor(theme.foregroundColor)
                        .cornerRadius(10)
                }
            )
        )
    }
}

class ThemedText: ThemedComponent {
    let theme: Theme
    let text: String

    init(theme: Theme, text: String) {
        self.theme = theme
        self.text = text
    }

    func renderView() -> AnyView {
        AnyView(
            Text(text)
                .padding()
                .background(theme.backgroundColor)
                .foregroundColor(theme.foregroundColor)
                .cornerRadius(10)
        )
    }
}

struct BridgeSampleView: View {
    @State private var isDarkMode = false

    var body: some View {
        let theme: Theme = isDarkMode ? DarkTheme() : LightTheme()
        
        VStack(spacing: 20) {
            ThemedButton(theme: theme, title: "Themed Button")
                .renderView()
            
            ThemedText(theme: theme, text: "Themed Text")
                .renderView()

            Toggle("Enable Dark Mode", isOn: $isDarkMode)
                .padding()
                .toggleStyle(SwitchToggleStyle(tint: .blue))
        }
        .padding()
        .animation(.easeInOut, value: isDarkMode)
    }
}

struct BridgeSampleView_Previews: PreviewProvider {
    static var previews: some View {
        BridgeSampleView()
    }
}
