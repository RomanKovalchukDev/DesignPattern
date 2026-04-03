//
//  SyntaxHighlightedCodeView.swift
//  DesignPatterns
//
//  Created by Claude Code on 03.04.2026.
//

import SwiftUI

struct SyntaxHighlightedCodeView: View {
    // MARK: - Properties(public)

    let code: String

    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(codeLines.enumerated()), id: \.offset) { index, line in
                    HStack(alignment: .top, spacing: 8) {
                        // Line number
                        Text("\(index + 1)")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundStyle(.tertiary)
                            .frame(width: 40, alignment: .trailing)
                            .padding(.trailing, 8)

                        // Code line with syntax highlighting
                        Text(highlightedLine(line))
                            .font(.system(.callout, design: .monospaced))
                            .textSelection(.enabled)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemGray6))
    }

    // MARK: - Properties(private)

    private var codeLines: [String] {
        code.components(separatedBy: .newlines)
    }

    // MARK: - Methods(private)

    private func highlightedLine(_ line: String) -> AttributedString {
        var attributed = AttributedString(line)

        // Single-line comment
        if line.trimmingCharacters(in: .whitespaces).hasPrefix("//") {
            attributed.foregroundColor = Color(red: 0.42, green: 0.51, blue: 0.42) // Green
            return attributed
        }

        // Multi-line comment
        if line.contains("/*") || line.contains("*/") || line.trimmingCharacters(in: .whitespaces).hasPrefix("*") {
            attributed.foregroundColor = Color(red: 0.42, green: 0.51, blue: 0.42) // Green
            return attributed
        }

        // Apply syntax highlighting
        attributed = highlightKeywords(in: attributed, line: line)
        attributed = highlightStrings(in: attributed, line: line)
        attributed = highlightNumbers(in: attributed, line: line)

        return attributed
    }

    private func highlightKeywords(in attributed: AttributedString, line: String) -> AttributedString {
        var result = attributed
        let keywords = [
            "import", "class", "struct", "enum", "protocol", "extension",
            "func", "var", "let", "return", "if", "else", "guard",
            "switch", "case", "default", "for", "while", "repeat",
            "break", "continue", "fallthrough", "throw", "throws",
            "try", "catch", "async", "await", "private", "public",
            "internal", "fileprivate", "static", "final", "override",
            "mutating", "lazy", "weak", "unowned", "self", "Self",
            "init", "deinit", "subscript", "typealias", "associatedtype",
            "some", "any", "in", "is", "as", "where"
        ]

        for keyword in keywords {
            let pattern = "\\b\(keyword)\\b"
            if let regex = try? NSRegularExpression(pattern: pattern) {
                let nsRange = NSRange(line.startIndex..<line.endIndex, in: line)
                let matches = regex.matches(in: line, range: nsRange)

                for match in matches {
                    if let range = Range(match.range, in: line) {
                        let startIndex = AttributedString.Index(range.lowerBound, within: result)
                        let endIndex = AttributedString.Index(range.upperBound, within: result)

                        if let startIndex, let endIndex {
                            result[startIndex..<endIndex].foregroundColor = Color(red: 0.67, green: 0.22, blue: 0.69) // Purple
                        }
                    }
                }
            }
        }

        return result
    }

    private func highlightStrings(in attributed: AttributedString, line: String) -> AttributedString {
        var result = attributed
        let pattern = "\"[^\"]*\""

        if let regex = try? NSRegularExpression(pattern: pattern) {
            let nsRange = NSRange(line.startIndex..<line.endIndex, in: line)
            let matches = regex.matches(in: line, range: nsRange)

            for match in matches {
                if let range = Range(match.range, in: line) {
                    let startIndex = AttributedString.Index(range.lowerBound, within: result)
                    let endIndex = AttributedString.Index(range.upperBound, within: result)

                    if let startIndex, let endIndex {
                        result[startIndex..<endIndex].foregroundColor = Color(red: 0.77, green: 0.13, blue: 0.09) // Red
                    }
                }
            }
        }

        return result
    }

    private func highlightNumbers(in attributed: AttributedString, line: String) -> AttributedString {
        var result = attributed
        let pattern = "\\b[0-9]+\\.?[0-9]*\\b"

        if let regex = try? NSRegularExpression(pattern: pattern) {
            let nsRange = NSRange(line.startIndex..<line.endIndex, in: line)
            let matches = regex.matches(in: line, range: nsRange)

            for match in matches {
                if let range = Range(match.range, in: line) {
                    let startIndex = AttributedString.Index(range.lowerBound, within: result)
                    let endIndex = AttributedString.Index(range.upperBound, within: result)

                    if let startIndex, let endIndex {
                        result[startIndex..<endIndex].foregroundColor = Color(red: 0.11, green: 0.22, blue: 0.60) // Blue
                    }
                }
            }
        }

        return result
    }
}

struct SyntaxHighlightedCodeView_Previews: PreviewProvider {
    static var previews: some View {
        SyntaxHighlightedCodeView(code: """
        import SwiftUI

        // This is a comment
        struct ContentView: View {
            let title: String = "Hello World"
            var count: Int = 42

            var body: some View {
                VStack {
                    Text(title)
                    Text("Count: \\(count)")
                }
            }
        }
        """)
        .previewLayout(.sizeThatFits)
    }
}
