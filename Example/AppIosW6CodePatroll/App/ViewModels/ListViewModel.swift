//
//  ListViewModel.swift
//  AppIosW6CodePatrollExample
//
//  Created by Estefania Sassone on 23/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

class ListViewModel {
    var items = Observable<ListModel>()
    var error = Observable<CustomError>()
    var isSearching = Observable<Bool>()
    var repository: MotorcycleRepository
    
    init(remoteService: RepositoryProtocol, localService: RepositoryProtocol) {
        self.repository = MotorcycleRepository(remoteService: remoteService, localService: localService)
    }
    
    func getData(category: String) {
        isSearching.value = true
        repository.getItems(categoryId: category) { [weak self] result in
            switch result {
                case .success(let data):
                    self?.items.value = data
                    self?.isSearching.value = false
                case .failure(let error):
                    self?.isSearching.value = false
                    self?.error.value = error
            }
        }
    }
    
    func getFavorites() {
        isSearching.value = true
        repository.getfavoritesItems(completion: { [weak self] result in
            switch result {
                case .success(let data):
                    self?.items.value = data
                    self?.isSearching.value = false
                case .failure(let error):
                    self?.isSearching.value = false
                    self?.error.value = error
            }
        })
    }
    
    func addFavorite(item: Body) {
        repository.addItem(item: item)
    }
    
    func removeFavorite(id: String) {
        repository.removeItem(id: id)
    }
}
