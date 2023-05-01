//
//  UICollectionView+Ext.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import UIKit

extension UICollectionView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
