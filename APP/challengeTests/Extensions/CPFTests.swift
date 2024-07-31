//
//  CPFTests.swift
//  challengeTests
//
//  Created by Wagner Sales on 31/07/24.
//

import XCTest
@testable import challenge

final class CPFTests: XCTestCase {
    func test_CPF_valid() throws {
        XCTAssertTrue("047.776.254-94".isValidCPF)
        XCTAssertTrue("128.302.920-06".isValidCPF)
        XCTAssertTrue("322.095.730-76".isValidCPF)
        XCTAssertTrue("962.982.650-07".isValidCPF)
    }

    func test_CPF_invalid() throws {
        XCTAssertFalse("047.776.254-90".isValidCPF)
        XCTAssertFalse("128.302.920-23".isValidCPF)
        XCTAssertFalse("322.095.730-43".isValidCPF)
        XCTAssertFalse("962.982.650-54".isValidCPF)
    }
}
