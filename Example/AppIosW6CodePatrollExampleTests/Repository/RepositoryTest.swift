//
//  RepositoryTest.swift
//  AppIosW6CodePatrollExample
//
//  Created by Iara Denise Orosco on 20/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import XCTest
@testable import AppIosW6CodePatrollExample

class RepositoryTest: XCTestCase {
    
    /// RepositoryTest:  Buscamos testear la funcionalidad de el repositorio: Que muestre el producto si lo tiene en local, en primera instancia y, de lo contrario, lo busca en remoto y lo guarda en local. Se crea un mock que es con una clase MockMotorcycleStorage (la cual, sólo pertenece a los test) y se guarda localmente. Con la función GetItems, si está guardado, lo devuelve, de lo contrario muestra error.
    
    let mockCategory = "category1"
    
    
    /// func testFetchLocalifExist() : Busca el producto, el cual se lo estoy pasando desde un inicio como mock. Si es success, la expectation se cumple.
    /// Si falla, salimos por el break.
    
    func testFetchLocalifExist() throws {
        let localStorage = MockMotorcycleStorage(ListModel.mock)
        let remoteStorage = MockMotorcycleStorage()
        
        let sut = MotorcycleRepository(remoteService: remoteStorage, localService: localStorage)
        
        let expectation = XCTestExpectation(description: "Al cargar el auto se trae de local ya que existe")
        sut.load(categoryId: mockCategory) { result in
            switch result {
            case .success: expectation.fulfill()
            case .failure: break
            }
        }
        wait(for: [expectation], timeout: 3)
    }
    
    /// func testSyncFromRemote() : En local, no le pasa un producto para que lo busque en remoto. Con la función load, indicamos que busque el producto, lo que me lleva a realizar el fulfill de la expectatios. Luego, pedimos que tanto local como remotamente, nos quede el producto y que tengan el mismo ID (con los asserts).
    
    func testSyncFromRemote() {
        let localStorage = MockMotorcycleStorage()
        let remoteStorage = MockMotorcycleStorage(ListModel.mock)
        
        let sut = MotorcycleRepository(remoteService: remoteStorage, localService: localStorage)
        
        let expectation = XCTestExpectation(description: "Al cargar el auto se trae de remoto porque no existe en local")
        XCTAssertNil(localStorage.detailModel)
        sut.load(categoryId: mockCategory) { result in
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
    
    func testFetchLocalWithNonExistenceCategory() throws {
        let localStorage = MockMotorcycleStorage(ListModel.mock)
        let remoteStorage = MockMotorcycleStorage()
        
        let sut = MotorcycleRepository(remoteService: remoteStorage, localService: localStorage)
        
        let expectation = XCTestExpectation(description: "Al cargar el auto se trae de local ya que existe")
        sut.load(categoryId: "0") { result in
            switch result {
            case .success: expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error as! CustomError, CustomError.CategoryNotFound)
            }
        }
        wait(for: [expectation], timeout: 3)
    }
    
    /// func testGetDescription: Se testea la recepción correcta de la descripción guardada localmente.
    func testGetDescriptionFromLocal(){
        let localStorage = MockMotorcycleStorage(ListModel.mock)
        let remoteStorage = MockMotorcycleStorage()
        
        let sut = MotorcycleRepository(remoteService: remoteStorage, localService: localStorage)
        
        let expectation = XCTestExpectation(description: "Se obtiene la descripción del producto")
        sut.getDescription(itemId: localStorage.detailModel?.results[0].id ?? "MLA1118711601") {
            localResult in
            switch localResult {
            case .success(_):
                XCTAssertNotNil(localStorage.detailModel?.results.description)
                expectation.fulfill()
            case .failure: break
                
            }
        }
        
    }
    
    
    
    func testDoNotGetDescription(){
        let localStorage = MockMotorcycleStorage(ListModel.mock)
        let remoteStorage = MockMotorcycleStorage()
        
        let sut = MotorcycleRepository(remoteService: remoteStorage, localService: localStorage)
        let expectation = XCTestExpectation(description: "Se obtiene error al no recibir la descripción del producto")
        sut.getDescription(itemId: "MLA1118711601abc") {
            localResult in
            expectation.fulfill()
            switch localResult {
            case .success(_):
                print("")
            case .failure(let error):
                XCTAssertEqual(error, CustomError.DescriptionNotFound)
                
            }
        }
    }
    
    func test_getPictures() {
        let localStorage = MockMotorcycleStorage(ListModel.mock)
        let remoteStorage = MockMotorcycleStorage()
        // var result: [ItemPicture]?
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




class MockMotorcycleStorage: RepositoryProtocol {
    
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



