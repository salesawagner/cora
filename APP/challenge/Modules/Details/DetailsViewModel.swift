//
//  DetailsViewModel.swift
//  challenge
//
//  Created by Wagner Sales
//

import API

final class DetailsViewModel {
    // MARK: Properties

    private var api: APIClient
    private let id: String
    private var response: DetailsRequest.Response? {
        didSet {
            rows = response?.toViewModel ?? []
        }
    }

    var viewController: DetailsOutputProtocol?
    var rows: [DetailsRowViewModel] = []

    // MARK: Inits

    init(api: APIClient = WASAPI(environment: Environment.production), id: String) {
        self.api = api
        self.id = id
    }

    // MARK: Private Methods

    private func requestDetails() {
        viewController?.startLoading()
        api.send(DetailsRequest(id: id)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response

                DispatchQueue.main.async {
                    self?.viewController?.success()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.viewController?.failure()
                }
            }
        }
    }

    private func resetSearch() {
        requestDetails()
    }
}

// MARK: - DetailsInputProtocol

extension DetailsViewModel: DetailsInputProtocol {
    func didTapReload() {
        requestDetails()
    }

    func pullToRefresh() {
        requestDetails()
    }

    func viewDidLoad() {
        requestDetails()
    }
}

private extension DetailsResponse {
    var toViewModel: [DetailsRowViewModel] {
        let rows: [DetailsRowViewModel] = [
            .icon(named: "ic_arrow-up-out", title: label),
            .amount(title: "Valor", value: amount.formatToBrazilianCurrency ?? ""),
            .date(title: "Data", value: dateEvent.fullDatetoDateFormatted ?? ""),
            .recipient(
                title: "De",
                bankName: sender.bankName,
                documentNumber: sender.documentNumber,
                name: sender.name,
                account: "Agência \(sender.agencyNumber) - Conta \(sender.agencyNumber)-\(sender.agencyNumberDigit)"),
            .recipient(
                title: "Para",
                bankName: recipient.bankName,
                documentNumber: recipient.documentNumber,
                name: recipient.name,
                account: "Agência \(recipient.agencyNumber) - Conta \(recipient.agencyNumber)-\(recipient.agencyNumberDigit)"),
            .description(title: "Descrição", value: description)
        ]

        return rows
    }
}

