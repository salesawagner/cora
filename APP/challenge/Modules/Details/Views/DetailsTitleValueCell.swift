//
//  DetailsAmountCell.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

final class DetailsTitleValueCell: UITableViewCell {
    static var identifier = String(describing: DetailsTitleValueCell.self)

    // MARK: Properties

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

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
        valueLabel.font = UIFont.preferredFont(forTextStyle: .body).bold()
    }

    private func setupStackView() {
        let stackViewHorizontal = UIStackView()
        stackViewHorizontal.axis = .vertical
        stackViewHorizontal.spacing = 8

        stackViewHorizontal.addArrangedSubview(titleLabel)
        stackViewHorizontal.addArrangedSubview(valueLabel)

        stackViewHorizontal.fill(on: contentView, insets: .init(top: 12, left: 24, bottom: 12, right: 24))
    }

    // MARK: Internal Methods

    func setup(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
