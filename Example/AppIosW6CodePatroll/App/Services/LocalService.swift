//
//  LocalService.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 13/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

class LocalService: RepositoryProtocol {

    func getItems(categoryId: String, completion: @escaping (Result<ListModel, CustomError>) -> Void) {
        guard
            let data = UserDefaults.standard.data(forKey: categoryId),
            let savedList = try? JSONDecoder().decode(ListModel.self, from: data)
        else {
            completion(.failure(CustomError.LocalDataNotFound))
            return
        }
        completion(.success(savedList))
    }
    
    func getItemDescription(itemId: String, completion: @escaping (Result<String, CustomError>) -> Void) {
        guard
            let data = UserDefaults.standard.data(forKey: "desc-\(itemId)"),
            let savedDescription = try? JSONDecoder().decode(String.self, from: data)
        else {
            completion(.failure(CustomError.LocalDataNotFound))
            return
        }
        completion(.success(savedDescription))
    }
    
    func getItemPictures(itemId: String, completion: @escaping (Result<ItemPicturesModel, CustomError>) -> Void) {
        guard
            let data = UserDefaults.standard.data(forKey: "imgs-\(itemId)"),
            let savedImages = try? JSONDecoder().decode(ItemPicturesModel.self, from: data)
        else {
            completion(.failure(CustomError.LocalDataNotFound))
            return
        }
        completion(.success(savedImages))
    }
    

    
    func store(_ model: ListModel, callback: @escaping () -> Void) {
        
    }
    
}
