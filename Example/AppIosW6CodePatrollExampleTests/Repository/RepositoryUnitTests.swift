//
//  RepositoryUnitTest.swift
//  AppIosW6CodePatroll
//
//  Created by Maria Estefania Sassone on 24/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import XCTest
@testable import AppIosW6CodePatrollExample

class RepositoryUnitTest: XCTestCase {
    
    let mockCategory = "category1"
    
    /// test_getItems_fromLocal(): Verifica si el producto existe en local, si no existe sale por un break
    func test_getItems_fromLocal() throws {
        
        let localStorage = MockDataStorage(ListModel.mock)
        let remoteStorage = MockDataStorage()
                
        let sut = MotorcycleRepository(remoteService: remoteStorage, localService: localStorage)
                
        let expectation = XCTestExpectation(description: "Al cargar la motocicleta se trae de local ya que existe")
        sut.getItems(categoryId: mockCategory){ result in
            switch result {
            case .success: expectation.fulfill()
            case .failure: break
            }
            
        }
        wait(for: [expectation], timeout: 3)
    }
    
    /// testSyncFromRemote(): verifica que el producto se recibe correctamente desde remoto, por este motivo no se recibe el mock para local
    func testSyncFromRemote() {
            let localStorage = MockDataStorage()
            let remoteStorage = MockDataStorage(ListModel.mock)
            
            let sut = MotorcycleRepository(remoteService: remoteStorage, localService: localStorage)
            
            let expectation = XCTestExpectation(description: "Al cargar la motocicleta se trae de remoto porque no existe en local")
            XCTAssertNil(localStorage.detailModel)
        
            sut.getItems(categoryId: mockCategory) { result in
                switch result {
                case .success:
                    expectation.fulfill()
                    XCTAssertNotNil(localStorage.detailModel)
                    XCTAssertNotNil(remoteStorage.detailModel)
                    XCTAssertEqual(localStorage.detailModel?.results[0].id, remoteStorage.detailModel!.results[0].id)
                case .failure: break
                }
            }
        wait(for: [expectation], timeout: 3)
    }
    
    /// testGetDescription: verifica que se obtiene  la descripcion del producto
    func testGetDescription(){
        let localStorage = MockDataStorage(ListModel.mock)
        let remoteStorage = MockDataStorage()
            
        let sut = MotorcycleRepository(remoteService: remoteStorage, localService: localStorage)
            
        let expectation = XCTestExpectation(description: "Se obtiene la descripción del producto")
        sut.getDescription(itemId: localStorage.detailModel?.results[0].id ?? "MLA1118711601") {
            localResult in
            switch localResult {
            case .success(let localDescription):
                XCTAssertNotNil(localDescription.description)
                expectation.fulfill()
            case .failure: break
                    
            }
        }
    }
    
    /// test_getPictures: Verifica que se obtienen correctamente las imagenes del producto
    func test_getPictures() {
        let localStorage = MockDataStorage(ListModel.mock)
        let remoteStorage = MockDataStorage()
        let sut = MotorcycleRepository(remoteService: remoteStorage, localService: localStorage)
        let expectation = XCTestExpectation(description: "Se obtiene la imagen del producto")
        
        sut.getPictures(itemId: "MLA1118711601"){ result in
            switch result {
            case .success: expectation.fulfill()
            case .failure: break
            }
        }
    }
}

class MockDataStorage: RepositoryProtocol {
    
    private (set) var detailModel: ListModel?
        
        init(_ detailModel: ListModel? = nil) {
            self.detailModel = detailModel
        }
        
        func getItems(categoryId: String, completion: @escaping (Result<ListModel, CustomError>) -> Void) {
            guard let detailModel = detailModel else {
                completion(.failure(CustomError.LocalDataNotFound))
                return
            }
            completion(.success(detailModel))
        }
        
        func store(_ model: ListModel, callback: @escaping () -> Void) {
            self.detailModel = model
            callback()
        }
        
        func getItemDescription(itemId: String, completion: @escaping (Result<String, CustomError>) -> Void) {
            
        }
        
        func getItemPictures(itemId: String, completion: @escaping (Result<ItemPicturesModel, CustomError>) -> Void) {
            
        }
}

extension ListModel {
    
    static var mock: ListModel {
        ListModel(results:  [Body(id: "MLA1118711601",
                                  title: "Cfmoto Rz 300  Mejor Contado!  Creditos Prendarios - Tarjeta",
                                  price: 1057000,
                                  currencyId: "ARS",
                                  acceptsMercadopago: true,
                                  thumbnail: "https://http2.mlstatic.com/D_969938-MCO51716464911_092022-O.jpg",
                                  permalink: "https://moto.mercadolibre.com.ar/MLA-1118711601-cfmoto-rz-300-mejor-contado-creditos-prendarios-tarjeta-_JM",
                                  location: LocationAddress(city: LocationData(name: "Capital Federal"),
                                                            country: LocationData(name: "Capital Federal"),
                                                            neighborhood: LocationData(name: "Villa Devoto")),
                                  attributes: [Attribute(name: "Condición del ítem",
                                                         valueName: "Nuevo")])]
        )
        
    }
}


