//
//  GamesVC.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 19.03.2025.
//

import UIKit
import SnapKit

class GamesVC: UIViewController {
    private let viewModel = GamesViewModel()
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredGames: [GameViewModelItem] = []
    
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
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showErrorAlert(errorMessage)
            }
        }
    }
    
    private func fetchGames() {
        viewModel.fetchGames()
    }
    
    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
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
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredGames = viewModel.gameItems.filter { game in
            return game.title.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        let game = isFiltering ? filteredGames[indexPath.row] : viewModel.game(at: indexPath.row)
        cell.configure(with: game)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGame = isFiltering ? filteredGames[indexPath.row] : viewModel.game(at: indexPath.row)
        let detailVC = GamesDetailVC()
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.gameId = selectedGame.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension GamesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        filterContentForSearchText(searchText)
    }
}

