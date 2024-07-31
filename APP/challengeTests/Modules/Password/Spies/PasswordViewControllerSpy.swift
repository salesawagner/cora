//
//  PasswordViewControllerSpy.swift
//  challengeTests
//
//  Created by Wagner Sales on 31/07/24.
//

import XCTest
@testable import challenge

final class PasswordViewControllerSpy: PasswordOutputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func startLoading() {
        receivedMessages.append(.startLoading)
    }
    
    func success() {
        receivedMessages.append(.success)
        expectation?.fulfill()
    }
    
    func failure() {
        receivedMessages.append(.failure)
        expectation?.fulfill()
    }
}

extension PasswordViewControllerSpy {
    enum Message {
        case startLoading
        case success
        case failure
    }
}
