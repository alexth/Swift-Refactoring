//
//  UIImage+Coloring.swift
//  Stock Car Broadcast Remainder
//
//  Created by Alex Golub on 3/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

import UIKit

extension UIImage {
    class func convertToGrayScale(_ image: UIImage) -> UIImage {
        let imageRect:CGRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context?.draw(image.cgImage!, in: imageRect)
        let imageRef = context?.makeImage()
        let newImage = UIImage(cgImage: imageRef!)
        
        return newImage
    }
}
