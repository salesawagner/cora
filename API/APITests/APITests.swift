//
//  APITests.swift
//  APITests
//
//  Created by Wagner Sales
//

import XCTest
import API

final class APITests: XCTestCase {
    func test_auth() throws {
        let expectation = XCTestExpectation(description: "test_list")
        let api = WASAPI(environment: Environment.local)
        api.send(AuthRequest()) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.token, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIwNDc3NzYyNTQ5NCIsImlhdCI6MTcyMTkzOTA1MH0.g2pU8xKCV-P7Hx5zirm1Efo6uCzdR9erIn5fEEkEc40")

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }
}
