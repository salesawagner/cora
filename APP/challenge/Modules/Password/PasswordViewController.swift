//
//  PasswordViewController.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

final class PasswordViewController: WASViewController {
    // MARK: Properties

    var viewModel: PasswordInputProtocol

    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let errorLabel = UILabel()
    let actionButton = UIButton(type: .system)

    weak var bottomConstraint: NSLayoutConstraint?

    // MARK: Constructors

    private init(viewModel: PasswordInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: PasswordInputProtocol) -> PasswordViewController {
        let viewController = PasswordViewController(viewModel: viewModel)
        viewController.viewModel.viewController = viewController
        return viewController
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passwordTextField.becomeFirstResponder()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func setupUI() {
        super.setupUI()
        title = "Login Cora"
        setupPasswordLabel()
        setupTextField()
        setupErrorLabel()
        setupStackView()
        setupActionButton()
        addBackButton()
    }

    // MARK: Setups

    private func setupPasswordLabel() {
        passwordLabel.text = "Digite sua senha de acesso"
        passwordLabel.textColor = .black
        passwordLabel.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        passwordLabel.adjustsFontForContentSizeCategory = true
    }

    private func setupTextField() {
        passwordTextField.font = UIFont.preferredFont(forTextStyle: .title3)
        passwordTextField.backgroundColor = .clear
        passwordTextField.keyboardType = .numberPad
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
    }

    private func setupErrorLabel() {
        errorLabel.text = "Password inválido"
        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.textColor = .red
        errorLabel.isHidden = true
    }

    private func setupStackView() {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 16

        labelsStackView.addArrangedSubview(passwordLabel)

        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 32
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        mainStackView.addArrangedSubview(labelsStackView)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(errorLabel)

        view.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func setupActionButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Próximo"
        configuration.baseBackgroundColor = UIColor.systemPink
        configuration.cornerStyle = .medium

        actionButton.configuration = configuration
        actionButton.isEnabled = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)

        view.addSubview(actionButton)

        let bottomConstraint = actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        self.bottomConstraint = bottomConstraint
        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: 48),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            bottomConstraint
        ])
    }

    // MARK: Internal Methods

    @objc func didTapActionButton() {
        guard let password = passwordTextField.text else { return }
        viewModel.didTapActionButton(password: password)
    }

    // MARK: Private Methods

    @objc private func keyboardWillChangeFrame(notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        let animationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt).flatMap {
            value in UIView.AnimationOptions(rawValue: value)
        }

        bottomConstraint?.constant = -(keyboardHeight + 16)
        UIView.animate(withDuration: duration ?? 0,
            delay: 0,
            options: animationCurve ?? .curveEaseInOut,
            animations: { self.view.layoutIfNeeded() },
            completion: nil
        )
    }

    @objc private func passwordChanged() {
        guard let password = passwordTextField.text, password.count >= 6 else {
            actionButton.isEnabled = false
            return
        }

        actionButton.isEnabled = true
    }
}

// MARK: - PasswordOutnputProtocol

extension PasswordViewController: PasswordOutputProtocol {
    func startLoading() {
        actionButton.configuration?.showsActivityIndicator = true
    }

    func success() {
        errorLabel.isHidden = false
        actionButton.configuration?.showsActivityIndicator = false
    }

    func failure() {
        errorLabel.isHidden = false
        actionButton.configuration?.showsActivityIndicator = false
    }
}
