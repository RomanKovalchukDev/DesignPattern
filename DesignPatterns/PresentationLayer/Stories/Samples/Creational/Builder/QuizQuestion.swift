//
//  QuizQuestion.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 28.01.2025.
//

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
