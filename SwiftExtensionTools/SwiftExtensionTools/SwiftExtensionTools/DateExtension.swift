//
//  DateExtension.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/27.
//

import UIKit

public extension Date{
    //MARK: - 转化为时间戳
    var timestamp:String?{
        let ts:String? = String(self.timeIntervalSince1970)
        return ts
    }
    
    private func getDateString(withFormatter formatter:String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter.string(from: self)
    }
    //MARK: - YM-Date
    var YM:String{
        return getDateString(withFormatter: "yyyy-MM")
    }
    
    var YMD:String{
        return getDateString(withFormatter: "yyyy-MM-dd")
    }
    
    var YMDH:String{
        return getDateString(withFormatter: "yyyy-MM-dd HH")
    }
    
    var YMDHM:String{
        return getDateString(withFormatter: "yyyy-MM-dd HH:mm")
    }
    
    var YMDHMS:String{
        return getDateString(withFormatter: "yyyy-MM-dd HH:mm:ss")
    }
    
    var HMS:String{
        return getDateString(withFormatter: "HH:mm:ss")
    }
}
