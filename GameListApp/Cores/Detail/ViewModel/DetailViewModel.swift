//
//  DetailViewModel.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var view: DetailScreenDelegate? { get set }

    var detailName: String? { get set }
    var detailDescription: String? { get set }
    var detailBackgroundImage: String? { get set }
    var detailWebsite: String? { get set }

    func viewDidLoad(id: Int)
    func getDetail(id: Int)
    func checkFav() -> Bool
    func addFavorite()
}

final class DetailViewModel {

    weak var view: DetailScreenDelegate?
    private let service = GameService()
    private let coreDataManager = CoreDataFavoriteHelper()

    var detailName: String?
    var detailDescription: String?
    var detailBackgroundImage: String?
    var detailWebsite: String?
}

extension DetailViewModel: DetailViewModelProtocol {

    func addFavorite() {

        if let detailName, !checkFav() {
            coreDataManager.addFavorite(name: detailName, imageURL: detailBackgroundImage ?? "")
        } else {
            if let index = coreDataManager.getFavorites()?.firstIndex(where: { $0.name == self.detailName }) {
                coreDataManager.deleteFavorite(index: index)
            }
        }
    }

    func getDetail(id: Int) {
        view?.setLoading(isLoading: true)
        service.fetchDetail(id: id) { [weak self] detail in
            guard let self = self else { return }
            self.view?.setLoading(isLoading: false)
            switch detail {
            case .success(let detailList):
                DispatchQueue.main.async {

                    self.detailName = detailList?.name
                    self.detailDescription = detailList?.description
                    self.detailBackgroundImage = detailList?.backgroundImage
                    self.detailWebsite = detailList?.website
                    self.view?.setDetails()
                    self.view?.prepareFavButton()
                }

            case .failure(let error):
                print(error)
                self.view?.dataError()
            }
        }
    }

    func checkFav() -> Bool {
        
        if coreDataManager.getFavorites()?.contains(where: { $0.name == self.detailName }) == true {
            return true
        } else {
            return false
        }
    }

    func viewDidLoad(id: Int) {
        view?.configureVC()
        getDetail(id: id)
    }
}
