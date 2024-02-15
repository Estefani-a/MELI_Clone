//
//  HomeViewModel.swift
//  AppIosW6CodePatrollExample
//
//  Created by Estefania Sassone on 24/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

class HomeViewModel {
    func getHistory() -> [LatestData] {
        var dataRecents: [LatestData] = []
        LatestManager.getLatest { dataResponse in
            dataRecents = dataResponse
        }
        return dataRecents
    }

    func getSecureThumbnail(thumbnail: String) -> String {
            let index = thumbnail.index(thumbnail.startIndex, offsetBy: 4)
            let substring = thumbnail.suffix(from: index)
            return "https\(substring)"
        }
}
