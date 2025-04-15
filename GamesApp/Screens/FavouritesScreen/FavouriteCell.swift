//
//  FavouriteCell.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 27.03.2025.
//

import UIKit
import SnapKit

class FavouritesCell: UITableViewCell {
    static let identifier = "FavouritesCell"
    private let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.robotoBold(ofSize: 20)
        label.textColor = .titleColor
        return label
    }()
    private let metacriticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.robotoBold(ofSize: 14)
        return label
    }()
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.robotoMedium(ofSize: 13)
        label.textColor = .genreColor
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        contentView.addSubview(gameImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(metacriticLabel)
        contentView.addSubview(genreLabel)
    }
    private func setupConstraints() {
        gameImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(104)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(gameImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(52)
        }
        metacriticLabel.snp.makeConstraints { make in
            make.leading.equalTo(gameImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.height.equalTo(16)
        }
        genreLabel.snp.makeConstraints { make in
            make.leading.equalTo(gameImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(gameImageView.snp.bottom)
            make.height.equalTo(16)
        }
    }
    func configure(with game: FavouriteGame) {
        titleLabel.text = game.name
        metacriticLabel.attributedText = formattedMetacriticText(for: game.metacritic ?? "0")
        genreLabel.text = game.genres
        if let urlString = game.imageURL, let url = URL(string: urlString) {
            gameImageView.loadImage(from: url)
        }
    }
    private func formattedMetacriticText(for score: String) -> NSAttributedString {
        let metacriticText = "metacritic: \(score)"
        let attributedString = NSMutableAttributedString(string: metacriticText)
        if let range = metacriticText.range(of: "metacritic: ") {
            let nsRange = NSRange(range, in: metacriticText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.primaryBlack, range: nsRange)
        }
        if let range = metacriticText.range(of: score) {
            let nsRange = NSRange(range, in: metacriticText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.rateColor, range: nsRange)
            attributedString.addAttribute(.font, value: UIFont.robotoBold(ofSize: 18), range: nsRange)
        }
        return attributedString
    }
}
