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
        view.backgroundColor = .white
        setupNavigationController()
        setupActivityIndicator()
    }

    func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(r: 240, g: 244, b: 248, a: 1)
        appearance.titleTextAttributes = [
            .font: UIFont.preferredFont(forTextStyle: .footnote)
        ]

        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .darkText
        activityIndicator.stopAnimating()
        view.addSubview(activityIndicator)
    }

    func addBackButton() {
        let backButton = UIButton(type: .custom)
        let backImage = UIImage(named: "ic_chevron-left")
        backButton.setImage(backImage, for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
