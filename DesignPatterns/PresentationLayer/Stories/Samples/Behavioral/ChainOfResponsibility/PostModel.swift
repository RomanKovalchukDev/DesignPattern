//
//  PostModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 28.01.2025.
//

import Foundation

struct PostModel {
    let id: String
    let name: String
    let contennt: String
    let imageURL: URL?
}

protocol PostProviderType: AnyObject {
    var next: PostProviderType? { get set }
    
    func getData() async throws -> [PostModel]
}

final class LocalDataProvider: PostProviderType {
    var next: (any PostProviderType)?
    
    func getData() async throws -> [PostModel] {
        do {
            let data = [PostModel(id: "123", name: "Name", contennt: "Content", imageURL: nil)]
            
            return data
        }
        catch {
            if let next = next {
                return try await next.getData()
            }
            else {
                throw error
            }
        }
    }
}

final class RemoteDataProvider: PostProviderType {
    enum TestError: LocalizedError {
        case networkError
    }
    
    var next: (any PostProviderType)?
    
    func getData() async throws -> [PostModel] {
        do {
            // Perform some fetching from the server
            throw TestError.networkError
        }
        catch {
            if let next = next {
                return try await next.getData()
            }
            else {
                throw error
            }
        }
    }
}

final class PostRepository {
    private var rootDataProvider: (any PostProviderType)?
    
    init() {
        setup()
    }
    
    func getData() async throws -> [PostModel] {
        try await rootDataProvider?.getData() ?? []
    }
    
    private func setup() {
        let local = LocalDataProvider()
        let remote = RemoteDataProvider()
        remote.next = local
        
        self.rootDataProvider = remote
    }
}
