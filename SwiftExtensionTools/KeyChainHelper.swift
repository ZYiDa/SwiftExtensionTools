//
//  KeyChainHelper.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/26.
//

import Foundation
import UIKit
import Security

fileprivate let publicKeychainIdentifier = "\(String.BundleIdentifier ?? "").publicKey"
fileprivate let privateKeychainIdentifier = "\(String.BundleIdentifier ?? "").privateKey"
fileprivate let publicKeychainTag = publicKeychainIdentifier.data(using: .utf8)
fileprivate let privateKeychainTag = privateKeychainIdentifier.data(using: .utf8)

public class KeyChainHelper: NSObject {
    
    ///查询
    private static func getKeyChainQuery(service serviceString:String!) -> [String:Any]{
        
        var query = [String:Any]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = serviceString
        query[kSecAttrAccount as String] = serviceString
        query[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
        
        return query
    }
    
    ///存储
    public static func saveKeyChainData<T>(service serviceString:String!,data saveData:T){
        var keychainQuery = self.getKeyChainQuery(service: serviceString)
        SecItemDelete(keychainQuery as CFDictionary)
        if #available(iOS 12.0, *) {
            try? keychainQuery[kSecValueData as String] = NSKeyedArchiver.archivedData(withRootObject:saveData,requiringSecureCoding:true)
        }else{
            keychainQuery[kSecValueData as String] = NSKeyedArchiver.archivedData(withRootObject: saveData)
        }
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    /// 读取
    public static func readKeyChainData<T>(service serviceString:String!) -> T?{
        
        var result:T? = nil
        
        var keychainQuery = self.getKeyChainQuery(service: serviceString)
        keychainQuery[kSecReturnData as String] = kCFBooleanTrue
        keychainQuery[kSecMatchLimit as String] = kSecMatchLimitOne
        
        var keyData:CFTypeRef? = nil
        if SecItemCopyMatching(keychainQuery as CFDictionary, &keyData) == noErr ,
           let kData = keyData as? Data{
            result = NSKeyedUnarchiver.unarchiveObject(with: kData) as? T
        }
                
        return result
    }
    
    /// 删除
    public static func deleteKeyChainData(service serviceString:String!){
        let keychainQuery:[String:Any] =  self.getKeyChainQuery(service: serviceString)
        SecItemDelete(keychainQuery as CFDictionary)
    }
    
}
