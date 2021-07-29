//
//  UIFontExtension.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/26.
//

import UIKit

public extension UIFont{
    
    static func regular(fontize size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func ultralight(fontSize size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Ultralight", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func thin(fontSize size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Thin", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    static func light(fontSize size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func medium(fontSize size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func bold(fontSize size:CGFloat)->UIFont{
        return UIFont(name: "PingFang-SC-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
