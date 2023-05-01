//
//  FavoritesViewModel.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Foundation

protocol FavoriteViewModelProtocol {
    var view: FavoriteScreenDelegate? {get set}
    func viewDidLoad()
}

final class FavoritesViewModel {
    weak var view: FavoriteScreenDelegate?
}

extension FavoritesViewModel: FavoriteViewModelProtocol {
    func viewDidLoad() {
        view?.configureVC()
    }
}
