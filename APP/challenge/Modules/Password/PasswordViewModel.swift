//
//  PasswordViewModel.swift
//  challenge
//
//  Created by Wagner Sales
//

import API

final class PasswordViewModel {
    // MARK: Properties

    private var api: APIClient
    private var cpf: String
    var viewController: PasswordOutputProtocol?

    // MARK: Inits

    init(api: APIClient = WASAPI(environment: Environment.production), cpf: String) {
        self.api = api
        self.cpf = cpf
    }

    // MARK: Private Methods

    private func goToList() {
        startRepeatingRequest()
        let listViewController = ListViewController.create(with: ListViewModel())
        (viewController as? UIViewController)?.navigationController?.pushViewController(
            listViewController,
            animated: true
        )
    }

    private func startRepeatingRequest() {
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
            guard let token = WASAPI.token else { return }

            self?.api.send(RefreshTokenRequest(token: token)) { result in
                switch result {
                case .success(let response): WASAPI.token = response.token
                case .failure: break
                }
            }
        }
    }
}

// MARK: - PasswordInputProtocol

extension PasswordViewModel: PasswordInputProtocol {
    func didTapActionButton(password: String) {
        viewController?.startLoading()
        api.send(AuthRequest(cpf: cpf, password: password)) { [weak self] result in
            switch result {
            case .success(let response):
                WASAPI.token = response.token

                DispatchQueue.main.async { [weak self] in
                    self?.viewController?.success()
                    self?.goToList()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.viewController?.failure()
                }
            }
        }
    }
}
