//
//  CarouselBanner.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 30/09/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class CarouselBanner: UIView {

    let banerPictures = [UIImage(named: "banner1"),
                         UIImage(named: "banner2"),
                         UIImage(named: "banner3"),
                         UIImage(named: "banner4")]
    
    private lazy var promoCaroussel: AndesCarousel = .load() { element in
        element.mode = .snapped
        element.margin = .defaultMargin
        element.dataSource = self
    }
    
    private lazy var gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.addSubview(promoCaroussel)
        updateGradientBackground(with: UIColor.ml_meli_yellow(), and: UIColor.ml_meli_background())
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            promoCaroussel.topAnchor.constraint(equalTo: topAnchor),
            promoCaroussel.leadingAnchor.constraint(equalTo: leadingAnchor),
            promoCaroussel.trailingAnchor.constraint(equalTo: trailingAnchor),
            promoCaroussel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            promoCaroussel.heightAnchor.constraint(equalToConstant: 164)
        ])
    }
    
    private func updateGradientBackground(with startColor: UIColor, and endColor: UIColor) {
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.7, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.7, y: 1)
        if gradientLayer.superlayer == nil {
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = bounds
    }
}

extension CarouselBanner: AndesCarouselDataSource {
    func andesCarousel(_ carouselView: AndesCarousel, cellForRowAt indexPath: IndexPath) -> UIView {
        return setupBannerCarousell(indexPath: indexPath)
    }
    
    func getDataSetSize(_ carouselView: AndesCarousel) -> Int {
        return banerPictures.count
    }

    func setupBannerCarousell(indexPath: IndexPath) -> UIView {
        let productImage = UIImageView()
        productImage.image = banerPictures[indexPath.row]
        productImage.clipsToBounds = true
        productImage.contentMode = .scaleToFill
        productImage.layer.cornerRadius = 10
        return productImage
    }
}

