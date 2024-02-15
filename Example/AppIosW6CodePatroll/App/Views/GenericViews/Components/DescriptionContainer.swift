//
//  DescriptionContainer.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 20/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class DescriptionContainer: UIView {
    
    private lazy var descriptionTitleLabel: UILabel = .load() { element in
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(16.00)
        element.textColor = UIColor.ml_meli_black()
        element.setLineHeight(17)
        element.text = "Descripción"
    }
    
    private lazy var fullDescriptionLabel: UILabel = .load() { element in
        element.numberOfLines = 0
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(12.00)
        element.textColor = UIColor.ml_meli_black()
        element.setLineHeight(16)
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
        addSubview(descriptionTitleLabel)
        addSubview(fullDescriptionLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            fullDescriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 24),
            fullDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fullDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fullDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setupText(text: String){
        fullDescriptionLabel.text = text
    }
}
