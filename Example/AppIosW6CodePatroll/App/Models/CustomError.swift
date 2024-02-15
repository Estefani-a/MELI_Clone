//
//  CustomError.swift
//  AppIosW6CodePatrollExample
//
//  Created by Estefania Sassone on 23/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

enum CustomError: String, Error, Equatable {
    case NoItemInCategory = "No hay elementos en la categoria buscada"
    case CategoryNotFound = "No se encontró la categoria deseada"
    case ItemNotFound = "El item solicitado no se pudo encontrar"
    case APIError = "Ocurrio un error en la peticion"
    case DescriptionNotFound = "No se encontró descripcion para el producto"
    case LocalDataNotFound = "no se pudo traer la información del cache"
}
