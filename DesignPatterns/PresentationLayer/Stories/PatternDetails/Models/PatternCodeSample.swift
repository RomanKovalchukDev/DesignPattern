//
//  PatternCodeSample.swift
//  DesignPatterns
//
//  Created by Claude Code on 03.04.2026.
//

import Foundation

enum PatternCodeSamplesProvider {
    // MARK: - Properties(private)

    private static var cachedMarkdown: [String: String] = [:]

    // MARK: - Methods(public)

    static func getMarkdown(for patternName: String) -> String? {
        // Check cache first
        if let cached = cachedMarkdown[patternName] {
            return cached
        }

        // Load markdown file
        let markdown = loadMarkdown(for: patternName)
        if let markdown = markdown {
            cachedMarkdown[patternName] = markdown
        }
        return markdown
    }

    // MARK: - Methods(private)

    private static func loadMarkdown(for patternName: String) -> String? {
        // Convert pattern name to filename (remove spaces)
        let fileName = patternName.replacingOccurrences(of: " ", with: "")

        // Try multiple locations to find the markdown file
        let possiblePaths = [
            Bundle.main.url(forResource: fileName, withExtension: "md", subdirectory: "SupportingFiles/CodeSamples/Markdown"),
            Bundle.main.url(forResource: fileName, withExtension: "md", subdirectory: "CodeSamples/Markdown"),
            Bundle.main.url(forResource: fileName, withExtension: "md", subdirectory: "Markdown"),
            Bundle.main.url(forResource: fileName, withExtension: "md")
        ]

        for url in possiblePaths {
            if let url = url,
               let markdown = try? String(contentsOf: url, encoding: .utf8) {
                print("✓ Loaded markdown for \(patternName)")
                return markdown
            }
        }

        print("⚠️ Failed to load markdown for \(patternName) (looking for \(fileName).md)")
        return nil
    }
}
