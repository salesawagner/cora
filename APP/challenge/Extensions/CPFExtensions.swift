//
//  CPFExtensions.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

extension String {
    var isValidCPF: Bool {
        let numbers = compactMap(\.wholeNumberValue)
        guard numbers.count == 11 && Set(numbers).count != 1 else {
            return false
        }

        return numbers.prefix(9).CPFDigit == numbers[9] && numbers.prefix(10).CPFDigit == numbers[10]
    }
}

extension Collection where Element == Int {
    var CPFDigit: Int {
        var number = count + 2
        let digit = 11 - reduce(into: 0) {
            number -= 1
            $0 += $1 * number
        } % 11
        return digit > 9 ? 0 : digit
    }
}
