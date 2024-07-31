//
//  DetailsRow.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

final class DetailsIconCell: UITableViewCell {
    static var identifier = String(describing: DetailsIconCell.self)

    // MARK: Properties

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()

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
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body).bold()
    }

    private func setupStackView() {
        let stackViewHorizontal = UIStackView()
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.spacing = 8
        stackViewHorizontal.alignment = .top

        stackViewHorizontal.addArrangedSubview(iconImageView)
        stackViewHorizontal.addArrangedSubview(titleLabel)

        stackViewHorizontal.fill(on: contentView, insets: .init(top: 24, left: 24, bottom: 12, right: 24))
    }

    // MARK: Internal Methods

    func setup(iconNamed: String, title: String) {
        iconImageView.image = UIImage(named: iconNamed)
        titleLabel.text = title
    }
}
