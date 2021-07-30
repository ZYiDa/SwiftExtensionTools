//
//  StringExtension.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/26.
//

import UIKit
import CommonCrypto

public extension String{
    //MARK: - 简化使用的正则表达式
    static func ~=(lhs:String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
    //MARK: - 生成attributeString
    func attribute(start:Int,
                   length:Int,
                   textColor:UIColor) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        let range = NSRange(location: start, length: length)
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor : textColor], range: range)
        return attributeString
    }
}

public extension String{
    //MARK: - 是否为邮箱
    var isEmail:Bool{
        let parrern = "\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}"
        return self ~= parrern
    }
    //MARK: - 是否为手机号
    var isMobile:Bool{
        return self ~= "0?(13|14|15|16|17|18|19)[0-9]{9}"
    }
    //MARK: - 是否为8位数字的密码
    var is8Digits:Bool{
        return self ~= "^\\d{8}$"
    }
    //MARK : - 是否为用户名 只允许输入英文 汉字 数字
    var isUserName:Bool{
        return self ~= "[A-Za-z0-9_\\-\\u4e00-\\u9fa5]+"
    }
    //MARK: - 生成MD5字符串
    var to32MD5:String {
        let utf8 = self.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02x", $1) }
    }
    //MARK: - 字符串数字转Float
    var floatValue:Float{
        return (self as NSString).floatValue
    }
    //MARK: - IDFV
    static var IDFV:String?{
        guard let idfv = UIDevice.current.identifierForVendor?.uuidString.uppercased() else {
            return nil
        }
        return idfv
    }
    //MARK: - Identifier
    static var BundleIdentifier:String?{
        guard let identifier = Bundle.main.bundleIdentifier else {
            return nil
        }
        return identifier
    }
}
