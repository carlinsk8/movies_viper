//
//  Environment.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import Foundation

enum Environment {
    static var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Environment", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let value = dict["API_KEY"] as? String else {
            return ""
        }
        return value
    }

    static var baseURL: String {
        guard let path = Bundle.main.path(forResource: "Environment", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let value = dict["API_BASE_URL"] as? String else {
            return ""
        }
        return value
    }
}
