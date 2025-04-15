//
//  GamesVC.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 19.03.2025.
//

import UIKit
import SnapKit

class GamesVC: UIViewController {
  private var viewModel: GamesViewModel!
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    let service = APIService.shared
    viewModel = GamesViewModel(service: service)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private let tableView = UITableView()
  private let searchController = UISearchController(searchResultsController: nil)
  private var filteredGames: [GameViewModelItem] = []
  private let loadingIndicator = UIActivityIndicatorView(style: .medium)
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  var isFiltering: Bool {
    return searchController.isActive && !isSearchBarEmpty
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupSearchController()
    setupTableView()
    setupConstraints()
    fetchGames()
    setupBindings()
    setupLoadingIndicator()
  }
  private func setupLoadingIndicator() {
    loadingIndicator.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
    loadingIndicator.hidesWhenStopped = true
    tableView.tableFooterView = loadingIndicator
  }
  private func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search for the games"
    searchController.searchBar.searchBarStyle = .minimal
    searchController.searchBar.tintColor = .primaryBlack
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
  private func setupBindings() {
    viewModel.onGamesFetched = { [weak self] in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
        self?.loadingIndicator.stopAnimating()
      }
      self?.viewModel.onError = { [weak self] _ in
        self?.loadingIndicator.stopAnimating()
      }
    }
    viewModel.onError = { [weak self] errorMessage in
      DispatchQueue.main.async {
        guard let self = self else { return }
        AlertManager.shared.showErrorAlert(on: self, message: errorMessage)
      }
    }
  }
  private func fetchGames() {
    viewModel.fetchGames()
  }
  private func setupTableView() {
    tableView.register(GameCell.self, forCellReuseIdentifier: GameCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 136
    tableView.separatorStyle = .none
    view.addSubview(tableView)
  }
  private func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

extension GamesVC: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering && filteredGames.isEmpty {
      return 0
    }
    return isFiltering ? filteredGames.count : viewModel.numberOfGames
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: GameCell.identifier,
      for: indexPath
    ) as? GameCell else {
      fatalError("GameCell couldn't be dequeued.")
    }
    let game = isFiltering ? filteredGames[indexPath.row] : viewModel.game(at: indexPath.row)
    cell.configure(with: game)
    return cell
  }
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == viewModel.numberOfGames - 3 && !viewModel.isLoading {
      viewModel.fetchGames()
      loadingIndicator.startAnimating()
    }
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedGame = isFiltering ? filteredGames[indexPath.row] : viewModel.game(at: indexPath.row)
    let detailVC = GamesDetailVC()
    detailVC.hidesBottomBarWhenPushed = true
    detailVC.gameId = selectedGame.id
    detailVC.gameItem = selectedGame
    navigationController?.pushViewController(detailVC, animated: true)
  }
}

extension GamesVC: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchText = searchController.searchBar.text ?? ""
    guard searchText.count >= 3 else {
      filteredGames = []
      tableView.reloadData()
      return
    }
    viewModel.searchGames(with: searchText) { [weak self] results in
      DispatchQueue.main.async {
        self?.filteredGames = results
        self?.tableView.reloadData()
      }
    }
  }
}
