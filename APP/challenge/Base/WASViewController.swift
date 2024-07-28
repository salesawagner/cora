//
//  WASTableViewController.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

class WASViewController: UIViewController {
    // MARK: Properties

    let activityIndicator = UIActivityIndicatorView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Setups

    func setupUI() {
        view.backgroundColor = UIColor.Base.background
        setupNavigationController()
        setupActivityIndicator()
    }

    func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = false
    }

    func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .darkText
        activityIndicator.stopAnimating()
        view.addSubview(activityIndicator)
    }
}
