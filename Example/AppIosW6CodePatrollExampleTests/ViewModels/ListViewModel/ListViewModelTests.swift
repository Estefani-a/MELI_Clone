//
//  ListViewModelTests.swift
//  AppIosW6CodePatrollExampleTests
//
//  Created by Estefania Sassone on 25/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import XCTest
@testable import AppIosW6CodePatrollExample

class ListViewModelTests: XCTestCase {
    
    ///testGetDataList: verfica que se obtienen correctamente los datos de la lista de productos
    func testGetDataList() throws {
        let localStorage = MockDataStorage(ListModel.mock)
        let remoteStorage = MockDataStorage()
        let sut = ListViewModel(remoteService: remoteStorage, localService: localStorage)
        let expectation = XCTestExpectation(description: "ListViewModel test expectation")
        
        sut.getData(category: ListModel.mock.results.description)
        
        XCTAssertNotNil(sut)
    }
}
