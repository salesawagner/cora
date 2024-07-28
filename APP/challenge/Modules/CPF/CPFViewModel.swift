//
//  CPFViewModel.swift
//  challenge
//
//  Created by Wagner Sales
//

import API

final class CPFViewModel {
    // MARK: Properties

    private var api: APIClient
    var viewController: CPFOutputProtocol?

    // MARK: Inits

    init(api: APIClient = WASAPI(environment: Environment.production)) {
        self.api = api
    }
}

// MARK: - CPFInputProtocol

extension CPFViewModel: CPFInputProtocol {
    func didTapActionButton(cpf: String) {
        if cpf.isValidCPF {
            // TODO: próxima tela
        } else {
            viewController?.failure()
        }
    }
}
