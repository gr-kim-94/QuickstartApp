//
//  APIManager.swift
//  QuickstartApp
//
//  Created by grkim on 2022/05/13.
//

import Foundation

struct APIManager {
    var apiKey: String {
        get {
            if let keyPath = Bundle.main.infoDictionary?["API_KEY"] as? String {
                return keyPath
            }
            
            return ""
        }
    }
}
