//
//  CurrencyTests.swift
//  challengeTests
//
//  Created by Wagner Sales on 31/07/24.
//

import XCTest
@testable import challenge

final class CurrencyTests: XCTestCase {
    func test_currency_formatter() throws {
        XCTAssertEqual(Double(1).formatToBrazilianCurrency!, "R$ 1,00")
        XCTAssertEqual(Double(100).formatToBrazilianCurrency!, "R$ 100,00")
        XCTAssertEqual(Double(1000).formatToBrazilianCurrency!, "R$ 1.000,00")
        XCTAssertEqual(Double(10000).formatToBrazilianCurrency!, "R$ 10.000,00")
    }
}
