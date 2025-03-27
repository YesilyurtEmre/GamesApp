//
//  FavouritesVC.swift
//  GamesApp
//
//  Created by Emre Yeşilyurt on 19.03.2025.
//

import UIKit

class FavouritesVC: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = FavouritesViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        viewModel.fetchFavourites()
        setupBindings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavourites()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupBindings() {
        viewModel.onFavouritesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                guard let self = self else { return }
                AlertManager.shared.showErrorAlert(on: self, message: errorMessage)
            }
        }
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
    
    private func updateUI() {
        updateTabBarTitle()
        tableView.reloadData()
        viewModel.isEmpty() ? showEmptyState() : hideEmptyState()
    }
    
    private func updateTabBarTitle() {
        let title = viewModel.getTitleWithCount()
        self.title = title
        self.tabBarItem.title = title
        self.tabBarItem.badgeValue = viewModel.numberOfFavourites() > 0 ? "\(viewModel.numberOfFavourites())" : nil
    }
    
    private func showEmptyState() {
        let label = UILabel()
        label.text = "There is no favourites found."
        label.textAlignment = .center
        label.font = UIFont.robotoBold(ofSize: 18)
        label.textColor = .descriptionColor
        tableView.backgroundView = label
    }
    
    private func hideEmptyState() {
        tableView.backgroundView = nil
    }
    
}

extension FavouritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFavourites()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesCell.identifier, for: indexPath) as! FavouritesCell
        cell.configure(with: viewModel.favouriteGame(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            
            let game = self.viewModel.favouriteGame(at: indexPath.row)
            self.viewModel.deleteFavourite(game: game)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}
