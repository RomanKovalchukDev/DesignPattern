//
//  PatternDetailsView.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

import SwiftUI
import SFSafeSymbols

struct PatternDetailsView<ViewModel: PatternDetailsViewModelType>: View {
    // MARK: - Aliases

    typealias ViewModelCreateAction = () -> ViewModel

    // MARK: - Properties(public)

    var body: some View {
        VStack(spacing: 0) {
            // Category badge
            createCategoryBadge()

            // Tab picker
            Picker("Section", selection: $selectedSection) {
                ForEach(PatternDetailSectionType.allCases) { section in
                    Text(section.title).tag(section)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.vertical, 12)

            // Content
            createDetailsView()
        }
        .navigationTitle(viewModel.name)
        .navigationBarTitleDisplayMode(.large)
    }

    // MARK: - Properties(private)

    @StateObject private var viewModel: ViewModel
    @State private var selectedSection: PatternDetailSectionType = .overview

    // MARK: - Life cycle

    init(viewModel: @autoclosure @escaping ViewModelCreateAction) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }

    // MARK: - Views

    @ViewBuilder
    private func createCategoryBadge() -> some View {
        HStack(spacing: 8) {
            Image(systemSymbol: viewModel.categoryIcon)
                .font(.system(size: 16))

            Text(viewModel.categoryName)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(viewModel.categoryColor)
        )
        .padding(.top, 8)
    }

    @ViewBuilder
    private func createDetailsView() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                switch selectedSection {
                case .overview:
                    createOverviewSection()

                case .structure:
                    createStructureSection()

                case .diagram:
                    createDiagramSection()

                case .code:
                    createCodeSection()
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
    }

    @ViewBuilder
    private func createOverviewSection() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            // Intent
            createInfoCard(title: "Intent", content: viewModel.intent)

            // When to Use
            createInfoCard(title: "When to Use", content: viewModel.applicability)

            // Implementation Guide
            createInfoCard(title: "Implementation", content: viewModel.implementation)

            // Known Uses
            if !viewModel.knownUses.isEmpty {
                createKnownUsesCard()
            }

            // Related Patterns
            if !viewModel.relatedPatterns.isEmpty {
                createRelatedPatternsCard()
            }
        }
    }

    @ViewBuilder
    private func createStructureSection() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            // Structure overview
            createInfoCard(title: "Structure", content: viewModel.structure)

            // Participants
            if !viewModel.participants.isEmpty {
                createParticipantsCard()
            }

            // Collaboration
            if let collaboration = viewModel.collaboration, !collaboration.isEmpty {
                createInfoCard(title: "Collaboration", content: collaboration)
            }
        }
    }

    @ViewBuilder
    private func createDiagramSection() -> some View {
        PatternDiagramView(
            patternName: viewModel.name,
            categoryColor: viewModel.categoryColor
        )
    }

    @ViewBuilder
    private func createCodeSection() -> some View {
        CodeSamplesView(
            patternName: viewModel.name,
            categoryColor: viewModel.categoryColor
        )
    }

    @ViewBuilder
    private func createInfoCard(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(content)
                .font(.body)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemGroupedBackground))
        )
    }

    @ViewBuilder
    private func createParticipantsCard() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Participants")
                .font(.headline)
                .foregroundStyle(.primary)

            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(viewModel.participants.enumerated()), id: \.offset) { _, participant in
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemSymbol: .circleInsetFilled)
                            .font(.system(size: 8))
                            .foregroundStyle(viewModel.categoryColor)
                            .padding(.top, 6)

                        Text(participant)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemGroupedBackground))
        )
    }

    @ViewBuilder
    private func createKnownUsesCard() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Known Uses in iOS")
                .font(.headline)
                .foregroundStyle(.primary)

            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(viewModel.knownUses.enumerated()), id: \.offset) { _, use in
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemSymbol: .checkmarkCircleFill)
                            .font(.system(size: 16))
                            .foregroundStyle(viewModel.categoryColor)

                        Text(use)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemGroupedBackground))
        )
    }

    @ViewBuilder
    private func createRelatedPatternsCard() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Related Patterns")
                .font(.headline)
                .foregroundStyle(.primary)

            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(viewModel.relatedPatterns.enumerated()), id: \.offset) { _, pattern in
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemSymbol: .arrowRight)
                            .font(.system(size: 14))
                            .foregroundStyle(viewModel.categoryColor)

                        Text(pattern)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemGroupedBackground))
        )
    }
}

struct PatternDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PatternDetailsView(viewModel: MockPatternDetailsViewModel())
        }
    }
}
