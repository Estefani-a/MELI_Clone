//
//  ShippingPromo.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 30/09/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class ShippingPromo: UIView {

    private lazy var contentView: UIView = .load() { element in
        element.backgroundColor = .white
    }
    
    private lazy var contentStackView: UIStackView = .load() { element in
        element.axis = .horizontal
        element.distribution = .equalSpacing
        element.layoutMargins = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        element.isLayoutMarginsRelativeArrangement = true
    }
    
    private lazy var truckImage: UIImageView = .load() { element in
        element.image = UIImage(named: "Truck")
        element.contentMode = .scaleAspectFill
    }
    
    private lazy var shippingLabel: AndesLabel = .load() { element in
        element.setTypography(typography: "proximanova-semibold")
        element.font = element.font.withSize(12.00)
        element.textColor = UIColor.ml_meli_green()
        element.text = "   Envío Gratis"
    }
    
    private lazy var productsLabel: AndesLabel = .load() { element in
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(12.00)
        element.textColor = UIColor.ml_meli_black()
        element.text = " en millones de productos desde $3.500"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        promoSetup()
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        promoSetup()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(truckImage)
        contentStackView.addArrangedSubview(shippingLabel)
        contentStackView.addArrangedSubview(productsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            contentView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            contentStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentStackView.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            truckImage.heightAnchor.constraint(equalToConstant: 12),
            truckImage.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func promoSetup() {
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.15
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius = 10
    }
}
