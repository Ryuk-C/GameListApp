//
//  DetailScreen.swift
//  GameListApp
//
//  Created by Cuma Haznedar on 01/05/2023.
//

import Kingfisher
import SafariServices
import UIKit

protocol DetailScreenDelegate: AnyObject {
    func setLoading(isLoading: Bool)
    func dataError()
    func configureVC()
    func prepareFavButton()
    func setDetails()
}

final class DetailScreen: UIViewController {

    var viewModel: DetailViewModel
    var gameID: Int
    var gameTitle: String

    private lazy var activityIndicator = UIActivityIndicatorView()

    private lazy var detailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var detailName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var detailDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var websiteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.setTitle("Go to official website", for: UIControl.State.normal)
        button.setTitleColor(UIColor.systemRed, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(viewModel: DetailViewModel = DetailViewModel(), gameID: Int, gameTitle: String) {
        self.viewModel = viewModel
        self.gameID = gameID
        self.gameTitle = gameTitle
        super.init(nibName: nil, bundle: nil)
    }

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad(id: gameID)
    }
}

extension DetailScreen: DetailScreenDelegate {

    func setDetails() {

        if let url = URL(string: viewModel.detailBackgroundImage ?? "") {
            detailImage.kf.setImage(with: url)
        }

        detailName.text = viewModel.detailName ?? ""
        let descriptionText = viewModel.detailDescription?
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "<br>", with: "")
            .replacingOccurrences(of: "<br />", with: "")
        detailDescription.text = descriptionText

        setupScrollView()
    }

    func configureVC() {

        title = gameTitle
        view.backgroundColor = .systemGray5

        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func setLoading(isLoading: Bool) {
        if isLoading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }

    func dataError() {
        self.errorMessage(title: "Error", message: "Game details could not loaded! Please try again.")
    }

    func prepareFavButton() {

        let favButton = UIBarButtonItem(
            image: self.viewModel.checkFav() ? .init(systemName: "star.fill") : .init(systemName: "star"),
            style: .done, target: self, action: #selector(self.starButtonTapped))

        self.navigationItem.rightBarButtonItem = favButton
    }

    // MARK: - Website Button Action & Safari Service
    @objc private func websiteButtonTapped(_ sender: UIButton) {

        if let url = URL(string: viewModel.detailWebsite ?? "") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true)
        }
    }

    // MARK: - Actions
    @objc private func starButtonTapped(_ sender: UIBarButtonItem) {
        if sender.image == .init(systemName: "star.fill") {
            sender.image = .init(systemName: "star")
        } else {
            sender.image = .init(systemName: "star.fill")
        }

        viewModel.addFavorite()
    }

    private func setupScrollView() {
        let margins = view.layoutMarginsGuide
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollView.showsVerticalScrollIndicator = false

        NSLayoutConstraint.activate([

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])

        NSLayoutConstraint.activate([

            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        configureContainerView()
    }

    private func configureContainerView() {

        scrollStackViewContainer.addArrangedSubview(detailImage)
        scrollStackViewContainer.addArrangedSubview(detailName)
        scrollStackViewContainer.addArrangedSubview(detailDescription)
        scrollStackViewContainer.addArrangedSubview(websiteButton)

        scrollStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollStackViewContainer.isLayoutMarginsRelativeArrangement = true
        scrollStackViewContainer.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)

        websiteButton.addTarget(self, action: #selector(websiteButtonTapped(_:)), for: UIControl.Event.touchUpInside)

        let imageWidth = CGFloat.dWidth * 0.5

        NSLayoutConstraint.activate([

            detailImage.topAnchor.constraint(equalTo: scrollStackViewContainer.topAnchor, constant: 10),
            detailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            detailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            detailImage.heightAnchor.constraint(equalToConstant: imageWidth)
        ])

        scrollStackViewContainer.setCustomSpacing(10, after: detailImage)

        NSLayoutConstraint.activate([

            detailDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            detailDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])

        scrollStackViewContainer.setCustomSpacing(10, after: detailName)
        scrollStackViewContainer.setCustomSpacing(25, after: detailDescription)

        NSLayoutConstraint.activate([

            websiteButton.topAnchor.constraint(equalTo: detailDescription.bottomAnchor, constant: 55),
            websiteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            websiteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }
}
