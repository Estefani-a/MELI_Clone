//
//  BannerPromo.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 20/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class BannerPromo: UIView {

    private lazy var contentView: UIView = .load()
    
    private lazy var promoImage: UIImageView = .load() { element in
        element.image = UIImage(named: "bannerPromo")
        element.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        promoSetup()
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        promoSetup()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.addSubview(contentView)
        contentView.addSubview(promoImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            contentView.heightAnchor.constraint(equalToConstant: 96)
        ])
        
        NSLayoutConstraint.activate([
            promoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            promoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            promoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            promoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
//    func promoSetup() {
//        contentView.layer.cornerRadius = 5
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOpacity = 0.15
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        contentView.layer.shadowRadius = 10
//    }
}
