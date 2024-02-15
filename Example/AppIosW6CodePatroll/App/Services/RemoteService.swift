//
//  RemoteService.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 13/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

import Foundation

class RemoteService: RepositoryProtocol {

    func getItems(categoryId: String, completion: @escaping (Result<ListModel, CustomError>) -> Void) {
        ApiCaller.shared.fetch(url: "sites/MLA/search?category=PARAM", param: categoryId, model: ListModel.self) { result in
            switch result {
                case .success(var list):
                    list.setDateData(date: Date())
                    completion(.success(list))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getItemDescription(itemId: String, completion: @escaping (Result<String, CustomError>) -> Void) {
        ApiCaller.shared.fetch(url: "items/PARAM/description", param: itemId, model: APIDescriptionResponse.self) { result in
            switch result {
                case .success(let description):
                    completion(.success(description.plainText))
                case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getItemPictures(itemId: String, completion: @escaping (Result<ItemPicturesModel, CustomError>) -> Void) {
        ApiCaller.shared.fetch(url: "items/PARAM", param: itemId, model: ItemPicturesModel.self) { result in
            switch result {
                case .success(var pictures):
                    pictures.setDateData(date: Date())
                    completion(.success(pictures))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func store(_ model: ListModel, callback: @escaping () -> Void) {
    }
    
}
