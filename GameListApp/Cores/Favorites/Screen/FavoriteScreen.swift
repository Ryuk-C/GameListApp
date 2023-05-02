//
//  FavoriteScreen.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Lottie
import UIKit

protocol FavoriteScreenDelegate: AnyObject {
    func dataRefreshed()
    func configureVC()
    func fetchData()
    func createLottie()
}

final class FavoriteScreen: UIViewController {

    var viewModel = FavoritesViewModel()
    
    private var animationView: LottieAnimationView = {
        var lottie = LottieAnimationView()
        lottie = .init(name: "anim_games")
        lottie.contentMode = .scaleAspectFit
        lottie.loopMode = .loop
        lottie.animationSpeed = 1
        lottie.translatesAutoresizingMaskIntoConstraints = false
        lottie.play()
        return lottie
    }()
    
    private lazy var lottieLabel: UILabel = {
        let label = UILabel()
        label.text = "The game was not found in the favorite list."
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var favoritesTableview: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritesTableViewCell.self,
                           forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewDidLoad()
    }
}

extension FavoriteScreen: FavoriteScreenDelegate {
    func createLottie() {
        view.addSubview(animationView)
        view.addSubview(lottieLabel)
        
        let lottieHeight = CGFloat.dHeight * 0.9
        let lottieWidth = CGFloat.dWidth * 0.9

        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.heightAnchor.constraint(equalToConstant: lottieHeight),
            animationView.widthAnchor.constraint(equalToConstant: lottieWidth)
        ])
        
        NSLayoutConstraint.activate([
            lottieLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: -170),
            lottieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func dataRefreshed() {
        
        if viewModel.favGames.isEmpty {
            
            createLottie()
        }
            
       self.favoritesTableview.reloadData()
    }
    
    func fetchData() {
        viewModel.fetchFavGames()
    }
    
    func configureVC() {
        view.backgroundColor = .systemGray5
        title = "Favorites"
        
        view.addSubview(favoritesTableview)
        favoritesTableview.translatesAutoresizingMaskIntoConstraints = false
        
        favoritesTableview.delegate = self
        favoritesTableview.dataSource = self
        
        favoritesTableview.pinToEdgesOf(view: view)
    }
    
    @objc private func unFavButtonTapped(_ sender: UIButton) {
       
        viewModel.unFavButtonTapped(index: sender.tag)
    }
}

extension FavoriteScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.favGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoritesTableViewCell.identifier,
            for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        
        cell.unFavButton.tag = indexPath.row
        cell.selectionStyle = .none
        cell.design(name: viewModel.favGames[indexPath.row].name ?? "")
        cell.unFavButton.addTarget(self, action: #selector(unFavButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
