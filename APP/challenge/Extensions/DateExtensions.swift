//
//  DateExtensions.swift
//  challenge
//
//  Created by Wagner Sales on 30/07/24.
//

import Foundation

extension String {
    var toHourFormatted: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Definindo o timezone para UTC

        guard let date = dateFormatter.date(from: self) else {
            return nil
        }

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"

        return timeFormatter.string(from: date)
    }

    var toDateFormatted: String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = inputFormatter.date(from: self) else {
            return nil
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d 'de' MMMM"
        outputFormatter.locale = Locale(identifier: "pt_BR")
        let formattedDate = outputFormatter.string(from: date)

        let todayFormatter = DateFormatter()
        todayFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = todayFormatter.string(from: Date())

        if self == todayString {
            return "Hoje - \(formattedDate)"
        } else {
            return formattedDate
        }
    }
}
