//
//  CPFViewControllerTests.swift
//  challengeTests
//
//  Created by Wagner Sales on 31/07/24.
//

import XCTest
@testable import challenge

final class CPFViewControllerTests: XCTestCase {
    private func makeSUT() -> (sut: CPFViewController, viewModel: CPFViewModelSpy) {
        let viewModelSpy = CPFViewModelSpy()
        let sut = CPFViewController.create(with: viewModelSpy)
        return (sut, viewModelSpy)
    }

    private func loadView(sut: CPFViewController) {
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
