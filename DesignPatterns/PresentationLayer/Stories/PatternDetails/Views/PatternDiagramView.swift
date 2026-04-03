//
//  PatternDiagramView.swift
//  DesignPatterns
//
//  Created by Claude Code on 03.04.2026.
//

import SwiftUI
import SFSafeSymbols

struct PatternDiagramView: View {
    // MARK: - Properties(public)

    let patternName: String
    let categoryColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let plantUMLCode = PatternDiagramProvider.getDiagram(for: patternName) {
                createDiagramSection(plantUMLCode: plantUMLCode)
            } else {
                createNoDiagramView()
            }
        }
    }

    // MARK: - Properties(private)

    @State private var showDiagramCode: Bool = false

    // MARK: - Views

    @ViewBuilder
    private func createDiagramSection(plantUMLCode: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // Diagram title
            HStack {
                Image(systemSymbol: .squareSplit2x2)
                    .font(.system(size: 14))
                    .foregroundStyle(categoryColor)

                Text("UML Class Diagram")
                    .font(.headline)

                Spacer()

                Button {
                    showDiagramCode.toggle()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemSymbol: showDiagramCode ? .eyeSlashFill : .eyeFill)
                            .font(.system(size: 12))

                        Text(showDiagramCode ? "Hide Code" : "Show Code")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundStyle(categoryColor)
                }
            }
            .padding(.horizontal)

            // Diagram image (placeholder for now)
            createDiagramPlaceholder()

            // Optional: Show PlantUML code
            if showDiagramCode {
                createCodeView(plantUMLCode: plantUMLCode)
            }

            createDiagramInfo()
        }
    }

    @ViewBuilder
    private func createDiagramPlaceholder() -> some View {
        let imageName = patternName.replacingOccurrences(of: " ", with: "")

        if let uiImage = loadDiagramImage(named: imageName) {
            ScrollView([.horizontal, .vertical], showsIndicators: true) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 300)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(categoryColor.opacity(0.2), lineWidth: 1)
            )
            .padding(.horizontal)
        } else {
            VStack(spacing: 16) {
                Image(systemSymbol: .squareSplit2x2)
                    .font(.system(size: 48))
                    .foregroundStyle(categoryColor.opacity(0.6))

                VStack(spacing: 8) {
                    Text("UML Diagram")
                        .font(.headline)

                    Text("Structure visualization for \(patternName)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                Text("Diagram image not found: \(imageName).png")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemGray6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(categoryColor.opacity(0.3), style: StrokeStyle(lineWidth: 1.5, dash: [5, 5]))
            )
            .padding(.horizontal)
        }
    }

    private func loadDiagramImage(named imageName: String) -> UIImage? {
        let possiblePaths = [
            Bundle.main.url(forResource: imageName, withExtension: "png", subdirectory: "SupportingFiles/Diagrams/Images"),
            Bundle.main.url(forResource: imageName, withExtension: "png", subdirectory: "Diagrams/Images"),
            Bundle.main.url(forResource: imageName, withExtension: "png", subdirectory: "Images"),
            Bundle.main.url(forResource: imageName, withExtension: "png")
        ]

        for url in possiblePaths {
            if let url = url,
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                return image
            }
        }

        return nil
    }

    @ViewBuilder
    private func createCodeView(plantUMLCode: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("PlantUML Source")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)

            ScrollView {
                Text(plantUMLCode)
                    .font(.system(.caption, design: .monospaced))
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .frame(height: 200)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(UIColor.systemGray6))
            )
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func createDiagramInfo() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About the Diagram")
                .font(.caption)
                .fontWeight(.semibold)

            Text("The UML class diagram shows the structural relationships between classes, interfaces, and their interactions in the \(patternName) pattern.")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineSpacing(3)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemGroupedBackground))
        )
        .padding(.horizontal)
    }

    @ViewBuilder
    private func createNoDiagramView() -> some View {
        VStack(spacing: 16) {
            Image(systemSymbol: .exclamationmarkTriangle)
                .font(.system(size: 48))
                .foregroundStyle(.orange)

            VStack(spacing: 8) {
                Text("Diagram Not Available")
                    .font(.headline)

                Text("UML diagram for \(patternName) is being prepared")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

struct PatternDiagramView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            PatternDiagramView(
                patternName: "Singleton",
                categoryColor: .blue
            )
        }
    }
}
