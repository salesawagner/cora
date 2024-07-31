//
//  ListViewModel.swift
//  challenge
//
//  Created by Wagner Sales
//

import API

final class ListViewModel {
    // MARK: Properties

    private var api: APIClient
    private var response: ListRequest.Response? {
        didSet {
            sections = response?.toViewModel ?? []
        }
    }

    var viewController: ListOutputProtocol?
    var sections: [ListSectionViewModel] = []

    // MARK: Inits

    init(api: APIClient = WASAPI(environment: Environment.production)) {
        self.api = api
    }

    // MARK: Private Methods

    private func requestList() {
        viewController?.startLoading()
        api.send(ListRequest()) { [weak self] result in
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
}

// MARK: - ListInputProtocol

extension ListViewModel: ListInputProtocol {
    func didSelectRow(indexPath: IndexPath) {
        let id = sections[indexPath.section].rows[indexPath.row].id
        let listViewController = DetailsViewController.create(with: DetailsViewModel(id: id))
        (viewController as? UIViewController)?.navigationController?.pushViewController(
            listViewController,
            animated: true
        )
    }

    func didTapReload() {
        requestList()
    }

    func pullToRefresh() {
        requestList()
    }

    func viewDidLoad() {
        requestList()
    }
}

private extension ListResponse {
    var toViewModel: [ListSectionViewModel] {
        var sections: [ListSectionViewModel] = []
        results.forEach { section in
            var rows: [ListRowViewModel] = []
            section.items.forEach { item in
                rows.append(.init(
                    id: item.id,
                    entryType: item.entry,
                    amount: item.amount.formatToBrazilianCurrency ?? "",
                    dateEvent: item.dateEvent.toHourFormatted ?? "",
                    name: item.name,
                    description: item.description
                ))
            }

            sections.append(.init(date: section.date.toDateFormatted ?? "", rows: rows))
        }

        return sections
    }
}
