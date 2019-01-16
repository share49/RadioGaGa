//
//  Essentials.swift
//  RadioGaGaPlayer
//
//  Created by Roger Pintó Diaz on 1/15/19.
//  Copyright © 2019 Roger Pintó Diaz. All rights reserved.
//

import Foundation

// MARK: - Threading
public func onMain(_ closure: @escaping () -> ()) {
    DispatchQueue.main.async(execute: closure)
}

// MARK: - Logging
func E(_ message: String) {
    NSLog("🛑 \(message)")
}

func I(_ message: String) {
    NSLog("ℹ️ \(message)")
}

// MARK: - Typealias
typealias JSONObject = [String: Any]
typealias JSONArray = [[String: Any]]
