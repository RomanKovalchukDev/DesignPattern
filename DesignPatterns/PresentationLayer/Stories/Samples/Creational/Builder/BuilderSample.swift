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

struct SomeLibraryNetworkRequest {
    var baseURL: URL?
    var queryParameters: [URLQueryItem]
    var headers: [String: String]
    
    init(
        baseURL: URL? = nil,
        queryParameters: [URLQueryItem] = [],
        headers: [String: String] = [:]
    ) {
        self.baseURL = baseURL
        self.queryParameters = queryParameters
        self.headers = headers
    }
}

final class NetworkRequestBuilder {
    private var request: SomeLibraryNetworkRequest = SomeLibraryNetworkRequest()
    
    func reset() {
        request = SomeLibraryNetworkRequest()
    }
    
    func setBaseURL(_ url: URL) -> Self {
        var updatedRequest = request
        updatedRequest.baseURL = url
        self.request = updatedRequest
        return self
    }
    
    func setQueryParameter(_ item: URLQueryItem) -> Self {
        var updatedRequest = request
        updatedRequest.queryParameters.append(item)
        self.request = updatedRequest
        return self
    }
    
    func setHeader(_ key: String, _ value: String) -> Self {
        var updatedRequest = request
        updatedRequest.headers[key] = value
        self.request = updatedRequest
        return self
    }
    
    func build() -> SomeLibraryNetworkRequest {
        request
    }
}

// MARK: - Complex model builder

struct QuizQuestion {
    let question: String
    var answer: String?
}

struct QuizModel {
    var title: String = "Default name"
    var questions: [QuizQuestion] = []
    var author: String?
    var maxScore: Int?
}

final class QuizModelBuilder {
    private var quizModel: QuizModel = QuizModel()
    
    func setTitle(_ title: String) -> Self {
        var updatedModel = quizModel
        updatedModel.title = title
        self.quizModel = updatedModel
        return self
    }
    
    func appendQuestion(_ question: QuizQuestion) -> Self {
        var updatedModel = quizModel
        updatedModel.questions.append(question)
        self.quizModel = updatedModel
        return self
    }
    
    func resetQuestions() -> Self {
        var updatedModel = quizModel
        updatedModel.questions.removeAll()
        self.quizModel = updatedModel
        return self
    }
    
    func setAuthor(_ author: String?) -> Self {
        var updatedModel = quizModel
        updatedModel.author = author
        self.quizModel = updatedModel
        return self
    }
    
    func setmaxScore(_ maxScore: Int?) -> Self {
        var updatedModel = quizModel
        updatedModel.maxScore = maxScore
        self.quizModel = updatedModel
        return self
    }
    
    func build() -> QuizModel {
        quizModel
    }
}

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
