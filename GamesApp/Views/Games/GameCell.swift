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
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.titleColor
        return label
    }()
    
    private let metacriticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.rateColor
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
    
    func configure(with game: Game) {
        titleLabel.text = game.title
        metacriticLabel.text = "Metacritic: \(game.metacriticScore)"
        genreLabel.text = game.genre
        gameImageView.image = UIImage(named: game.imageName)
    }
}
