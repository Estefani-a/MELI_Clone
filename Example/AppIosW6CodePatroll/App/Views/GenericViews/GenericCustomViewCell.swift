//
//  GenericCustomViewCell.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 19/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import PINRemoteImage
import AndesUI
import SwiftUI

class GenericCustomViewCell: UITableViewCell {

    var isFavorites: Bool? {
        didSet {
            if !(isFavorites ?? false) {
                enableFavs()
            }
        }
    }
    
    private lazy var contentStackView: UIStackView = .load() { element in
        element.axis = .horizontal
        element.spacing = 10
        element.layoutMargins = UIEdgeInsets(top: 14, left: 11, bottom: 13, right: 10)
        element.isLayoutMarginsRelativeArrangement = true
    }
    
    private lazy var imageContainer: UIView = .load() { element in
    }
    
    private lazy var itemImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        element.layer.cornerRadius = 4
        element.clipsToBounds = true
        element.layer.masksToBounds = true
        return element
    }()
    
    private lazy var favButton: UIButton = .load() { element in
        element.layer.cornerRadius = 14.5
        element.clipsToBounds = true
        element.setImage(UIImage(systemName: "heart"), for: .normal)
        element.backgroundColor = UIColor.white.withAlphaComponent(0.90)
    }
    
    var favButtonConstraints = [NSLayoutConstraint]()
    
    private lazy var dataContainer: UIView = .load()
    
    private lazy var dataStackView: UIStackView = .load() { element in
        element.axis = .vertical
        element.isLayoutMarginsRelativeArrangement = true
    }
    
    private lazy var titleContainer: UIView = .load()
    
    private lazy var titleText: UILabel = .load() { element in
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(13.00)
        element.numberOfLines = 2
        element.textColor = UIColor.ml_meli_black()
    }
    
    private lazy var priceText: AndesMoneyAmount = {
        let label = AndesMoneyAmount(type: .positive, size: .size20, currency: .ARS, decimalStyle: .normal, amount: nil)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionContainer: UIView = .load()
    
    private lazy var descriptionText: UILabel = .load() { element in
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(11.00)
        element.textColor = UIColor.ml_meli_grey()
    }
    
    private lazy var zoneText: UILabel = .load() { element in
        element.setTypography(typography: "proximanova-regular")
        element.font = element.font.withSize(11.00)
        element.textColor = UIColor.ml_meli_grey()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupView()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(imageContainer)
        contentStackView.addArrangedSubview(dataContainer)
        dataContainer.addSubview(dataStackView)
        imageContainer.addSubview(itemImage)
        
        dataStackView.addArrangedSubview(titleContainer)
        titleContainer.addSubview(titleText)
        dataStackView.addArrangedSubview(priceText)
        dataStackView.addArrangedSubview(descriptionContainer)
        descriptionContainer.addSubview(descriptionText)
        dataStackView.addArrangedSubview(zoneText)
    }
    
    func enableFavs() {
        if isFavorites == false {
            imageContainer.addSubview(favButton)
            NSLayoutConstraint.activate(favButtonConstraints)
        }
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageContainer.heightAnchor.constraint(equalToConstant: 131),
            imageContainer.widthAnchor.constraint(equalToConstant: 131),
        ])
            
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            itemImage.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            itemImage.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            itemImage.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
        ])
        
        favButtonConstraints = [
            favButton.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 6),
            favButton.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -6),
            favButton.heightAnchor.constraint(equalToConstant: 29),
            favButton.widthAnchor.constraint(equalToConstant: 29)
        ]
        
        NSLayoutConstraint.activate([
            dataStackView.leadingAnchor.constraint(equalTo: dataContainer.leadingAnchor, constant: 11),
            dataStackView.trailingAnchor.constraint(equalTo: dataContainer.trailingAnchor, constant: -11)
        ])
        
        NSLayoutConstraint.activate([
            titleText.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor),
            titleText.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor),
            titleText.topAnchor.constraint(equalTo: titleContainer.topAnchor),
            titleText.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -4)
        ])
        
        NSLayoutConstraint.activate([
            priceText.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            descriptionText.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor),
            descriptionText.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor),
            descriptionText.topAnchor.constraint(equalTo: descriptionContainer.topAnchor),
            descriptionText.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: -4)
        ])
    }
    
    public func updateCell(item: Body){
        titleText.text = item.title
        titleText.setLineHeight(17)
        itemImage.pin_setImage(from: URL(string: item.thumbnail))
        priceText.amount = item.price
        descriptionText.setLineHeight(17)
        descriptionText.text = "\(item.attributes?[0].name ?? ""): \(item.attributes?[0].valueName ?? "")"
        zoneText.text = item.location.country.name
        zoneText.setLineHeight(17)
    }
}
