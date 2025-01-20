//
//  AppMessageDisplayModel.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 20.01.2025.
//

import SwiftMessages
import Foundation

struct AppMessageDisplayModel: Equatable, Identifiable {
    let id: String
    let text: String
    let style: AppMessageStyle
    
    init(error: String) {
        id = UUID().uuidString
        text = error
        style = .error
    }
    
    init(info: String) {
        id = UUID().uuidString
        text = info
        style = .info
    }
}
