//
//  CPFViewModel.swift
//  challenge
//
//  Created by Wagner Sales
//

import API

final class CPFViewModel {
    // MARK: Properties

    var viewController: CPFOutputProtocol?
}

// MARK: - CPFInputProtocol

extension CPFViewModel: CPFInputProtocol {
    func didTapActionButton(cpf: String) {
        if cpf.isValidCPF {
            let passwordViewController = PasswordViewController.create(with: PasswordViewModel(cpf: cpf))
            (viewController as? UIViewController)?.navigationController?.pushViewController(
                passwordViewController,
                animated: true
            )
        } else {
            viewController?.failure()
        }
    }
}
