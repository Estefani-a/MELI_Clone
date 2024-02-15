//
//  ItemPictureModel.swift
//  AppIosW6CodePatrollExample
//
//  Created by Estefania Sassone on 23/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

struct ItemPicturesModel: Codable {
    let pictures: [ItemPicture]
    var dateData: Date?
    
    mutating func setDateData(date: Date) {
        dateData = date
    }
}

struct ItemPicture: Codable {
    let secureUrl: String
}
