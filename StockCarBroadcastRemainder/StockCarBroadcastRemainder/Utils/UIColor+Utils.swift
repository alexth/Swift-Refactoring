//
//  UIColor+Utils.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

extension UIColor {
    static func color(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: redValue / 255.0, green: greenValue / 255.0, blue: blueValue / 255.0, alpha: alpha)
    }
}

extension UIColor {
    var components:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
}
