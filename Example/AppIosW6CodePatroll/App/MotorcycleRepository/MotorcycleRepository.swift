//
//  MotorcycleRepository.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 13/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

class MotorcycleRepository {
    
    let remoteData: RepositoryProtocol
    let localData: RepositoryProtocol
    let favoriteData: FavoriteService
    
    init(remoteService: RepositoryProtocol, localService: RepositoryProtocol) {
        self.remoteData = remoteService
        self.localData = localService
        self.favoriteData = FavoriteService()
    }


    func getItems(categoryId: String, completion: @escaping (Result<ListModel, CustomError>) -> Void) {
        localData.getItems(categoryId: categoryId) { [weak self] localResult in
            switch localResult {
            case .success(let localList):
                if localList.results.count > 0 && Calendar.current.dateComponents([.second], from: localList.dateData ?? Date(), to: Date()).second! < 15 {
                    print("local data")
                    completion(.success(localList))
                    return
                }
                self?.remoteData.getItems(categoryId: categoryId, completion: { remoteResult in
                    switch remoteResult {
                    case .success(let remoteList):
                        if let encodedData = try? JSONEncoder().encode(remoteList) {
                            UserDefaults.standard.set(encodedData, forKey: categoryId)
                        }
                        print("remote data")
                        completion(.success(remoteList))
                        return
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            case .failure(_):
                self?.remoteData.getItems(categoryId: categoryId, completion: { remoteResult in
                    switch remoteResult {
                    case .success(let remoteList):
                        if let encodedData = try? JSONEncoder().encode(remoteList) {
                            UserDefaults.standard.set(encodedData, forKey: categoryId)
                        }
                        print("remote data")
                        print(remoteList)
                        completion(.success(remoteList))
                        return
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            }
        }
    }
    
    func getDescription(itemId: String, completion: @escaping (Result<String, CustomError>) -> Void) {
        localData.getItemDescription(itemId: itemId) { [weak self] localResult in
            switch localResult {
            case .success(let localDescription):
                if localDescription != "" {
                    print("local data")
                    completion(.success(localDescription))
                    return
                }
                self?.remoteData.getItemDescription(itemId: itemId, completion: { remoteResult in
                    switch remoteResult {
                    case .success(let remoteDescription):
                        if let encodedData = try? JSONEncoder().encode(remoteDescription) {
                            UserDefaults.standard.set(encodedData, forKey: "desc-\(itemId)")
                        }
                        print("remote data")
                        completion(.success(remoteDescription))
                        return
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            case .failure(_):
                self?.remoteData.getItemDescription(itemId: itemId, completion: { remoteResult in
                    switch remoteResult {
                    case .success(let remoteDescription):
                        if let encodedData = try? JSONEncoder().encode(remoteDescription) {
                            UserDefaults.standard.set(encodedData, forKey: "desc-\(itemId)")
                        }
                        print("remote data")
                        completion(.success(remoteDescription))
                        return
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            }
        }
    }
    
    func getPictures(itemId: String, completion: @escaping (Result<ItemPicturesModel, CustomError>) -> Void) {
        localData.getItemPictures(itemId: itemId) { [weak self] localResult in
            switch localResult {
            case .success(let localImages):
                if localImages.pictures.count > 0 && Calendar.current.dateComponents([.second], from: localImages.dateData ?? Date(), to: Date()).second! < 15 {
                    print("local data")
                    completion(.success(localImages))
                    return
                }
                self?.remoteData.getItemPictures(itemId: itemId, completion: { remoteResult in
                    switch remoteResult {
                    case .success(let remoteImages):
                        if let encodedData = try? JSONEncoder().encode(remoteImages) {
                            UserDefaults.standard.set(encodedData, forKey: "imgs-\(itemId)")
                        }
                        print("remote data")
                        completion(.success(remoteImages))
                        return
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            case .failure(_):
                self?.remoteData.getItemPictures(itemId: itemId, completion: { remoteResult in
                    switch remoteResult {
                    case .success(let remoteImages):
                        if let encodedData = try? JSONEncoder().encode(remoteImages) {
                            UserDefaults.standard.set(encodedData, forKey: "imgs-\(itemId)")
                        }
                        print("remote data")
                        completion(.success(remoteImages))
                        return
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            }
        }
    }
    
    // Sync: Busca en remoto y almacena en local si consigue resultado.
    func sync(categoryId: String, callback: @escaping (Result<ListModel,Error>) -> Void) {
        remoteData.getItems(categoryId: categoryId) { result in
            switch result {
            case .success(let listModel):
                self.localData.store(listModel) {
                    callback(.success(listModel))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    // Load: Busco en local. Si obtengo un error, llamo a función sync nuevamente, que buscara en remoto y guarda en local.
    //Retornamos ese valor.

    func load(categoryId: String, callback: @escaping (Result<ListModel,Error>) -> Void) {
        localData.getItems(categoryId: categoryId) { result in
            switch result {
            case .success(let listModel): callback(.success(listModel))
            case .failure: self.sync(categoryId: categoryId, callback: callback)
        
            }
        }
    }
    
    func getfavoritesItems(completion: @escaping (Result<ListModel, CustomError>) -> Void) {
        self.favoriteData.getItems { result in
            switch result {
            case .success(let list):
                completion(.success(list))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func removeItem(id: String) {
        self.favoriteData.deleteItem(id: id)
    }
    
    func addItem(item: Body) {
        self.favoriteData.addItem(item: item)
    }
}
