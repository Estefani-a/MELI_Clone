//
//  UIImageView+Extension.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 28/09/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
    
    func load (url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
               if let image = UIImage (data: data) {
                   DispatchQueue.main.async {
                       self?.image = image
                   }
               }
            }
        }
    }
}
