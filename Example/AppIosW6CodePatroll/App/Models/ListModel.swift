//
//  ListModel.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 05/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation
import SwiftUI

struct ListModel: Codable {
    var results: [Body]
    var dateData: Date?
    
    mutating func setData(item: Body) {
        results.append(item)
    }
    
    mutating func setDateData(date: Date) {
        dateData = date
    }
}

struct LatestData: Codable {
    var category: String?
    var itemData: Body
}

struct Body: Codable{
    let id: String
    let title: String
    let price: Double
    let currencyId: String
    let acceptsMercadopago: Bool
    let thumbnail: String
    let permalink: String
    let location: LocationAddress
    let attributes: [Attribute]?
}

struct Attribute: Codable {
    let name: String?
    let valueName: String?
}

struct LocationAddress: Codable {
    let city: LocationData
    let country: LocationData
    let neighborhood: LocationData
}

struct LocationData: Codable {
    let name: String
}

struct APIDescriptionResponse: Codable {
    let plainText : String
}

//let body1: Body = Body(id: "MLA1118711601",
//                       title: "Cfmoto Rz 300  Mejor Contado!  Creditos Prendarios - Tarjeta",
//                       price: 1057000,
//                       currencyId: "ARS",
//                       acceptsMercadopago: true,
//                       thumbnail: "https://http2.mlstatic.com/D_969938-MCO51716464911_092022-O.jpg",
//                       permalink: "https://moto.mercadolibre.com.ar/MLA-1118711601-cfmoto-rz-300-mejor-contado-creditos-prendarios-tarjeta-_JM",
//                       location: LocationAddress(city: LocationData(name: "Capital Federal"),
//                                               country: LocationData(name: "Capital Federal"),
//                                                 neighborhood: LocationData(name: "Villa Devoto")),
//                       attributes: [Attribute(name: "Condición del ítem",
//                                              valueName: "Nuevo")])
//
//let body2: Body = Body(id: "MLA1118711458",
//                       title: "Cfmoto Rz 300  Mejor Contado!  Creditos Prendarios - Tarjeta",
//                       price: 1057000,
//                       currencyId: "ARS",
//                       acceptsMercadopago: true,
//                       thumbnail: "https://http2.mlstatic.com/D_969938-MCO51716464911_092022-O.jpg",
//                       permalink: "https://moto.mercadolibre.com.ar/MLA-1118711601-cfmoto-rz-300-mejor-contado-creditos-prendarios-tarjeta-_JM",
//                       location: LocationAddress(city: LocationData(name: "Capital Federal"),
//                                               country: LocationData(name: "Capital Federal"),
//                                                 neighborhood: LocationData(name: "Villa Devoto")),
//                       attributes: [Attribute(name: "Condición del ítem",
//                                              valueName: "Nuevo")])
//
//let body3: Body = Body(id: "MLA1118713695",
//                       title: "Cfmoto Rz 300  Mejor Contado!  Creditos Prendarios - Tarjeta",
//                       price: 1057000,
//                       currencyId: "ARS",
//                       acceptsMercadopago: true,
//                       thumbnail: "https://http2.mlstatic.com/D_969938-MCO51716464911_092022-O.jpg",
//                       permalink: "https://moto.mercadolibre.com.ar/MLA-1118711601-cfmoto-rz-300-mejor-contado-creditos-prendarios-tarjeta-_JM",
//                       location: LocationAddress(city: LocationData(name: "Capital Federal"),
//                                               country: LocationData(name: "Capital Federal"),
//                                                 neighborhood: LocationData(name: "Villa Devoto")),
//                       attributes: [Attribute(name: "Condición del ítem",
//                                              valueName: "Nuevo")])
//
//var mockData: ListModel = ListModel.init(results: [body1, body2, body3])
