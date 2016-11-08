//
//  UIView+Effects.swift
//  StockCarBroadcastRemainder
//
//  Created by Alex Golub on 11/8/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
    }
}
