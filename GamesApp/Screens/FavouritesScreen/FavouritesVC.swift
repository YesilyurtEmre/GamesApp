//
//  FavouritesVC.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 19.03.2025.
//

import UIKit

class FavouritesVC: UIViewController {
    private let tableView = UITableView()
    private var favoriteGames: [FavouriteGame] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loadFavorites()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(FavouritesCell.self, forCellReuseIdentifier: FavouritesCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 136
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadFavorites() {
        favoriteGames = CoreDataManager.shared.getFavoriteGames()
        tableView.reloadData()
        
        if favoriteGames.isEmpty {
            showEmptyState()
        } else {
            hideEmptyState()
        }
    }
    
    private func showEmptyState() {
        let label = UILabel()
        label.text = "There is no favourites found."
        label.textAlignment = .center
        label.textColor = .gray
        tableView.backgroundView = label
    }
    
    private func hideEmptyState() {
        tableView.backgroundView = nil
    }
}

extension FavouritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesCell.identifier, for: indexPath) as! FavouritesCell
        cell.configure(with: favoriteGames[indexPath.row])
        return cell
    }
    
}
