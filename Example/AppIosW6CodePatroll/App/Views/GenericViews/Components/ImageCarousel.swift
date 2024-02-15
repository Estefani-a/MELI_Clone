//
//  ImageCarousel.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 20/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class ImageCarousel: UIView {

    var banerPictures: ItemPicturesModel = ItemPicturesModel(pictures: [ItemPicture]())
    
    private lazy var promoCaroussel: AndesCarousel = .load() { element in
        element.mode = .snapped
        element.margin = .compactMargin
        element.dataSource = self
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
        addSubview(promoCaroussel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            promoCaroussel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            promoCaroussel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -4),
            promoCaroussel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            promoCaroussel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            promoCaroussel.heightAnchor.constraint(equalToConstant: 295)
        ])
    }
    
    func updateCarousel(){
        promoCaroussel.dataSource = self
    }
}

extension ImageCarousel: AndesCarouselDataSource {
    
    func andesCarousel(_ carouselView: AndesCarousel, cellForRowAt indexPath: IndexPath) -> UIView {
        let productImage = UIImageView()
        print(banerPictures.pictures)
        productImage.pin_setImage(from: URL(string: banerPictures.pictures[indexPath.row].secureUrl))
//        productImage.image = banerPictures.pictures[indexPath.row]
        productImage.clipsToBounds = true
        productImage.contentMode = .scaleAspectFill

        let andesTag = AndesBadgePill()
        
        let total = banerPictures.pictures.count
        let actual = indexPath.row + 1

        andesTag.text = "\(actual) / \(total)"
        andesTag.hierarchy = .loud
        andesTag.type = .neutral
        andesTag.size = .large
        andesTag.border = .standard
        
        productImage.addSubview(andesTag)
        andesTag.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            andesTag.topAnchor.constraint(equalTo: productImage.topAnchor, constant: 10),
            andesTag.leadingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: 10)
        ])
        
        return productImage
    }
    
    func getDataSetSize(_ carouselView: AndesCarousel) -> Int {
        return banerPictures.pictures.count
    }
}
