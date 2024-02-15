//
//  FavoritesRepositoryTest.swift
//  AppIosW6CodePatrollExampleTests
//
//  Created by Estefania Sassone on 25/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import XCTest
@testable import AppIosW6CodePatrollExample

/// Verifica la correcta implementacion del repositorio agregar favoritos para agregar los productos solicitados por el usuario
class FavoritesRepositoryTest: XCTestCase {
    
    var sut: FavoritesRepository! //Agregar repo a app
    var key: String!

    override func setUpWithError() throws {
        key = "favorites"
        sut = FavoritesRepository(dataSourceType: .local)
        UserDefaults.standard.set(["Testing 1,2,3"], forKey: key)
    }

    override func tearDownWithError() throws {
        UserDefaults.standard.removeObject(forKey: key)
    }

    func testUDgetResponse() throws {
        var result: String?
        result = sut.getFavorites().first
        XCTAssertNotNil(result)
    }

    func testUDgetUpdateFavorites() {
        sut.updateFavorites(favorites: ["New List"])

        let list = UserDefaults.standard.object(forKey: key) as! [String]

        XCTAssertEqual(["New List"], list)
    }
    
    
}
