//
//  UILabel+Font.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 22/09/2022.
//

import Foundation
import UIKit

extension UILabel {
    func setTypography(typography: String) {
        if let font = UIFont(name: typography, size: UIFont.labelFontSize) {
            self.font = UIFontMetrics.default.scaledFont(for: font)
            self.adjustsFontForContentSizeCategory = true
        }
    }
}
