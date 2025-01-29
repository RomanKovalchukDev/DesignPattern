//
//  TemplateMethodSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 Use cases:
 - custom view generation
 - data export (pdf, csv etc)
 - data processing that differs
 - loggers
 */

// MARK: - Sample

protocol Logger {
    func log(message: String) // Template method
    func formatMessage(_ message: String) -> String
}

extension Logger {
    func log(message: String) {
        let formattedMessage = formatMessage(message)
        print(formattedMessage)
    }
}

class ConsoleLogger: Logger {
    func formatMessage(_ message: String) -> String {
        "[Console] \(message)"
    }
}

class FileLogger: Logger {
    func formatMessage(_ message: String) -> String {
        "[File] \(message)"
    }
}

// MARK: - View builder

import SwiftUI

protocol ViewTemplate {
    func prepareHeader() -> AnyView
    func prepareBody() -> AnyView
    func prepareFooter() -> AnyView

    func renderView() -> AnyView
}

extension ViewTemplate {
    func renderView() -> AnyView {
        AnyView(
            VStack(spacing: 20) {
                prepareHeader()
                prepareBody()
                prepareFooter()
            }
            .padding()
        )
    }
}

class InvoiceView: ViewTemplate {
    func prepareHeader() -> AnyView {
        AnyView(Text("📄 Invoice").font(.largeTitle).padding())
    }

    func prepareBody() -> AnyView {
        AnyView(Text("Amount: $500\nDue Date: 01-Feb-2025").multilineTextAlignment(.center))
    }

    func prepareFooter() -> AnyView {
        AnyView(Text("Thank you for your business!").font(.footnote))
    }
}

class ReportView: ViewTemplate {
    func prepareHeader() -> AnyView {
        AnyView(Text("📊 Report").font(.largeTitle).padding())
    }

    func prepareBody() -> AnyView {
        AnyView(Text("Report Content: Sales increased by 20% this quarter.").multilineTextAlignment(.center))
    }

    func prepareFooter() -> AnyView {
        AnyView(Text("Generated on: 01-Feb-2025").font(.footnote))
    }
}

struct TemplateMethodView: View {
    var body: some View {
        VStack(spacing: 20) {
            InvoiceView().renderView()
            ReportView().renderView()
        }
        .padding()
        .navigationTitle("Template Method Pattern")
    }
}

struct TemplateMethodView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateMethodView()
    }
}
