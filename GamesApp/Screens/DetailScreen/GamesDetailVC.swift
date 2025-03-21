//
//  GamesDetailVC.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 21.03.2025.
//

import UIKit
import SnapKit
import SDWebImage

class GamesDetailVC: UIViewController {
    
    // MARK: - UI Elements
    
    private let gameImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let redditLabel = UILabel()
    private let websiteLabel = UILabel()
    
    let viewModel = GameDetailViewModel()
    var gameId: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        bindViewModel()
        
        if let id = gameId {
            viewModel.fetchGameDetail(gameId: id)
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    private func bindViewModel() {
        viewModel.onDataFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.configureView()
            }
        }
    }
    
    private func configureView() {
        guard let item = viewModel.gameDetailItem else { return }
        
        titleLabel.text = item.title
        descriptionLabel.text = viewModel.getShortenedDescription(item.description)
        gameImageView.sd_setImage(with: URL(string: item.imageURL))
        redditLabel.text = "Visit reddit: \(item.redditURL)"
        websiteLabel.text = "Visit website: \(item.websiteURL)"
    }
    
    private func setupViews() {
        gameImageView.contentMode = .scaleToFill
        gameImageView.clipsToBounds = true
        view.addSubview(gameImageView)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        
        descriptionTitleLabel.text = "Game Description"
        descriptionTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        descriptionTitleLabel.textColor = .black
        view.addSubview(descriptionTitleLabel)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        
        redditLabel.text = "Visit reddit"
        redditLabel.font = UIFont.systemFont(ofSize: 17)
        redditLabel.textColor = .black
        view.addSubview(redditLabel)
        
        websiteLabel.text = "Visit website"
        websiteLabel.font = UIFont.systemFont(ofSize: 17)
        websiteLabel.textColor = .black
        view.addSubview(websiteLabel)
    }
    
    private func setupConstraints() {
        gameImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.35)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(gameImageView.snp.bottom).offset(-30)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(gameImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        redditLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(16)
        }
        
        websiteLabel.snp.makeConstraints { make in
            make.top.equalTo(redditLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    func configure(with game: GameDetail) {
        titleLabel.text = game.name
        descriptionLabel.text = game.description
        gameImageView.sd_setImage(with: URL(string: game.background_image ?? ""))
        redditLabel.text = "Visit reddit"
        websiteLabel.text = "Visit website"
    }
}
