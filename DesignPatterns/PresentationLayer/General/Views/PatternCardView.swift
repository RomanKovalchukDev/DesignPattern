//
//  PatternCardView.swift
//  DesignPatterns
//
//  Created by Claude Code on 03.04.2026.
//

import SwiftUI
import SFSafeSymbols

struct PatternCardView: View {

    // MARK: - Properties(public)

    let pattern: PatternsListDisplayModel

    var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemSymbol: pattern.icon)
                .font(.system(size: 28))
                .foregroundColor(pattern.categoryColor)
                .frame(width: 44, height: 44)
                .background(pattern.categoryColor.opacity(0.15))
                .cornerRadius(22)

            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(pattern.title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(pattern.shortDescription)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            // Arrow indicator
            Image(systemSymbol: .chevronRight)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(
                    color: Color.black.opacity(0.05),
                    radius: 8,
                    x: 0,
                    y: 2
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color(.separator).opacity(0.2), lineWidth: 1)
        )
    }
}

struct PatternCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 12) {
            PatternCardView(
                pattern: PatternsListDisplayModel(
                    rawData: DesignPatternModel(
                        name: "Abstract Factory",
                        category: .creational,
                        shortDescription: "Provides an interface for creating families of related or dependent objects without specifying their concrete classes."
                    )
                )
            )

            PatternCardView(
                pattern: PatternsListDisplayModel(
                    rawData: DesignPatternModel(
                        name: "Adapter",
                        category: .structural,
                        shortDescription: "Converts the interface of a class into another interface that a client expects."
                    )
                )
            )
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}
