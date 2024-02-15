//
//  DetailModel.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 29/09/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

struct DetailModel {
    let id: String
    let title: String
    let price: Double
    let currency: String
    let acceptsMP: Bool
    let secureThumbnail: String
    let description: String
    let location: LocationAddress
    let link: String
}
