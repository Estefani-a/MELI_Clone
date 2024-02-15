//
//  Observable.swift
//  AppIosW6CodePatrollExample
//
//  Created by Estefania Sassone on 23/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation
class Observable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
