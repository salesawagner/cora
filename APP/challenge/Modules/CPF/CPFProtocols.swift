//
//  LoginProtocols.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

protocol CPFInputProtocol: AnyObject {
    var viewController: CPFOutputProtocol? { get set }
    func didTapActionButton(cpf: String)
}

protocol CPFOutputProtocol: AnyObject {
    func failure()
}
