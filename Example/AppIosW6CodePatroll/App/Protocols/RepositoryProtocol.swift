//
//  RepositoryProtocol.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 13/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {


    func getItems(categoryId : String, completion: @escaping (Result<ListModel, CustomError>) -> Void)
    func getItemDescription(itemId : String, completion: @escaping (Result<String, CustomError>) -> Void)
    func getItemPictures(itemId : String, completion: @escaping (Result<ItemPicturesModel, CustomError>) -> Void)
    func store(_ model: ListModel, callback: @escaping () -> Void)
}
