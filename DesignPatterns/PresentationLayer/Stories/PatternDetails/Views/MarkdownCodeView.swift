//
//  MarkdownCodeView.swift
//  DesignPatterns
//
//  Created by Claude Code on 03.04.2026.
//

import SwiftUI

struct MarkdownCodeView: View {
    // MARK: - Properties(public)

    let markdown: String
    let categoryColor: Color

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(parseMarkdown(), id: \.id) { block in
                    switch block.type {
                    case .heading1:
                        Text(block.content)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .padding(.top, 8)

                    case .heading2:
                        Text(block.content)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(categoryColor)
                            .padding(.top, 12)

                    case .heading3:
                        Text(block.content)
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                            .padding(.top, 8)

                    case .paragraph:
                        Text(block.content)
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .lineSpacing(4)

                    case .code:
                        createCodeBlock(block.content)

                    case .bulletList:
                        createBulletListItem(block.content)
                    }
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
    }

    // MARK: - Methods(private)

    @ViewBuilder
    private func createCodeBlock(_ code: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(code.components(separatedBy: .newlines).enumerated()), id: \.offset) { index, line in
                HStack(alignment: .top, spacing: 8) {
                    // Line number
                    Text("\(index + 1)")
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(.tertiary)
                        .frame(width: 40, alignment: .trailing)

                    // Code line
                    Text(line)
                        .font(.system(.callout, design: .monospaced))
                        .textSelection(.enabled)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemGray6))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(UIColor.separator), lineWidth: 1)
        )
    }

    @ViewBuilder
    private func createBulletListItem(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "circle.fill")
                .font(.system(size: 6))
                .foregroundStyle(categoryColor)
                .padding(.top, 6)

            Text(text)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding(.leading, 8)
    }

    private func parseMarkdown() -> [MarkdownBlock] {
        var blocks: [MarkdownBlock] = []
        let lines = markdown.components(separatedBy: .newlines)
        var currentCodeBlock: String?
        var inCodeBlock = false

        for line in lines {
            // Code block delimiter
            if line.hasPrefix("```") {
                if inCodeBlock {
                    // End code block
                    if let code = currentCodeBlock {
                        blocks.append(MarkdownBlock(type: .code, content: code))
                    }
                    currentCodeBlock = nil
                    inCodeBlock = false
                } else {
                    // Start code block
                    inCodeBlock = true
                    currentCodeBlock = ""
                }
                continue
            }

            // Inside code block
            if inCodeBlock {
                if currentCodeBlock == nil {
                    currentCodeBlock = line
                } else {
                    currentCodeBlock? += "\n" + line
                }
                continue
            }

            // Empty line
            if line.trimmingCharacters(in: .whitespaces).isEmpty {
                continue
            }

            // Headings
            if line.hasPrefix("# ") {
                blocks.append(MarkdownBlock(type: .heading1, content: String(line.dropFirst(2))))
            } else if line.hasPrefix("## ") {
                blocks.append(MarkdownBlock(type: .heading2, content: String(line.dropFirst(3))))
            } else if line.hasPrefix("### ") {
                blocks.append(MarkdownBlock(type: .heading3, content: String(line.dropFirst(4))))
            } else if line.hasPrefix("- ") {
                blocks.append(MarkdownBlock(type: .bulletList, content: String(line.dropFirst(2))))
            } else {
                blocks.append(MarkdownBlock(type: .paragraph, content: line))
            }
        }

        return blocks
    }
}

// MARK: - Supporting Types

private struct MarkdownBlock {
    let id = UUID()
    let type: BlockType
    let content: String

    enum BlockType {
        case heading1
        case heading2
        case heading3
        case paragraph
        case code
        case bulletList
    }
}

struct MarkdownCodeView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownCodeView(
            markdown: """
            # Singleton Pattern

            ## Overview
            The Singleton pattern ensures only one instance exists.

            ## Swift Implementation

            ```swift
            class Singleton {
                static let shared = Singleton()
                private init() {}
            }
            ```

            ## Key Points
            - Only one instance
            - Global access point
            - Lazy initialization
            """,
            categoryColor: .blue
        )
    }
}
