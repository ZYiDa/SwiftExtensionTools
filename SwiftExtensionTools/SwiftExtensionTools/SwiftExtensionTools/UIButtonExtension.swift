//
//  UIButtonExtension.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/26.
//

/**
 
 使用说明
 1- 使用block形式给UIButton添加事件
 2- 扩大UIButton的点击范围
 */

import UIKit

public typealias ButtonActionBlock = (_ btn:UIButton)->Void

extension UIButton{
    
    private struct ObjcKey{
        static var ActionKey = "ActionKey"
        static var TopKey = "TopKey"
        static var LeftKey = "LeftKey"
        static var BottomKey = "BottomKey"
        static var RightKey = "RightKey"
    }
    
    //MARK: ********** Button添加Block回调 **********
    public func add(action ac:ButtonActionBlock!,controlEvent ce:UIControl.Event){
        
        weak var WeakSelf = self;
        objc_setAssociatedObject(WeakSelf as Any, &ObjcKey.ActionKey, ac, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        WeakSelf?.addTarget(WeakSelf, action: #selector(action(btn:)), for: ce)
    }
    
    @objc private func action(btn:UIButton){
        weak var WeakSelf = self;
        guard let btnBlock:ButtonActionBlock = objc_getAssociatedObject(WeakSelf as Any, &ObjcKey.ActionKey) as? ButtonActionBlock else {
            return
        }
        btnBlock(self);
    }
    
    //MARK: 增大点击区域
    public func enlarge(edge:CGFloat){
        objc_setAssociatedObject(self, &ObjcKey.TopKey, edge, .OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &ObjcKey.LeftKey, edge, .OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &ObjcKey.BottomKey, edge, .OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &ObjcKey.RightKey, edge, .OBJC_ASSOCIATION_ASSIGN)
    }
    
    //MARK: 增大指定方向的点击区域
    public func enlarge(top:CGFloat,left:CGFloat,bottom:CGFloat,right:CGFloat){
        objc_setAssociatedObject(self, &ObjcKey.TopKey, top, .OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &ObjcKey.LeftKey, left, .OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &ObjcKey.BottomKey, bottom, .OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &ObjcKey.RightKey, right, .OBJC_ASSOCIATION_ASSIGN)
    }
    
    private func enlargeRect() -> CGRect{
        let top:CGFloat = objc_getAssociatedObject(self, &ObjcKey.TopKey) as? CGFloat ?? 0.0
        let left:CGFloat = objc_getAssociatedObject(self, &ObjcKey.LeftKey) as? CGFloat ?? 0.0
        let bottom:CGFloat = objc_getAssociatedObject(self, &ObjcKey.BottomKey) as? CGFloat ?? 0.0
        let right:CGFloat = objc_getAssociatedObject(self, &ObjcKey.RightKey) as? CGFloat ?? 0.0
        
        return CGRect(x: self.bounds.origin.x - left,
                      y: self.bounds.origin.y - top,
                      width: self.bounds.size.width + left + right,
                      height: self.bounds.size.height + top + bottom)
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.enlargeRect()
        if rect.equalTo(self.bounds) {
            return super.point(inside: point, with: event)
        }
        return rect.contains(point) ? true:false
    }
}

