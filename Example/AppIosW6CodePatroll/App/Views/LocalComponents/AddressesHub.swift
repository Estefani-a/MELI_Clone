//
//  AddressesHub.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 03/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class AddressesHub: UIView {
    lazy var contentView: UIView = .load()
    
    private lazy var navigationStack: UIStackView = .load() { element in
        element.axis = .horizontal
        element.spacing = 7
    }
    
    private lazy var navigationLabel: AndesLabel = .load() { element in
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(14.00)
        element.textColor = UIColor.ml_meli_black()
        element.numberOfLines = 0
        element.text = "Enviar a Nombre de Usuario - Dirección"
    }

    private lazy var navigationIcon: UIImageView = .load() { element in
        element.image = UIImage(named: "location")
        element.tintColor = UIColor.ml_meli_black()
    }
    
    private lazy var chevronIcon: UIImageView = .load() { element in
        element.image = UIImage(named: "chevron-right")
        element.tintColor = UIColor.ml_meli_black()
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
        self.backgroundColor = UIColor.ml_meli_yellow()
        self.addSubview(contentView)
        contentView.addSubview(navigationStack)
        navigationStack.addArrangedSubview(navigationIcon)
        navigationStack.addArrangedSubview(navigationLabel)
        navigationStack.addArrangedSubview(chevronIcon)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            navigationStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            navigationStack.heightAnchor.constraint(equalToConstant: 16),
            navigationStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            navigationLabel.centerYAnchor.constraint(equalTo: navigationStack.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            navigationIcon.topAnchor.constraint(equalTo: navigationStack.topAnchor),
            navigationIcon.bottomAnchor.constraint(equalTo: navigationStack.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            chevronIcon.topAnchor.constraint(equalTo: navigationStack.topAnchor, constant: 4),
            chevronIcon.bottomAnchor.constraint(equalTo: navigationStack.bottomAnchor, constant: -4),
            chevronIcon.widthAnchor.constraint(equalToConstant: 5)
        ])
    }
}
