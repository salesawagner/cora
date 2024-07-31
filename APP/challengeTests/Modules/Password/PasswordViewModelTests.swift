//
//  PasswordViewModelTests.swift
//  challengeTests
//
//  Created by Wagner Sales on 31/07/24.
//

import XCTest
import API
@testable import challenge

final class PasswordViewModelTests: XCTestCase {
    private func makeSUT(api: APIClient, expectation: XCTestExpectation? = nil) -> (
        PasswordViewModel,
        PasswordViewControllerSpy
    ) {
        let viewControllerSpy = PasswordViewControllerSpy(expectation: expectation)
        let sut = PasswordViewModel(api: api, cpf: "047.776.254-94")
        sut.viewController = viewControllerSpy

        return (sut, viewControllerSpy)
    }

    // MARK: Tests

    func test_actionButton_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "actionButton_failure")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.didTapActionButton(password: "1")

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertEqual(viewControllerSpy.receivedMessages, [.startLoading, .failure])
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_actionButton_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "actionButton_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.didTapActionButton(password: "123456")

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertEqual(viewControllerSpy.receivedMessages, [.startLoading, .success])
        default:
            XCTFail("Delegate not called within timeout")
        }
    }
}
