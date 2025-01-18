//
//  DesignPatternsRepository.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 18.01.2025.
//

import Foundation

protocol DesignPatternsRepositoryType {
    func getDesignPatters() throws -> [DesignPatternModel]
}

struct DesignPatternsRepository: DesignPatternsRepositoryType {
    
    // MARK: - Internal types
    
    enum RepoError: LocalizedError {
        case unknown
        case noData
        case decodingError
        case noFile
        
        var localizedDescription: String {
            "Error"
        }
    }
    
    private enum Constants {
        enum GOFPatterns {
            static let fileName = "GOFPatterns"
            static let fileExtension = "json"
        }
    }
    
    // MARK: - Methods(public)
    
    func getDesignPatters() throws(RepoError) -> [DesignPatternModel] {
        guard let jsonURL = Bundle.main.url(
            forResource: Constants.GOFPatterns.fileName,
            withExtension: Constants.GOFPatterns.fileExtension
        ) else {
            throw RepoError.noFile
        }
        
        guard let data = try? Data(contentsOf: jsonURL) else {
            throw RepoError.noData
        }
        
        guard let response = try? JSONDecoder.default.decode([DesignPatternResponse].self, from: data) else {
            throw RepoError.decodingError
        }
        
        let mappedModels = response.map(DesignPatternModel.init)
        
        return mappedModels
    }
}
