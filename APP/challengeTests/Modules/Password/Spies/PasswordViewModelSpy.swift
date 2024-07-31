//
//  PasswordViewModelSpy.swift
//  challengeTests
//
//  Created by Wagner Sales on 31/07/24.
//

import Foundation
@testable import challenge

final class PasswordViewModelSpy: PasswordInputProtocol {
    var receivedMessages: [Message] = []

    var viewController: challenge.PasswordOutputProtocol?
    
    func didTapActionButton(password: String) {
        receivedMessages.append(.didTapActionButton)
    }
}

extension PasswordViewModelSpy {
    enum Message {
        case didTapActionButton
    }
}
