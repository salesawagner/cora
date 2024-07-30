//
//  ListViewController.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

final class ListViewController: WASViewController {
    // MARK: Properties

    var viewModel: ListInputProtocol

    let refreshControl = UIRefreshControl()
    let tableView = UITableView(frame: .zero, style: .plain)
    var errorView: UIView?

    // MARK: Constructors

    private init(viewModel: ListInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: ListInputProtocol = ListViewModel()) -> ListViewController {
        let viewController = ListViewController(viewModel: viewModel)
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
        title = "Extrato"
        setupRefreshControl()
        setupTableView()
    }

    override func setupNavigationController() {
        super.setupNavigationController()
        navigationItem.setHidesBackButton(true, animated: true)
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
        tableView.delegate = self
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)

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

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.sections[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as? ListCell
        cell?.setup(with: row)

        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .init(r: 240, g: 244, b: 248)

        let label = UILabel()
        label.text = viewModel.sections[section].date
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.fill(on: view, insets: .init(top: 6, left: 24, bottom: 6, right: 24))

        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath: indexPath)
    }
}

// MARK: - WASErrorViewDelegate

extension ListViewController: WASErrorViewDelegate {
    func didTapReloadButton() {
        viewModel.didTapReload()
    }
}

// MARK: - ListOutnputProtocol

extension ListViewController: ListOutputProtocol {
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
