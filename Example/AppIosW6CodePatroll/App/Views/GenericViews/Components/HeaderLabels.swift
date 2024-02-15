//
//  HeaderLabels.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 19/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class HeaderLabels: UIView {
    
    private lazy var headerLabelsStack: UIStackView = .load() { element in
        element.axis = .vertical
        element.spacing = 4
    }
    
    private lazy var descriptionContainer: UIView = .load()
    
    public lazy var descriptionLabel: UILabel = .load() { element in
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(12.00)
        element.textColor = UIColor.ml_meli_grey()
        element.numberOfLines = 2
    }
    
    public lazy var titleLabel: UILabel = .load() { element in
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(16.00)
        element.textColor = UIColor.ml_meli_black()
        element.numberOfLines = 2
    }
    
    private lazy var sellerContainer: UIView = .load()
    
    private lazy var sellerStack: UIStackView = .load() { element in
        element.axis = .horizontal
    }
    
    private lazy var sellerLabel: UILabel = .load() { element in
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(11.00)
        element.textColor = UIColor.ml_meli_grey()
        element.text = "Vendedor con "
    }
    
    private lazy var sellerIdentityLabel: UILabel = .load() { element in
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(11.00)
        element.textColor = UIColor.ml_meli_blue()
        element.text = "identidad verificada"
    }
    
    private lazy var iconContainer: UIView = .load()
    
    private lazy var verifyIcon: UIImageView = .load() { element in
        element.image = UIImage(systemName: "checkmark.seal.fill")
        element.tintColor = UIColor.ml_meli_blue()
    }

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
        addSubview(headerLabelsStack)
        headerLabelsStack.addArrangedSubview(descriptionContainer)
        descriptionContainer.addSubview(descriptionLabel)
        headerLabelsStack.addArrangedSubview(titleLabel)
        headerLabelsStack.addArrangedSubview(sellerContainer)
        sellerContainer.addSubview(sellerStack)
        sellerStack.addArrangedSubview(sellerLabel)
        sellerStack.addArrangedSubview(sellerIdentityLabel)
        sellerStack.addArrangedSubview(iconContainer)
        iconContainer.addSubview(verifyIcon)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabelsStack.topAnchor.constraint(equalTo: topAnchor),
            headerLabelsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerLabelsStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContainer.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: -2),
        ])
        
        NSLayoutConstraint.activate([
            sellerStack.heightAnchor.constraint(equalToConstant: 17),
            sellerStack.leadingAnchor.constraint(equalTo: sellerContainer.leadingAnchor),
            sellerStack.topAnchor.constraint(equalTo: sellerContainer.topAnchor),
            sellerStack.bottomAnchor.constraint(equalTo: sellerContainer.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iconContainer.widthAnchor.constraint(equalToConstant: 23)
        ])
        
        NSLayoutConstraint.activate([
            verifyIcon.leadingAnchor.constraint(equalTo: iconContainer.leadingAnchor, constant: 6),
            verifyIcon.trailingAnchor.constraint(equalTo: iconContainer.trailingAnchor),
            verifyIcon.topAnchor.constraint(equalTo: iconContainer.topAnchor, constant: 1),
            verifyIcon.bottomAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: -1)
        ])
    }
}
