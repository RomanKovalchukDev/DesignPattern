//
//  MainTabView.swift
//  DesignPatterns
//
//  Created by Claude Code on 03.04.2026.
//

import SwiftUI
import SFSafeSymbols

struct MainTabView: View {
    // MARK: - Properties(public)

    var body: some View {
        TabView(selection: $selectedTab) {
            createPatternsTab()
                .tabItem {
                    Label("Patterns", systemSymbol: .squareGrid2x2)
                }
                .tag(Tab.patterns)

            createCheatSheetTab()
                .tabItem {
                    Label("Cheat Sheet", systemSymbol: .docTextMagnifyingglass)
                }
                .tag(Tab.cheatSheet)

            createAboutTab()
                .tabItem {
                    Label("About", systemSymbol: .infoCircle)
                }
                .tag(Tab.about)
        }
    }

    // MARK: - Properties(private)

    @State private var selectedTab: Tab = .patterns

    // MARK: - Internal types

    enum Tab {
        case patterns
        case cheatSheet
        case about
    }

    // MARK: - Views

    @ViewBuilder
    private func createPatternsTab() -> some View {
        RoutingView(RootRoute.self) { router in
            router.view(for: .patternList)
        }
    }

    @ViewBuilder
    private func createCheatSheetTab() -> some View {
        NavigationView {
            CheatSheetView()
        }
    }

    @ViewBuilder
    private func createAboutTab() -> some View {
        NavigationView {
            AboutView(selectedTab: $selectedTab)
        }
    }
}

// MARK: - Supporting Views

private struct AboutView: View {
    @Binding var selectedTab: MainTabView.Tab

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemSymbol: .bookFill)
                            .font(.system(size: 48))
                            .foregroundStyle(.blue)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Design Patterns")
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("Learning Reference")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 8)

                    Text("A comprehensive guide to 23 Gang of Four design patterns with real-world Swift examples.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .lineSpacing(4)
                }
                .padding(.vertical, 8)
            }

            Section("Pattern Categories") {
                Button {
                    selectedTab = .patterns
                } label: {
                    InfoRow(
                        icon: .hammerFill,
                        color: Color(red: 0.0, green: 0.478, blue: 1.0),
                        title: "Creational",
                        subtitle: "5 patterns"
                    )
                }

                Button {
                    selectedTab = .patterns
                } label: {
                    InfoRow(
                        icon: .squareGrid3x3Fill,
                        color: Color(red: 0.204, green: 0.780, blue: 0.349),
                        title: "Structural",
                        subtitle: "7 patterns"
                    )
                }

                Button {
                    selectedTab = .patterns
                } label: {
                    InfoRow(
                        icon: .gearshapeFill,
                        color: Color(red: 0.686, green: 0.322, blue: 0.871),
                        title: "Behavioral",
                        subtitle: "11 patterns"
                    )
                }
            }

            Section("Features") {
                InfoRow(
                    icon: .docText,
                    color: .orange,
                    title: "Detailed Descriptions",
                    subtitle: "Learn when and how to use each pattern"
                )

                InfoRow(
                    icon: .chevronLeftForwardslashChevronRight,
                    color: .purple,
                    title: "Code Examples",
                    subtitle: "Real-world Swift implementations"
                )

                InfoRow(
                    icon: .squareSplit2x2,
                    color: .green,
                    title: "Structure Diagrams",
                    subtitle: "Visual pattern relationships"
                )
            }

            Section("Developer") {
                if let githubURL = URL(string: "https://github.com/RomanKovalchukDev") {
                    Link(destination: githubURL) {
                        HStack(spacing: 12) {
                            Image(systemSymbol: .personCropCircle)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .background(Color.black)
                                .cornerRadius(18)

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Roman Kovalchuk")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)

                                Text("@RomanKovalchukDev")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Image(systemSymbol: .arrowUpRight)
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }

            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text("Version 2.0")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text("Based on Design Patterns: Elements of Reusable Object-Oriented Software")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("About")
    }
}

private struct InfoRow: View {
    let icon: SFSymbol
    let color: Color
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemSymbol: icon)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 36, height: 36)
                .background(color)
                .cornerRadius(18)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutView(selectedTab: .constant(.about))
        }
    }
}
