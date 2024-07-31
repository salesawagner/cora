//
//  CPFViewModelTests.swift
//  challengeTests
//
//  Created by Wagner Sales on 31/07/24.
//

import XCTest
@testable import challenge

final class CPFViewModelTests: XCTestCase {
    private func makeSUT() -> (CPFViewModel, CPFViewControllerSpy) {
        let viewControllerSpy = CPFViewControllerSpy()
        let sut = CPFViewModel()
        sut.viewController = viewControllerSpy

        return (sut, viewControllerSpy)
    }

    func test_actionButton_failure_shouldReceiveCorrectMessages() {
        let (sut, viewControllerSpy) = makeSUT()
        sut.didTapActionButton(cpf: "")
        XCTAssertEqual(viewControllerSpy.receivedMessages, [.failure])
    }

    func test_actionButton_success_shouldReceiveCorrectMessages() {
        let (sut, viewControllerSpy) = makeSUT()
        sut.didTapActionButton(cpf: "047.776.254-94")
        XCTAssertTrue(viewControllerSpy.receivedMessages.isEmpty)
    }
}
