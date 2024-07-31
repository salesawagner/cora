//
//  CPFViewControllerSpy.swift
//  challengeTests
//
//  Created by Wagner Sales on 31/07/24.
//

import Foundation
@testable import challenge

final class CPFViewControllerSpy: CPFOutputProtocol {
    var receivedMessages: [Message] = []

    var viewController: CPFOutputProtocol?

    func failure() {
        receivedMessages.append(.failure)
    }
}

extension CPFViewControllerSpy {
    enum Message {
        case failure
    }
}
