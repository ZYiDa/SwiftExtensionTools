//
//  UIScreenExtension.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/28.
//

import UIKit

public extension UIScreen{
    
    //MARK: - Width
    static var Width:CGFloat{
        return self.main.bounds.size.width
    }
    
    //MARK: - Height
    static var Height:CGFloat{
        return self.main.bounds.size.height
    }
    
}
