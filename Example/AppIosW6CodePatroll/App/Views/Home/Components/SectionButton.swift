//
//  SectionButton.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 30/09/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class SectionButton: UIView {

    private lazy var contentStackView: UIStackView = .load() { element in
        element.axis = .vertical
        element.spacing = 6
        element.distribution = .fill
    }
    
    public lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = UIColor.ml_meli_grey()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var sectionLabel: AndesLabel = .load() { element in
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(10.00)
        element.textColor = UIColor.ml_meli_grey()
        element.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        buttonsSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
        buttonsSetup()
    }
    
    private func setupView() {
        self.addSubview(contentStackView)
        contentStackView.addArrangedSubview(button)
        contentStackView.addArrangedSubview(sectionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 55),
            button.widthAnchor.constraint(equalToConstant: 55)
        ])

        NSLayoutConstraint.activate([
            sectionLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func buttonsSetup() {
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 10
    }
    
    public func setData(image: UIImage,text: String) {
        self.button.setImage(image, for: .normal)
        self.sectionLabel.text = text
    }

}
