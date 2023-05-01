//
//  HomeScreen.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import UIKit

protocol HomeScreenDelegate: AnyObject {
    func configureVC()
}

final class HomeScreen: UIViewController {

    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension HomeScreen: HomeScreenDelegate {
    func configureVC() {
        view.backgroundColor = .red
    }
}
