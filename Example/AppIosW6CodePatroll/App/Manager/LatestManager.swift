//
//  LatestManager.swift
//  AppIosW6CodePatrollExample
//
//  Created by Estefania Sassone on 24/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation

struct LatestManager {
    static func getLatest(completion: @escaping ([LatestData]) -> Void) {
        let forkey = "LastItems"
        var itemList: [LatestData] = []
        if let data = UserDefaults.standard.value(forKey: forkey) as? Data {
            guard let items = try? PropertyListDecoder().decode([LatestData].self, from: data) else {
                completion([])
                return
            }
            itemList = items
        }
        completion(itemList)
    }

    static func setLatestList(Latest: LatestData) {
        let forkey = "LastItems"
        var itemList: [LatestData?] = []
        if let data = UserDefaults.standard.value(forKey: forkey) as? Data {
            guard let items = try? PropertyListDecoder().decode([LatestData].self, from: data) else {
                return
            }
            UserDefaults.standard.removeObject(forKey: forkey)
            UserDefaults.standard.synchronize()
            itemList = items
        }

        if let _ = itemList.firstIndex(where: { $0?.itemData.id == Latest.itemData.id }) {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(itemList), forKey: forkey)
            return
        }

        itemList.append(Latest)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(itemList), forKey: forkey)
        UserDefaults.standard.synchronize()
    }

    static func removeAllLatest() {
        let forkey = "LastItems"
        UserDefaults.standard.removeObject(forKey: forkey)
        UserDefaults.standard.synchronize()
    }
}
