//
//  FavoritesViewModel.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Foundation

protocol FavoriteViewModelProtocol {
    var view: FavoriteScreenDelegate? {get set}
    
    func fetchFavGames()
    func unFavButtonTapped(index: Int)
    func viewDidLoad()
}

final class FavoritesViewModel {
    weak var view: FavoriteScreenDelegate?
    
    var favGames: [Favorite] = [Favorite]()
    var coreDataHelper = CoreDataFavoriteHelper()
}

extension FavoritesViewModel: FavoriteViewModelProtocol {
    
    func fetchFavGames() {
        
        self.favGames = coreDataHelper.getFavorites() ?? []
        self.view?.dataRefreshed()
    }
    
    func unFavButtonTapped(index: Int) {
        
        coreDataHelper.deleteFavorite(index: index)
        self.view?.dataRefreshed()
        fetchFavGames()
    }
    
    func viewDidLoad() {
        view?.configureVC()
        fetchFavGames()
    }
}
