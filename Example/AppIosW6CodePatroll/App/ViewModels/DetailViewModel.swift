//
//  DetailViewModel.swift
//  AppIosW6CodePatrollExample
//
//  Created by Estefania Sassone on 23/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation
import SwiftUI

class DetailViewModel {
    var pictures = Observable<ItemPicturesModel>()
    var description = Observable<String>()
    var error = Observable<CustomError>()
    var isSearching = Observable<Bool>()
    var repository: MotorcycleRepository
    
    init(remoteService: RepositoryProtocol, localService: RepositoryProtocol) {
        self.repository = MotorcycleRepository(remoteService: remoteService, localService: localService)
    }
    
    func getDescription(item: String) {
        isSearching.value = true
        repository.getDescription(itemId: item) { [weak self] result in
            switch result {
                case .success(let data):
                self?.description.value = data
                    self?.isSearching.value = false
                case .failure(let error):
                    self?.isSearching.value = false
                    self?.error.value = error
            }
        }
    }
    
    func getImages(item: String) {
        isSearching.value = true
        repository.getPictures(itemId: item) { [weak self] result in
            switch result {
                case .success(let data):
                    self?.pictures.value = data
                    self?.isSearching.value = false
                case .failure(let error):
                    self?.isSearching.value = false
                    self?.error.value = error
            }
        }
    }
    
    func addFavorite(item: Body) {
        repository.addItem(item: item)
    }
    
    func removeFavorite(id: String) {
        repository.removeItem(id: id)
    }
}
