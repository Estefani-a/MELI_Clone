//
//  RecentCarousel.swift
//  AppIosW6CodePatrollExample
//
//  Created by Estefania Sassone on 24/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

protocol RecentCarouselDelegate {
    func goToDetail()
}

class RecentCarousel: UIView {

    var delegate: RecentCarouselDelegate?
    var latest: [LatestData] = []
    let homeViewModel = HomeViewModel()
//    let viewModel = ListViewModel(remoteService: RemoteService(), localService: LocalService())
    
    private lazy var recentCarousel: AndesCarousel = .load() { element in
        element.mode = .snapped
        element.margin = .defaultMargin
        element.dataSource = self
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        updateCarousel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.addSubview(recentCarousel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recentCarousel.topAnchor.constraint(equalTo: topAnchor),
            recentCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
            recentCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
            recentCarousel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            recentCarousel.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    public func updateCarousel() {
        LatestManager.getLatest { result in
            self.latest = result.reversed()
        }
        recentCarousel.dataSource = self
    }
    
    func goToDetail() {
        delegate?.goToDetail()
    }
}

extension RecentCarousel: AndesCarouselDataSource {
    func andesCarousel(_ carouselView: AndesCarousel, cellForRowAt indexPath: IndexPath) -> UIView {
        return setupRecentCaroussel(indexPath: indexPath)
    }
    
    func getDataSetSize(_ carouselView: AndesCarousel) -> Int {
        return latest.count
    }

    func setupRecentCaroussel(indexPath: IndexPath) -> UIView {
        let currentData = latest[indexPath.row].itemData
//        let dataWithCategory = latest[indexPath.row]
        let recentCard = AndesCard()
        let recentImage = UIImageView()
        let title = currentData.title
        let secureURLThumb = homeViewModel.getSecureThumbnail(thumbnail: currentData.thumbnail)
        recentImage.pin_setImage(from: URL(string: secureURLThumb))
        recentCard.cardView = cardView(image: recentImage, title: title)
        recentCard.title = "Vistos recientemente"
        recentCard.padding = .small
        recentCard.bodyPadding = .none
        recentCard.setLinkAction("Ir al producto") { _ in
            let vc = GenericDetailViewController()
            let body = self.latest[indexPath.row].itemData
                vc.data = body
                vc.updateView(item: body)
            self.goToDetail()
        }
        return recentCard
    }
    
    private func cardView(image: UIImageView, title: String) -> UIView {
        let view = UIView()

        let imageView = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 90),
            imageView.widthAnchor.constraint(equalToConstant: 90)
        ])
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true

        let textLbl = UILabel()
        textLbl.text = title
        textLbl.numberOfLines = 3
        textLbl.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: 16), lineSpacing: 1))

        let stackView = UIStackView(arrangedSubviews: [imageView, textLbl])
        stackView.axis = .horizontal
        stackView.spacing = 7

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        return view
    }
}
