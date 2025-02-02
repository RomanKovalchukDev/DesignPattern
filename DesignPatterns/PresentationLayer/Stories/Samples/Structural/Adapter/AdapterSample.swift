//
//  AdapterSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 02.02.2025.
//

/*
 Pattern is used when you need to use non-matching interfaces via an adapter (wrapper).
 */

import Foundation
import SwiftUI

// MARK: - Legacy Support (Legacy AuthManager and Player)

protocol AppPlayerType {
    func play(url: URL)
}

final class LegacyImplementation {
    func play(urlString: String) {
        debugPrint("Playing video from URL: \(urlString)")
    }
}

final class PlayerAdapter: AppPlayerType {
    private let legacyPlayer = LegacyImplementation()

    func play(url: URL) {
        legacyPlayer.play(urlString: url.absoluteString)
    }
}

// MARK: - AuthManager (Modern vs. Legacy Adaptation)

protocol AuthManagerType {
    func showAuthFlow() -> String
}

final class ModernAuthManager: AuthManagerType {
    func showAuthFlow() -> String {
        "Modern Authentication Flow Triggered"
    }
}

final class LegacyAuthManager {
    func loginWithCredentials(username: String, password: String) -> String {
        "Legacy Auth Successful for: \(username)"
    }
}

final class LegacyAuthAdapter: AuthManagerType {
    private let legacyAuth = LegacyAuthManager()

    func showAuthFlow() -> String {
        legacyAuth.loginWithCredentials(username: "user@example.com", password: "password123")
    }
}

// MARK: - SwiftUI View Demonstration

struct ContentView: View {
    @State private var authMessage: String = ""
    @State private var showingAlert = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Choose Authentication Flow")
                .font(.headline)

            Button(
                action: {
                    let modernAuth = ModernAuthManager()
                    authMessage = modernAuth.showAuthFlow()
                    showingAlert = true
                },
                label: {
                    Text("Modern Auth")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            )

            Button(
                action: {
                    let legacyAuthAdapter = LegacyAuthAdapter()
                    authMessage = legacyAuthAdapter.showAuthFlow()
                    showingAlert = true
                },
                label: {
                    Text("Legacy Auth (Adapted)")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            )
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Authentication Result"), message: Text(authMessage), dismissButton: .default(Text("OK")))
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
