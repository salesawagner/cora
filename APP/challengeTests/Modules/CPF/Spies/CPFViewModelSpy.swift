//
//  CPFViewModelSpy.swift
//  challengeTests
//
//  Created by Wagner Sales on 31/07/24.
//

import Foundation
@testable import challenge

final class CPFViewModelSpy: CPFInputProtocol {
    var receivedMessages: [Message] = []

    var viewController: challenge.CPFOutputProtocol?

    func didTapActionButton(cpf: String) {
        receivedMessages.append(.didTapActionButton)
    }
}

extension CPFViewModelSpy {
    enum Message {
        case didTapActionButton
    }
}
