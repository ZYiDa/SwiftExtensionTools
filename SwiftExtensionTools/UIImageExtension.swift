//
//  UIImageExtension.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/26.
//

/**
 1 - UIColor转化为UIImage
 2 - 给UIImage设置tintColor
 */

import UIKit

public extension UIColor{
    
    func toImage(withSize size:CGSize)->UIImage?{
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        return image?.withRenderingMode(.alwaysOriginal)
    }
    
}

public extension UIImage{
    
    func tinted(withColor color:UIColor)->UIImage?{
        UIGraphicsBeginImageContext(self.size)
        color.setFill()
        let bounds = CGRect.init(x:0, y:0, width:self.size.width + 1, height:self.size.height + 1)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode:CGBlendMode.destinationIn, alpha:1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
    
}
