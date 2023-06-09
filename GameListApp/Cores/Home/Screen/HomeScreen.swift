//
//  HomeScreen.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import UIKit

protocol HomeScreenDelegate: AnyObject {
    func setLoading(isLoading: Bool)
    func dataError()
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
    func navigateToDetailScreen(id: Int, gameTitle: String)
}

final class HomeScreen: UIViewController {

    var viewModel = HomeViewModel()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Type here to search"
        searchBar.searchBarStyle = .prominent
        return searchBar
    }()
    
    private var collectionView: UICollectionView!
    private lazy var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension HomeScreen: HomeScreenDelegate {
    
    func dataError() {
        self.errorMessage(title: "Error", message: "Games could not loaded! Please try again.")
    }
    
    func reloadCollectionView() {
        
        collectionView.reloadOnMainThread()
    }
    
    func configureCollectionView() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(GamesCell.self, forCellWithReuseIdentifier: GamesCell.reuseID)
        
        collectionView!.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func configureVC() {
        
        view.backgroundColor = .white
        
        title = "Games"
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        view.addSubview(activityIndicator)
        
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func tapDone(sender: Any) {
            self.view.endEditing(true)
        }
    
    func navigateToDetailScreen(id: Int, gameTitle: String) {
        
        DispatchQueue.main.async {
            
            self.navigationController?.pushViewController(
                DetailScreen(gameID: id, gameTitle: gameTitle), animated: true
            )
        }
    }
}

extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.gamesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCell.reuseID,
                                                      for: indexPath) as! GamesCell
        
        cell.design(gameImageURL: viewModel.gamesList[indexPath.item].backgroundImage ?? "",
                    gameName: viewModel.gamesList[indexPath.item].name ?? "")
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY >= contentHeight - (2 * height) {
            viewModel.getGames()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateToDetailScreen(id: viewModel.gamesList[indexPath.item].id ?? 0,
                                         gameTitle: viewModel.gamesList[indexPath.item].name ?? ""
        )
    }
}

extension HomeScreen: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.search(searchText)
    }
}
