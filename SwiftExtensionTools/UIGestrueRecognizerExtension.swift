//
//  UIGestrueRecognizerExtension.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/26.
//

/**
 对UIGestureRecognizer进行block形式扩展
 */

import UIKit

public typealias GestrueBlock = (_ gestrueRecognizer:Any?)->Void

extension UIGestureRecognizer{
    
    private struct ObjcKey{
        public static var targetKey:Int = 19922020
    }
    
    public static func recognizer(action gestrueBlock:GestrueBlock!) -> UIGestureRecognizer{
        let t:UIGestureRecognizer = self.init()
        t.addAction(with: gestrueBlock)
        weak var t2 = t
        t.addTarget(t2 as Any, action: #selector(invoke(_:)))
        return t
    }
    
    private func addAction(with block:GestrueBlock!){
        objc_setAssociatedObject(self, &ObjcKey.targetKey, block, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    @objc private func invoke(_ sender:Any!){
        guard let block:GestrueBlock = (objc_getAssociatedObject(self, &ObjcKey.targetKey) as? GestrueBlock) else {
            return
        }
        block((sender))
    }
}
