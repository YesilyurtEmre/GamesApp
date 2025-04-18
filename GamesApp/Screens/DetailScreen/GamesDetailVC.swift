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
  private let scrollView = UIScrollView()
  private let contentView = UIView()
  private let gameImageView = UIImageView()
  private let titleLabel = UILabel()
  private let descriptionTitleLabel = UILabel()
  private let descriptionTextView = UITextView()
  private let redditButton = UIButton()
  private let websiteButton = UIButton()
  private var favouriteButton: UIBarButtonItem!
  let viewModel: GameDetailViewModel = {
    let service = APIService.shared
    return GameDetailViewModel(gameService: service)
  }()
  var gameItem: GameViewModelItem?
  var gameId: Int?
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupViews()
    setupConstraints()
    bindViewModel()
    fetchGameDetail()
    setupFavouriteButton()
    navigationItem.largeTitleDisplayMode = .never
  }
  private func fetchGameDetail() {
    guard let id = gameId else { return }
    viewModel.fetchGameDetail(gameId: id)
  }
  private func bindViewModel() {
    viewModel.onDataFetched = { [weak self] in
      DispatchQueue.main.async {
        self?.configureView()
      }
    }
  }
  private func setupFavouriteButton() {
    guard let id = gameId else { return }
    let title = CoreDataManager.shared.isFavorite(id: Int32(id)) ? "Remove from Favourites" : "Add to Favourites"
    favouriteButton = UIBarButtonItem(
      title: title,
      style: .plain,
      target: self,
      action: #selector(favouriteButtonTapped))
    navigationItem.rightBarButtonItem = favouriteButton
  }
  @objc private func favouriteButtonTapped() {
    guard let game = gameItem, let id = gameId else {
      print("Game item is nil!")
      return
    }
    if CoreDataManager.shared.isFavorite(id: Int32(id)) {
      CoreDataManager.shared.removeFromFavorites(id: Int32(id))
      favouriteButton.title = "Add to Favourites"
      AlertManager.shared.showFavoriteRemovedAlert(on: self, gameName: game.title)
    } else {
      CoreDataManager.shared.addToFavorites(gameItem: game)
      favouriteButton.title = "Remove from Favourites"
      AlertManager.shared.showFavoriteAddedAlert(on: self, gameName: game.title)
    }
  }
  private var divider1 = UIView()
  private var divider2 = UIView()
  private var divider3 = UIView()
  private func createDivider() -> UIView {
    let divider = UIView()
    divider.backgroundColor = .lightGray
    return divider
  }
  private func configureView() {
    guard let item = viewModel.gameDetailItem else { return }
    titleLabel.text = item.title
    descriptionTextView.text = viewModel.cleanHTMLTags(from: item.description)
    descriptionTextView.sizeToFit()
    gameImageView.sd_setImage(with: URL(string: item.imageURL))
    redditButton.setTitle("Visit Reddit", for: .normal)
    websiteButton.setTitle("Visit Website", for: .normal)
    redditButton.accessibilityValue = item.redditURL
    websiteButton.accessibilityValue = item.websiteURL
  }
  private func setupViews() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    gameImageView.contentMode = .scaleToFill
    gameImageView.clipsToBounds = true
    contentView.addSubview(gameImageView)
    titleLabel.font = UIFont.robotoBold(ofSize: 36)
    titleLabel.textColor = .white
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    contentView.addSubview(titleLabel)
    descriptionTitleLabel.text = "Game Description"
    descriptionTitleLabel.font = UIFont.robotoRegular(ofSize: 19)
    descriptionTitleLabel.textColor = .primaryBlack
    contentView.addSubview(descriptionTitleLabel)
    descriptionTextView.font = UIFont.robotoMedium(ofSize: 15)
    descriptionTextView.textColor = .darkGrayText
    descriptionTextView.isEditable = false
    descriptionTextView.isScrollEnabled = false
    descriptionTextView.isSelectable = false
    descriptionTextView.textContainer.lineBreakMode = .byWordWrapping
    contentView.addSubview(descriptionTextView)
    divider1 = createDivider()
    divider2 = createDivider()
    divider3 = createDivider()
    contentView.addSubview(divider1)
    redditButton.setTitleColor(.darkGrayText, for: .normal)
    redditButton.contentHorizontalAlignment = .left
    redditButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    contentView.addSubview(redditButton)
    contentView.addSubview(divider2)
    websiteButton.setTitleColor(.darkGrayText, for: .normal)
    websiteButton.contentHorizontalAlignment = .left
    websiteButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    contentView.addSubview(websiteButton)
    contentView.addSubview(divider3)
    redditButton.addTarget(self, action: #selector(openReddit), for: .touchUpInside)
    websiteButton.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
  }
  @objc private func openReddit() {
    guard let urlString = redditButton.accessibilityValue,
          viewModel.isValidURL(urlString) else {
      AlertManager.shared.showErrorAlert(on: self, message: "Invalid Reddit URL")
      return
    }
    guard let url = URL(string: urlString) else {
      AlertManager.shared.showErrorAlert(on: self, message: "Invalid Reddit URL")
      return
    }
    openInSafari(url: url)
  }
  @objc private func openWebsite() {
    guard let urlString = websiteButton.accessibilityValue,
          viewModel.isValidURL(urlString) else {
      AlertManager.shared.showErrorAlert(on: self, message: "Invalid Website URL")
      return
    }
    guard let url = URL(string: urlString) else {
      AlertManager.shared.showErrorAlert(on: self, message: "Invalid Website URL")
      return
    }
    openInSafari(url: url)
  }
  private func openInSafari(url: URL) {
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
      AlertManager.shared.showErrorAlert(on: self, message: "Cannot open the URL")
    }
  }
  private func setupConstraints() {
    scrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    contentView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
      make.width.equalTo(scrollView)
    }
    gameImageView.snp.makeConstraints { make in
      make.top.equalTo(contentView)
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
    descriptionTextView.snp.makeConstraints { make in
      make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(8)
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(redditButton.snp.top).offset(-24)
    }
    divider1.snp.makeConstraints { make in
      make.top.equalTo(descriptionTextView.snp.bottom).offset(8)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(1)
    }
    redditButton.snp.makeConstraints { make in
      make.top.equalTo(descriptionTextView.snp.bottom).offset(24)
      make.leading.equalToSuperview().inset(16)
    }
    divider2.snp.makeConstraints { make in
      make.top.equalTo(redditButton.snp.bottom).offset(8)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(1)
    }
    websiteButton.snp.makeConstraints { make in
      make.top.equalTo(redditButton.snp.bottom).offset(16)
      make.leading.equalToSuperview().inset(16)
      make.bottom.equalTo(contentView.snp.bottom).offset(-16)
    }
    divider3.snp.makeConstraints { make in
      make.top.equalTo(websiteButton.snp.bottom).offset(8)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(1)
    }
  }
}
