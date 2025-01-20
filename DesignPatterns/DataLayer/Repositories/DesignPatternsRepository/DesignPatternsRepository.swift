//
//  DesignPatternsRepository.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 18.01.2025.
//

import Foundation

protocol DesignPatternsRepositoryType {
    associatedtype ErrorType: LocalizedError
    func getDesignPatters() throws(ErrorType) -> [DesignPatternModel]
}

final class DesignPatternsRepository: DesignPatternsRepositoryType {
    
    // MARK: - Internal types
    
    enum RepositoryError: LocalizedError {
        case unknown
        case noData
        case decodingError
        case noFile
        
        var localizedDescription: String {
            switch self {
            case .unknown:
                return .localizable(.unknownError)
                
            case .noData:
                return .localizable(.noDataError)
                
            case .decodingError:
                return .localizable(.decodingError)
                
            case .noFile:
                return .localizable(.noFileError)
            }
        }
    }
    
    private enum Constants {
        enum GOFPatterns {
            static let fileName = "GOFPatterns"
            static let fileExtension = "json"
        }
    }
    
    // MARK: - Methods(public)
    
    func getDesignPatters() throws(RepositoryError) -> [DesignPatternModel] {
        guard let jsonURL = Bundle.main.url(
            forResource: Constants.GOFPatterns.fileName,
            withExtension: Constants.GOFPatterns.fileExtension
        ) else {
            throw RepositoryError.noFile
        }
                
        guard let data = try? Data(contentsOf: jsonURL) else {
            throw RepositoryError.noData
        }
        
        guard let response = try? JSONDecoder.default.decode([DesignPatternResponse].self, from: data) else {
            throw RepositoryError.decodingError
        }
        
        let mappedModels = response.map(DesignPatternModel.init)
        
        return mappedModels
    }
}
