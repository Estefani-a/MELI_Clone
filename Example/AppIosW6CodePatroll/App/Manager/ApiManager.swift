//
//  ApiManager.swift
//  AppIosW6CodePatrollExample
//
//  Created by Estefania Sassone on 23/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation
import MLNetworking

class ApiCaller {
    static let shared = ApiCaller()
    private let config = MLNetworkingConfiguration()
    
    private init() {}
    
    private func setupconfiguration(url: String, method: MLNetworkingHTTPMethod, timeout: Double) {
        config.baseURLString = url
        config.httpMethod = method
        config.timeoutInterval = timeout
    }
    
    func fetch<T: Codable>(url: String, param: String, model: T.Type, completion: @escaping (Result<T, CustomError>) -> Void) {
        guard
            let meliURL = ProcessInfo.processInfo.environment["MELI_URL"]
        else {
            completion(.failure(CustomError.APIError))
            return
        }
        let url = "\(meliURL)\(generateUrl(url: url, param: param))"
        setupconfiguration(url: url, method: .GET, timeout: 10)
        let operation = MLNetworkingOperation(networkingConfig: config)
        operation.successBlock = { _, response in
            if let data = response.responseData {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(CustomError.APIError))
                }
            }
        }
        operation.failureBlock = { _, error in
            completion(.failure(CustomError.APIError))
        }
        MLNetworkingOperationManager.sharedInstance().add(operation)
    }
    
    private func generateUrl(url: String, param: String) -> String {
        return url.replacingOccurrences(of: "PARAM", with: param)
    }
}
