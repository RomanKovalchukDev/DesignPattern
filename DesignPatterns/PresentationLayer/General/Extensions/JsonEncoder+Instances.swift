//
//  JsonEncoder+Instances.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 18.01.2025.
//

import Foundation

extension JSONEncoder {
    static let `default`: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        return encoder
    }()
}
