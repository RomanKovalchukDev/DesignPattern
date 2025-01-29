//
//  SomeLibraryNetworkRequest.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 28.01.2025.
//

import Foundation

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
