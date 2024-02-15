//
//  PriceLabel.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 20/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class PriceLabel: UIView {

    public lazy var priceLabel: AndesMoneyAmount = {
        let label = AndesMoneyAmount(type: .positive, size: .size36, currency: .ARS, decimalStyle: .normal, amount: nil)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        addSubview(priceLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
        ])
    }
}
