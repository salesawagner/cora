//
//  CPFViewController.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

final class CPFViewController: WASViewController {
    // MARK: Properties

    var viewModel: CPFInputProtocol

    let welcomeLabel = UILabel()
    let CPFLabel = UILabel()
    let CPFTextField = UITextField()
    let errorLabel = UILabel()
    let actionButton = UIButton(type: .system)

    weak var bottomConstraint: NSLayoutConstraint?

    // MARK: Constructors

    private init(viewModel: CPFInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: CPFInputProtocol) -> CPFViewController {
        let viewController = CPFViewController(viewModel: viewModel)
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
        CPFTextField.becomeFirstResponder()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func setupUI() {
        super.setupUI()
        title = "Login Cora"
        setupWelcomeLabel()
        setupCPFLabel()
        setupTextField()
        setupErrorLabel()
        setupStackView()
        setupActionButton()
    }

    // MARK: Setups

    private func setupWelcomeLabel() {
        welcomeLabel.text = "Bem-vindo de volta!"
        welcomeLabel.textColor = .black
        welcomeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        welcomeLabel.adjustsFontForContentSizeCategory = true
    }

    private func setupCPFLabel() {
        CPFLabel.text = "Qual seu CPF?"
        CPFLabel.textColor = .black
        CPFLabel.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        CPFLabel.adjustsFontForContentSizeCategory = true
    }

    private func setupTextField() {
        CPFTextField.font = UIFont.preferredFont(forTextStyle: .title3)
        CPFTextField.backgroundColor = .clear
        CPFTextField.keyboardType = .numberPad
        CPFTextField.delegate = self
        CPFTextField.addTarget(self, action: #selector(CPFChanged), for: .editingChanged)
    }

    private func setupErrorLabel() {
        errorLabel.text = "CPF inválido"
        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.textColor = .red
        errorLabel.isHidden = true
    }

    private func setupStackView() {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 16

        labelsStackView.addArrangedSubview(welcomeLabel)
        labelsStackView.addArrangedSubview(CPFLabel)

        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 32
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        mainStackView.addArrangedSubview(labelsStackView)
        mainStackView.addArrangedSubview(CPFTextField)
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
        guard let cpf = CPFTextField.text else { return }
        viewModel.didTapActionButton(cpf: cpf)
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

    @objc private func CPFChanged() {
        guard let cpf = CPFTextField.text, cpf.isValidCPF else {
            actionButton.isEnabled = false
            return
        }

        actionButton.isEnabled = true
    }
}

extension CPFViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        errorLabel.isHidden = true
        var appendString = ""

        if range.length == 0 {
            switch range.location {
            case 3:
                appendString = "."
            case 7:
                appendString = "."
            case 11:
                appendString = "-"
            default:
                break
            }
        }

        textField.text?.append(appendString)

        if (textField.text?.count)! > 13 && range.length == 0 {
            return false
        }

        return true
    }
}

// MARK: - CPFOutnputProtocol

extension CPFViewController: CPFOutputProtocol {
    func failure() {
        errorLabel.isHidden = false
    }
}
