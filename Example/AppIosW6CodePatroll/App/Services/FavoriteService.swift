//
//  FavoriteService.swift
//  AppIosW6CodePatrollExample
//
//  Created by Estefania Sassone on 24/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

class FavoriteService {
    func getItems(completion: @escaping (Result<ListModel, CustomError>) -> Void) {
        guard
            let data = UserDefaults.standard.data(forKey: "favList"),
            let savedList = try? JSONDecoder().decode(ListModel.self, from: data)
        else {
            completion(.failure(CustomError.LocalDataNotFound))
            return
        }
        completion(.success(savedList))
    }
    
    func addItem(item: Body) {
        guard
            let data = UserDefaults.standard.data(forKey: "favList"),
            var savedList = try? JSONDecoder().decode(ListModel.self, from: data)
        else {
            let encodedData = try? JSONEncoder().encode(ListModel(results: [item], dateData: nil))
            UserDefaults.standard.set(encodedData, forKey: "favList")
            return
        }
        savedList.setData(item: item)
        if let encodedData = try? JSONEncoder().encode(savedList) {
            UserDefaults.standard.set(encodedData, forKey: "favList")
        }
    }
    
    func deleteItem(id: String) {
        guard
            let data = UserDefaults.standard.data(forKey: "favList"),
            var savedList = try? JSONDecoder().decode(ListModel.self, from: data)
        else { return }
        savedList.results = savedList.results.filter ({ $0.id != id })
        if let encodedData = try? JSONEncoder().encode(savedList) {
            UserDefaults.standard.set(encodedData, forKey: "favList")
        }
    }
}
