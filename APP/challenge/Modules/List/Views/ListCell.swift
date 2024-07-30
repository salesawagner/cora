//
//  ListRow.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

final class ListCell: UITableViewCell {
    static var identifier = String(describing: ListCell.self)

    // MARK: Properties

    private let iconImageView = UIImageView()
    private let amountLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let nameLabel = UILabel()
    private let hourLabel = UILabel()

    // MARK: Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        iconImageView.backgroundColor = .clear
    }

    // MARK: Private Methods

    private func setupUI() {
        setupIcon()
        setupLabels()
        setupStackView()
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    private func setupIcon() {
        let size = 24.0
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: size),
            iconImageView.heightAnchor.constraint(equalToConstant: size)
        ])
    }

    private func setupLabels() {
        amountLabel.font = UIFont.preferredFont(forTextStyle: .body).bold()
        amountLabel.textColor = .init(r: 26, g: 147, b: 218)

        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .init(r: 26, g: 147, b: 218)

        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        hourLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        hourLabel.textAlignment = .right
    }

    private func setupStackView() {
        let stackViewVertical = UIStackView()
        stackViewVertical.axis = .vertical

        stackViewVertical.addArrangedSubview(amountLabel)
        stackViewVertical.addArrangedSubview(descriptionLabel)
        stackViewVertical.addArrangedSubview(nameLabel)

        let stackViewHorizontal = UIStackView()
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.spacing = 16
        stackViewHorizontal.alignment = .top

        stackViewHorizontal.addArrangedSubview(iconImageView)
        stackViewHorizontal.addArrangedSubview(stackViewVertical)
        stackViewHorizontal.addArrangedSubview(hourLabel)

        stackViewHorizontal.fill(on: contentView, insets: .all(constant: 24))
    }

    // MARK: Internal Methods

    func setup(with viewModel: ListRowViewModel) {
        descriptionLabel.text = viewModel.description
        amountLabel.text = viewModel.amount
        nameLabel.text = viewModel.name
        hourLabel.text = viewModel.dateEvent

        switch viewModel.entryType {
        case .debit: iconImageView.image = UIImage(named: "ic_arrow-up-out")
        case .credit: iconImageView.image = UIImage(named: "ic_arrow-down-in")
        }
    }
}
