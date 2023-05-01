//
//  FavoriteScreen.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import UIKit

protocol FavoriteScreenDelegate: AnyObject {
    func configureVC()
}

final class FavoriteScreen: UIViewController {

    var viewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension FavoriteScreen: FavoriteScreenDelegate {
    func configureVC() {
        view.backgroundColor = .systemGray5
    }
}
