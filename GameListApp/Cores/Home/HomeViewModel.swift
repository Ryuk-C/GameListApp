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
    func search(_ text: String?)
}

final class HomeViewModel {
    weak var view: HomeScreenDelegate?
    private var service = GameService()
    var games: [BaseResponse] = []
    var gamesList: [Game] = []
    var paging = false
    var nextPageUrl = ""
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
        service.fetchGames(pageSize: pageSize, paging: paging, newUrl: nextPageUrl) {[weak self] results in
            guard let self else { return }
            //self.view?.setLoading(isLoading: false)
            switch results {
            case .success(let games):
                DispatchQueue.main.async {
                    //self.gamesList.append(contentsOf: games?.results ?? [])
                    self.paging = true
                    self.nextPageUrl = games?.next ?? ""
                    self.view?.reloadCollectionView()
                }
           
            case .failure(_):
                self.view?.dataError()
            }
        }
    }
    
    func search(_ text: String?) {
        
        if let text = text, !text.isEmpty {
            let searchData = self.gamesList.filter { $0.name!.lowercased().contains(text.lowercased()) }
            self.gamesList = searchData
            self.view?.reloadCollectionView()
        } else {
            getGames()
        }
    }
}
