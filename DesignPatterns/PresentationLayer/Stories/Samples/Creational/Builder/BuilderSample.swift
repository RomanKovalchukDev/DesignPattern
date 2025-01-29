//
//  Builder.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 26.01.2025.
//

/*
 Builder most common use cases are:
  - Building ui components
  - Constracting configuration objects
  - Creating animations
  - Building some api requests
 */

// MARK: - Sample

import Foundation
import SwiftUI

// MARK: - Request builder

// MARK: - Complex model builder

// MARK: - View builder

struct QuizTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
    }
}

struct QuizQuestionView: View {
    let question: QuizQuestion
    
    var body: some View {
        VStack {
            Text(question.question)
            Text(question.answer ?? "-")
        }
        .padding()
        .background(Color.yellow)
    }
}

final class QuizViewBuilder {
    
    private var titleView: QuizTitleView?
    private var questionViews: [QuizQuestionView] = []
    
    func setTitleView(_ titleView: QuizTitleView?) -> Self {
        self.titleView = titleView
        return self
    }
    
    func setQuestionViews(_ views: [QuizQuestionView]) -> Self {
        self.questionViews = views
        return self
    }
    
    func build() -> some View {
        VStack {
            if let titleView = titleView {
                titleView
            }
            
            LazyVStack {
                ForEach(Array(questionViews.enumerated()), id: \.offset) { _, questionView in
                    questionView
                }
            }
        }
    }
}

struct QuizQuestionView_Previews: PreviewProvider {
    static let quiz: QuizModel = QuizModelBuilder()
        .setTitle("My quiz")
        .appendQuestion(QuizQuestion(question: "Question 1?"))
        .appendQuestion(QuizQuestion(question: "Question 2?"))
        .appendQuestion(QuizQuestion(question: "Question 3?", answer: "Wow answer"))
        .build()
    
    static var previews: some View {
        QuizViewBuilder()
            .setTitleView(QuizTitleView(title: quiz.title))
            .setQuestionViews(quiz.questions.map({ QuizQuestionView(question: $0) }))
            .build()
    }
}
