//
//  JSONDecoder+Instances.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 18.01.2025.
//

import Foundation

extension JSONDecoder {
    static let `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
