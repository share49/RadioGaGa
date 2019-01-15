//
//  String+Ext.swift
//  RadioGaGaPlayer
//
//  Created by Roger Pintó Diaz on 1/15/19.
//  Copyright © 2019 Roger Pintó Diaz. All rights reserved.
//

import Foundation

extension String {
    
    func refactorForiTunesSearchUrl() -> String {
        return self.replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: "\"", with: "")
            .folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
    }
}
