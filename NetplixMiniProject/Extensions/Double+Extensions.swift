//
//  Double+Extensions.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import Foundation

extension Double {
    
    func rating() -> String {
        let rating = Int(self)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "⭐️"
        }
        return ratingText
    }
}
