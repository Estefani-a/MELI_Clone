//
//  ButtonsContainer.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 30/09/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class ButtonsContainer: UIView {

    public lazy var contentStackView: UIStackView = .load() { element in
        element.axis = .horizontal
        element.distribution = .equalSpacing
    }
    
    public lazy var cartButton: SectionButton = .load() { element in
        element.setData(image: UIImage(named: "Car")!, text: "Automóviles")
    }
    
    public lazy var motoButton: SectionButton = .load() { element in
        element.setData(image: UIImage(named: "Moto")!, text: "Motos")
    }
    
    public lazy var truckButton: SectionButton = .load() { element in
        element.setData(image: UIImage(named: "FillTruck")!, text: "Camiones")
    }
    
    public lazy var houseButton: SectionButton = .load() { element in
        element.setData(image: UIImage(named: "House")!, text: "Inmuebles")
    }
    
    public lazy var moreButton: SectionButton = .load() { element in
        element.setData(image: UIImage(named: "Plus")!, text: "Ver más")
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
        self.addSubview(contentStackView)
        contentStackView.addArrangedSubview(cartButton)
        contentStackView.addArrangedSubview(motoButton)
        contentStackView.addArrangedSubview(truckButton)
        contentStackView.addArrangedSubview(houseButton)
        contentStackView.addArrangedSubview(moreButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}
