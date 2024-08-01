//
//  DetailsViewController.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

final class DetailsViewController: WASViewController {
    // MARK: Properties

    var viewModel: DetailsInputProtocol

    let refreshControl = UIRefreshControl()
    let tableView = UITableView(frame: .zero, style: .plain)
    var errorView: UIView?

    // MARK: Constructors

    private init(viewModel: DetailsInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: DetailsInputProtocol) -> DetailsViewController {
        let viewController = DetailsViewController(viewModel: viewModel)
        viewController.viewModel.viewController = viewController
        return viewController
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        title = "Detalhes da transferência"
        setupRefreshControl()
        setupTableView()
        addBackButton()
    }

    func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.alpha = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorColor = .clear

        tableView.dataSource = self
        tableView.register(DetailsIconCell.self, forCellReuseIdentifier: DetailsIconCell.identifier)
        tableView.register(DetailsTitleValueCell.self, forCellReuseIdentifier: DetailsTitleValueCell.identifier)
        tableView.register(DetailsDescriptionCell.self, forCellReuseIdentifier: DetailsDescriptionCell.identifier)
        tableView.register(DetailsRecipientCell.self, forCellReuseIdentifier: DetailsRecipientCell.identifier)

        tableView.fill(on: view)
    }

    // MARK: Private Methods

    @objc private func pullToRefresh() {
        viewModel.pullToRefresh()
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    private func stopLoading() {
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
    }

    private func removeErrorView() {
        errorView?.alpha = 0
        errorView?.removeFromSuperview()
        errorView = nil
    }
}

// MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch viewModel.rows[indexPath.row] {
        case .icon(let iconNamed, let title):
            let iconCell = tableView.dequeueReusableCell(withIdentifier: DetailsIconCell.identifier) as? DetailsIconCell
            iconCell?.setup(iconNamed: iconNamed, title: title)
            cell = iconCell

        case .amount(let title, let value), .date(let title, let value):
            let titleValueCell = tableView.dequeueReusableCell(
                withIdentifier: DetailsTitleValueCell.identifier
            ) as? DetailsTitleValueCell
            titleValueCell?.setup(title: title, value: value)
            cell = titleValueCell

        case .description(let title, let value):
            let descriptionCell = tableView.dequeueReusableCell(
                withIdentifier: DetailsDescriptionCell.identifier
            ) as? DetailsDescriptionCell
            descriptionCell?.setup(title: title, value: value)
            cell = descriptionCell
        
        case .recipient(let title, let bankName, let documentNumber, let name, let account):
            let descriptionCell = tableView.dequeueReusableCell(
                withIdentifier: DetailsRecipientCell.identifier
            ) as? DetailsRecipientCell
            descriptionCell?.setup(title: title, bankName: bankName, documentNumber: documentNumber, name: name, account: account)
            cell = descriptionCell
        }

        return cell ?? UITableViewCell()
    }
}

// MARK: - WASErrorViewDelegate

extension DetailsViewController: WASErrorViewDelegate {
    func didTapReloadButton() {
        viewModel.didTapReload()
    }
}

// MARK: - DetailsOutnputProtocol

extension DetailsViewController: DetailsOutputProtocol {
    func startLoading() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 0
            self?.removeErrorView()
        }
    }

    func success() {
        stopLoading()
        tableView.reloadData()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 1
            self?.removeErrorView()
        }
    }

    func failure() {
        stopLoading()
        guard errorView == nil else { return }

        errorView = WASErrorView(delegate: self)
        errorView?.alpha = 0
        errorView?.fill(on: view)

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.errorView?.alpha = 1
            self?.tableView.alpha = 0
        }
    }
}
