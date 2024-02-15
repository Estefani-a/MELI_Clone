//
//  InternetStatus.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 13/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation
import Network

class InternetStatus {
    static let InternetChecker = InternetStatus()
    private static var monitor = NWPathMonitor()
    private static var status = true
    
    private init() {
        InternetStatus.monitor.pathUpdateHandler = { path in
           if path.status == .satisfied {
              print("Connected")
               InternetStatus.status = true
           } else {
              print("Disconnected")
               InternetStatus.status = false
           }
        }
    }
    
    static func isConnected() -> Bool {
        return status
    }
    
    static func start(queue: DispatchQueue) {
        monitor.start(queue: queue)
    }
    
    static func stop() {
        monitor.cancel()
    }
}
