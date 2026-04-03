//
//  CheatSheetView.swift
//  DesignPatterns
//
//  Created by Claude Code on 03.04.2026.
//

import SwiftUI
import SFSafeSymbols
import NerdzInject

struct CheatSheetView: View {
    // MARK: - Properties(public)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                createHeaderView()

                ForEach([DesignPatternCategory.creational, .structural, .behavioral, .architectural], id: \.self) { category in
                    createCategorySection(for: category)
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Quick Reference")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            loadPatterns()
        }
    }

    // MARK: - Properties(private)

    @State private var patterns: [DesignPatternModel] = []

    private var repository: any DesignPatternsRepositoryType {
        NerdzInject.shared.resolve(by: (any DesignPatternsRepositoryType).self) ?? DesignPatternsRepository()
    }

    // MARK: - Views

    @ViewBuilder
    private func createHeaderView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemSymbol: .docTextMagnifyingglass)
                    .font(.system(size: 32))
                    .foregroundStyle(.blue)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Design Patterns")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Quick Reference Guide")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Text("23 Gang of Four patterns organized by category. Tap any pattern for detailed information.")
                .font(.caption)
                .foregroundStyle(.tertiary)
                .padding(.top, 4)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemGroupedBackground))
        )
    }

    @ViewBuilder
    private func createCategorySection(for category: DesignPatternCategory) -> some View {
        let categoryPatterns = patterns.filter { $0.category == category }

        if !categoryPatterns.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                // Category header
                HStack(spacing: 8) {
                    Image(systemSymbol: category.icon)
                        .font(.system(size: 20))
                        .foregroundStyle(category.displayColor)

                    Text(category.displayTitle)
                        .font(.title3)
                        .fontWeight(.bold)

                    Spacer()

                    Text("\(categoryPatterns.count)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Capsule().fill(category.displayColor))
                }

                // Patterns grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    ForEach(categoryPatterns, id: \.name) { pattern in
                        createPatternCard(pattern: pattern, category: category)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.secondarySystemGroupedBackground))
            )
        }
    }

    @ViewBuilder
    private func createPatternCard(pattern: DesignPatternModel, category: DesignPatternCategory) -> some View {
        NavigationLink(destination: createPatternDetailsView(for: pattern)) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemSymbol: pattern.icon)
                        .font(.system(size: 24))
                        .foregroundStyle(category.displayColor)

                    Spacer()

                    Image(systemSymbol: .chevronRight)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.tertiary)
                }

                Text(pattern.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(.primary)

                Text(pattern.intent)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                    .frame(height: 36, alignment: .top)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.tertiarySystemGroupedBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(category.displayColor.opacity(0.2), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    @ViewBuilder
    private func createPatternDetailsView(for pattern: DesignPatternModel) -> some View {
        PatternDetailsView(
            viewModel: PatternDetailsViewModel(
                rawData: pattern,
                router: Router<RootRoute>(isPresented: .constant(nil))
            )
        )
    }

    // MARK: - Methods(private)

    private func loadPatterns() {
        patterns = (try? repository.getDesignPatters()) ?? []
    }
}

struct CheatSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheatSheetView()
        }
    }
}
