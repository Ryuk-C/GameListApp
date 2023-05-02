//
//  FavoritesTableViewCell.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 02/05/2023.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    
    static let identifier = "FavoritesTableViewCell"
    
    private lazy var favNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var unFavButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        button.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        contentView.addSubview(favNameLabel)
        contentView.addSubview(unFavButton)
        
        NSLayoutConstraint.activate([
            favNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            favNameLabel.trailingAnchor.constraint(equalTo: unFavButton.trailingAnchor, constant: 4),
            favNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            favNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            unFavButton.centerYAnchor.constraint(equalTo: favNameLabel.centerYAnchor),
            unFavButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }

    func design(name: String) {
        favNameLabel.text = name
    }
}
