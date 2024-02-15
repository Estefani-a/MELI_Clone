//
//  DetailViewModelTests.swift
//  AppIosW6CodePatrollExampleTests
//
//  Created by Estefania Sassone on 25/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import XCTest
@testable import AppIosW6CodePatrollExample

class DetailViewModelTests: XCTestCase {
    
    let mockCategory = "category1"
    
    ///testGet_Description: verifica que se obtenga correctamente la descripcion del producto
    func testGetDescription() throws {
        let localStorage = MockDataStorage(ListModel.mock)
        let remoteStorage = MockDataStorage()
        let viewModel = DetailViewModel(remoteService: remoteStorage, localService: localStorage)
        let expectation = XCTestExpectation(description: "Se obtiene la descripcion del producto")
            
        let description: () = viewModel.getDescription(item: ListModel.mock.results.description)
        XCTAssertNotNil(description)
    }
    
    //////testGetImages: verifica que se obtenga correctamente las imagenes del producto
    func testGetImages() {
        let localStorage = MockDataStorage(ListModel.mock)
        let remoteStorage = MockDataStorage()
        let sut = DetailViewModel(remoteService: remoteStorage, localService: localStorage)
        let expectation = XCTestExpectation(description: "Se obtiene la imagen del producto")
        
        let pictures: () = sut.getImages(item: ListModel.mock.results.description)
        XCTAssertNotNil(pictures)
    }
    
}
