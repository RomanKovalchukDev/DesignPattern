//
//  CodeSamplesView.swift
//  DesignPatterns
//
//  Created by Claude Code on 03.04.2026.
//

import SwiftUI
import SFSafeSymbols

struct CodeSamplesView: View {
    // MARK: - Properties(public)

    let patternName: String
    let categoryColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let markdown = PatternCodeSamplesProvider.getMarkdown(for: patternName) {
                MarkdownCodeView(markdown: markdown, categoryColor: categoryColor)
            } else {
                createEmptyState()
            }
        }
    }

    // MARK: - Views

    @ViewBuilder
    private func createEmptyState() -> some View {
        VStack(spacing: 12) {
            Image(systemSymbol: .docTextMagnifyingglass)
                .font(.system(size: 48))
                .foregroundStyle(.tertiary)

            Text("Code samples coming soon")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text("Implementation examples for this pattern are being prepared.")
                .font(.subheadline)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

struct CodeSamplesView_Previews: PreviewProvider {
    static var previews: some View {
        CodeSamplesView(
            patternName: "Singleton",
            categoryColor: .blue
        )
        .previewLayout(.sizeThatFits)
    }
}
