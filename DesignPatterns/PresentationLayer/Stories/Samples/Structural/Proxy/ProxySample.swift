//
//  ProxySample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 02.02.2025.
//

/*
 Data loading with caching, offline mode handling with this, proxy could add loger features to the app services.
 Security proxies - proxy that should limit access depeding on the user rights.
 */

import SwiftUI

// MARK: - Enum for User Rights
enum UserAccessRights {
    case user
    case admin
}

// MARK: - Resource Access Protocol
protocol RestrictedResource {
    func accessResource() -> String
}

// MARK: - Real Resource
class RealResource: RestrictedResource {
    func accessResource() -> String {
        "Access Granted: Viewing Sensitive Data"
    }
}

// MARK: - Security Proxy
class SecurityProxy: RestrictedResource {
    private let realResource = RealResource()
    private let accessRights: UserAccessRights

    init(accessRights: UserAccessRights) {
        self.accessRights = accessRights
    }

    func accessResource() -> String {
        switch accessRights {
        case .admin:
            return realResource.accessResource()

        case .user:
            return "Access Denied: You do not have the necessary permissions"
        }
    }
}

// MARK: - SwiftUI View
struct ProxySampleView: View {
    @State private var accessRights: UserAccessRights = .user
    @State private var accessMessage: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Security Proxy Sample")
                .font(.title)
                .padding()

            // Display Current Access Rights
            Text("Current Access: \(accessRights == .admin ? "Admin" : "User")")
                .font(.headline)

            // Toggle for Access Rights
            Toggle(
                "Switch to Admin Access",
                isOn: Binding(
                    get: { accessRights == .admin },
                    set: { accessRights = $0 ? .admin : .user }
                )
            )
            .padding()
            .toggleStyle(SwitchToggleStyle(tint: .blue))

            // Button to Access Resource
            Button(
                action: {
                    let proxy = SecurityProxy(accessRights: accessRights)
                    accessMessage = proxy.accessResource()
                },
                label: {
                    Text("Access Restricted Resource")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            )
            .padding()

            // Display the Access Result
            Text(accessMessage)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

// MARK: - Preview
struct ProxySampleView_Previews: PreviewProvider {
    static var previews: some View {
        ProxySampleView()
    }
}
