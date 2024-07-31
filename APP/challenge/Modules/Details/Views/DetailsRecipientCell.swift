//
//  DetailsRecipientCell.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

final class DetailsRecipientCell: UITableViewCell {
    static var identifier = String(describing: DetailsRecipientCell.self)

    // MARK: Properties

    private let titleLabel = UILabel()
    private let nameLabel = UILabel()
    private let documentLabel = UILabel()
    private let bankLabel = UILabel()
    private let accountLabel = UILabel()

    // MARK: Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setupUI() {
        setupLabels()
        setupStackView()
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    private func setupLabels() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body).bold()
        documentLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        bankLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        accountLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    }

    private func setupStackView() {
        let stackViewHorizontal = UIStackView()
        stackViewHorizontal.axis = .vertical
        stackViewHorizontal.spacing = 8

        stackViewHorizontal.addArrangedSubview(titleLabel)
        stackViewHorizontal.addArrangedSubview(nameLabel)
        stackViewHorizontal.addArrangedSubview(documentLabel)
        stackViewHorizontal.addArrangedSubview(bankLabel)
        stackViewHorizontal.addArrangedSubview(accountLabel)

        stackViewHorizontal.fill(on: contentView, insets: .init(top: 12, left: 24, bottom: 12, right: 24))
    }

    // MARK: Internal Methods

    func setup(title: String, bankName: String, documentNumber: String, name: String, account: String) {
        titleLabel.text = title
        nameLabel.text = name
        documentLabel.text = documentNumber
        bankLabel.text = bankName
        accountLabel.text = account
    }
}
