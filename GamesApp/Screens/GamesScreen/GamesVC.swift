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
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupConstraints()
        fetchGames()
    }
    
    private func fetchGames() {
        viewModel.fetchGames { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
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
        return viewModel.numberOfGames
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        let game = viewModel.game(at: indexPath.row)
        cell.configure(with: game)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGame = viewModel.game(at: indexPath.row)
        let detailVC = GamesDetailVC()
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.gameId = selectedGame.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

