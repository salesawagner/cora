//
//  LoginProtocols.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

protocol PasswordInputProtocol: AnyObject {
    var viewController: PasswordOutputProtocol? { get set }
    func didTapActionButton(password: String)
}

protocol PasswordOutputProtocol: AnyObject {
    func startLoading()
    func failure()
}
