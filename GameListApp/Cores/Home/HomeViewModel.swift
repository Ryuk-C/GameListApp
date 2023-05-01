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
}

final class HomeViewModel {
    
    weak var view: HomeScreenDelegate?
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func viewDidLoad() {
        
        view?.configureVC()
    }
}
