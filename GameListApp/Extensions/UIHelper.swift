//
//  UIHelper.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import UIKit

enum UIHelper {
    static func createHomeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = CGFloat.dWidth
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (itemWidth * 0.5) - 20, height: itemWidth / 2.1)
        
        layout.minimumLineSpacing = 15
        
        return layout
    }
}
