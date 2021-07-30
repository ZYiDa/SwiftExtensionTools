//
//  ListEmptyView.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/29.
//

import Foundation
import UIKit
import EmptyDataSet_Swift

/** 列表数据为空时的占位图 **/
public class ListEmptyView{
    
    ///占位图
    fileprivate var image:UIImage?
    ///占位图竖直方向偏移量
    fileprivate var verticalOffset:CGFloat = 0
    fileprivate var verticalSpaceHeight:CGFloat = 229
    /// 点击占位图和button的回调
    fileprivate var tapClosure:(()->Void)?
    /// 标题
    fileprivate var title:String?
    /// 详情标题
    fileprivate var detailsTitle:String?
    /// 占位Button
    fileprivate var buttonTitle:String?
    /// 占位Button的背景图
    fileprivate var buttonBackgroundImage:UIImage?
    /// 占位页面背景色
    fileprivate var backgroundColor:UIColor?
    
    init(
        image img:UIImage = UIImage(named: "default_empty_image")!,
         title tt:String? = "",
         detailsTitle dt:String? = "",
         buttonTitle bt:String? = "",
        buttonBackgroundImage bImage:UIImage? = UIColor.white.toImage(withSize: CGSize(width: UIScreen.main.bounds.size.width, height: 64)),
         backgoundColor bgColor:UIColor? = .white,
         verticalOffset vo:CGFloat = 0,
         verticalSpaceHeight vh:CGFloat = 0,
         closure tapClosure:(()->Void)?) {
        
        self.tapClosure = tapClosure

        self.image = img
        
        
        
        self.verticalOffset = vo
        self.verticalSpaceHeight = vh
        self.title = tt
        self.detailsTitle = dt
        self.buttonTitle = bt
        self.buttonBackgroundImage = bImage
        self.backgroundColor = bgColor
    }
    
}

extension ListEmptyView:EmptyDataSetDelegate,EmptyDataSetSource{
    
    public func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        guard let tt = title else {
            return nil
        }
        return NSAttributedString.init(string: tt, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16)])
    }

    public func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        guard let dt = detailsTitle else {
            return nil
        }
        return NSAttributedString.init(string: dt, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)])
    }
       
    public func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return image
    }
       
    public func imageAnimation(forEmptyDataSet scrollView: UIScrollView) -> CAAnimation? {
        return nil
    }
       
    public func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        guard let bt = buttonTitle else {
            return nil
        }
        return NSAttributedString.init(string: bt, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)])
    }
    
    public func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        return buttonBackgroundImage
    }
       
    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return backgroundColor
    }
       
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }
       
    public func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalSpaceHeight
    }
       
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return true
    }
       
    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return true
    }
       
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return false
    }
       
    public func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool {
        return true
    }
       
    public func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
       guard let tapClosure = tapClosure else { return }
       tapClosure()
    }
       
    public func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
       guard let tapClosure = tapClosure else { return }
       tapClosure()
    }
    
}

public extension UIScrollView{
    
    private struct ObjcKey{
        static var listEmptyKey:Void?
    }
    
    var listEmptyView:ListEmptyView?{
        get{ objc_getAssociatedObject(self, &ObjcKey.listEmptyKey) as? ListEmptyView }
        set{
            self.emptyDataSetSource = newValue
            self.emptyDataSetDelegate = newValue
            objc_setAssociatedObject(self, &ObjcKey.listEmptyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}



