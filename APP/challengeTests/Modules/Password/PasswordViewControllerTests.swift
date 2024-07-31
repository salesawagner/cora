//
//  PasswordViewControllerTests.swift
//  challengeTests
//
//  Created by Wagner Sales on 31/07/24.
//

import XCTest
@testable import challenge

final class PasswordViewControllerTests: XCTestCase {
    private func makeSUT(expectation: XCTestExpectation? = nil) -> (
        sut: PasswordViewController,
        viewModel: PasswordViewModelSpy
    ) {
        let viewModelSpy = PasswordViewModelSpy()
        let sut = PasswordViewController.create(with: viewModelSpy)
        return (sut, viewModelSpy)
    }

    private func loadView(sut: PasswordViewController) {
        let window = UIWindow()
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests

    func test_didTapActionButton_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)
        sut.didTapActionButton()
        XCTAssertEqual(viewModelSpy.receivedMessages, [.didTapActionButton])
    }
}
