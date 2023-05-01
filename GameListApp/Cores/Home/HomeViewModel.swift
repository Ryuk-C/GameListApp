//
//  HomeViewModel.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Foundation

protocol HomeViewModelProtocol {
    var view: HomeScreenDelegate? {get set}
    func viewDidLoad()
    func getGames()
}

final class HomeViewModel {
    
    weak var view: HomeScreenDelegate?
    private var service = GameService()
    var games: [BaseResponse] = []
    var gamesList: [Game] = []
    var paging = false
    var nextPageUrl = ""
    var page = 1
    var pageSize = 55
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func viewDidLoad() {
        
        view?.configureVC()
        getGames()
        view?.configureCollectionView()
    }
    
    func getGames() {
        self.view?.setLoading(isLoading: true)
        service.fetchGames(page: page, pageSize: pageSize, paging: paging, newUrl: nextPageUrl) {[weak self] results in
            guard let self else { return }
            self.view?.setLoading(isLoading: false)
            switch results {
            case .success(let games):
                DispatchQueue.main.async {
                   // s//elf.games = games
                    self.gamesList.append(contentsOf: games?.results ?? [])
                    self.paging = true
                    self.nextPageUrl = games?.next ?? ""
                    self.view?.reloadCollectionView()
                }
           
            case .failure(let error):
                print(error)
                //self.delegate?.dataError()
            }
        }
        
        
    }
}
