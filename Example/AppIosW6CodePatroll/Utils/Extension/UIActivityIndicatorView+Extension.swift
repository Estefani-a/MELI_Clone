//
//  UIActivityIndicatorView+Extension.swift
//  AppIosW6CodePatrollExample
//
//  Created by Estefania Sassone on 24/10/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func show() {
        self.startAnimating()
        self.isHidden = false
    }
    
    func dismiss() {
        self.stopAnimating()
        self.isHidden = true
    }
}
