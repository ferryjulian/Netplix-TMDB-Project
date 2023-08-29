//
//  Date+Extensions.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import Foundation

extension Date {
    func dateToString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "id")
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
}
