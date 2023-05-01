//
//  GamesCell.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Kingfisher
import UIKit

final class GamesCell: UICollectionViewCell {
    
    static var reuseID = "GamesCell"
    
    private lazy var gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var gameNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        
        contentView.addSubview(gameImageView)
        contentView.addSubview(gameNameLabel)
        
        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
        gameImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            gameNameLabel.bottomAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: -10)
        ])
    }
    
    func design(gameImageURL: String, gameName: String) {
        guard let url = URL(string: gameImageURL) else { return }
        gameImageView.kf.setImage(with: url)
        gameNameLabel.text = gameName
    }
}
