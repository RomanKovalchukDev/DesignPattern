//
//  DesignPatternCategory+UI.swift
//  DesignPatterns
//
//  Created by Claude Code on 03.04.2026.
//

import SwiftUI
import SFSafeSymbols

extension DesignPatternCategory {

    // MARK: - Properties(public)

    var displayColor: Color {
        switch self {
        case .creational:
            return Color(red: 0.0, green: 0.478, blue: 1.0) // #007AFF - iOS Blue

        case .structural:
            return Color(red: 0.204, green: 0.780, blue: 0.349) // #34C759 - iOS Green

        case .behavioral:
            return Color(red: 0.686, green: 0.322, blue: 0.871) // #AF52DE - iOS Purple

        case .architectural:
            return Color(red: 1.0, green: 0.584, blue: 0.0) // #FF9500 - iOS Orange
        }
    }

    var icon: SFSymbol {
        switch self {
        case .creational:
            return .hammerFill

        case .structural:
            return .squareGrid3x3Fill

        case .behavioral:
            return .gearshapeFill

        case .architectural:
            return .buildingColumnsFill
        }
    }
}

extension DesignPatternModel {

    // MARK: - Properties(public)

    var icon: SFSymbol {
        switch name {
        // Creational
        case "Abstract Factory":
            return .building2Fill

        case "Builder":
            return .hammerFill

        case "Factory Method":
            return .wrenchAndScrewdriverFill

        case "Prototype":
            return .docOnDocFill

        case "Singleton":
            return .starCircleFill

        // Structural
        case "Adapter":
            return .arrowTriangle2Circlepath

        case "Bridge":
            return .arrowLeftArrowRight

        case "Composite":
            return .squareGrid3x3Fill

        case "Decorator":
            return .giftFill

        case "Facade":
            return .squareStack3dDownRightFill

        case "Flyweight":
            return .leafFill

        case "Proxy":
            return .personCropSquareFill

        // Behavioral
        case "Chain of Responsibility":
            return .linkCircleFill

        case "Command":
            return .commandSquareFill

        case "Interpreter":
            return .textQuote

        case "Iterator":
            return .arrowTriangleTurnUpRightDiamond

        case "Mediator":
            return .bubbleLeftAndBubbleRightFill

        case "Memento":
            return .clockArrowCirclepath

        case "Observer":
            return .eyeFill

        case "State":
            return .sliderHorizontal3

        case "Strategy":
            return .arrowTriangleBranch

        case "Template Method":
            return .docPlaintextFill

        case "Visitor":
            return .figureWalk

        default:
            return .questionmarkCircleFill
        }
    }
}
