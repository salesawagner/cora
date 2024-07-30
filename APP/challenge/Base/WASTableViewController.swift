//
//  WASTableViewController.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

class WASTableViewController: UIViewController {
    // MARK: Properties

    let activityIndicator = UIActivityIndicatorView()
    let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Setups

    func setupUI() {
        setupActivityIndicator()
        setupTableView()
    }

    func setupActivityIndicator() {
        activityIndicator.style = .medium
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .darkText
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }

    func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.alpha = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 8
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorColor = .clear

        tableView.fill(on: view)
    }
}
