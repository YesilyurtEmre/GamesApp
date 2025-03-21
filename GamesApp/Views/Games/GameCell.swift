//
//  GameCell.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 20.03.2025.
//

import UIKit
import SnapKit

class GameCell: UITableViewCell {
    static let identifier = "GameCell"
    
    private let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.robotoBold(ofSize: 20)
        label.textColor = UIColor.titleColor
        return label
    }()
    
    private let metacriticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.robotoBold(ofSize: 14)
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.robotoLight(ofSize: 13)
        label.textColor = UIColor.genreColor
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
    
    func configure(with game: GameViewModelItem) {
        titleLabel.text = game.title
        
        let metacriticText = "metacritic: \(game.metacritic)"
        let metacriticAttributedString = NSMutableAttributedString(string: metacriticText)
        
        if let range = metacriticText.range(of: "metacritic: ") {
            let nsRange = NSRange(range, in: metacriticText)
            metacriticAttributedString.addAttribute(.foregroundColor, value: UIColor.primaryBlack, range: nsRange)
        }
        
        if let range = metacriticText.range(of: game.metacritic) {
            let nsRange = NSRange(range, in: metacriticText)
            metacriticAttributedString.addAttribute(.foregroundColor, value: UIColor.rateColor, range: nsRange)
            metacriticAttributedString.addAttribute(.font, value: UIFont.robotoBold(ofSize: 18), range: nsRange)
        }
        
        metacriticLabel.attributedText = metacriticAttributedString
        
        genreLabel.text = game.genres
        
        if let url = URL(string: game.imageURL) {
            gameImageView.loadImage(from: url)
        }
    }
    
}
