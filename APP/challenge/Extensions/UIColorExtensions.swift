//
//  UIColorExtensions.swift
//  challenge
//
//  Created by Wagner Sales
//

import UIKit

extension UIColor {
    // swiftlint:disable:next identifier_name
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
