//
//  ListViewModelSpy.swift
//  challengeTests
//
//  Created by Wagner Sales
//

import XCTest
@testable import challenge

final class ListViewModelSpy: ListInputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    var viewController: ListOutputProtocol?
    var sections: [ListSectionViewModel] = []

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func viewDidLoad() {
        receivedMessages.append(.viewDidLoad)
    }

    func requestList() {
        receivedMessages.append(.requestList)
    }

    func didSelectRow(indexPath: IndexPath) {
        receivedMessages.append(.didSelecteRow)
    }

    func didTapReload() {
        receivedMessages.append(.didTapReload)
    }

    func pullToRefresh() {
        receivedMessages.append(.pullToRefresh)
    }
}

extension ListViewModelSpy {
    enum Message {
        case viewDidLoad
        case requestList
        case didSelecteRow
        case didTapReload
        case pullToRefresh
    }
}
