//
//  UIViewControllerExtension.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/28.
//

import UIKit

public extension UIViewController{
    //MARK: - 关闭左侧滑动手势
    func popGestureClose() {
        if let ges = self.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers {
            for item in ges {
                item.isEnabled = false
            }
        }
    }
    
    //MARK: - 打开左侧滑动手势
    func popGestureOpen() {
        if let ges = self.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers {
            for item in ges {
                item.isEnabled = false
            }
        }
    }
    
}

public extension UIViewController{
    
    private struct ObjCKey{
        static var hideNavBar               = "hideNavBar_key";
        static var setNavBackgroundColor    = "setNavBackgroundColor_key";
        static var setNavTitleColor         = "setNavTitleColor_key";
        static var setTitleSize             = "setTitleSize_key";
        static var setTitleFont             = "setTitleFont"
        static var setNavTintColor          = "setNavTintColor_key";
        static var setShadowColor           = "setShadowColor_key";
    }
    
    //MARK: - 隐藏NavigationBar
    var hideNavigationBar:Bool{
        get{ objc_getAssociatedObject(self, &ObjCKey.hideNavBar) as? Bool ?? false }
        set{ objc_setAssociatedObject(self, &ObjCKey.hideNavBar, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    //MARK: - 设置NavigationBar背景色
    var navigationBarBackgroundColor:UIColor{
        get{ objc_getAssociatedObject(self, &ObjCKey.setNavBackgroundColor) as? UIColor ?? UIColor(hexString: "#FFFFFF")! }
        set{ objc_setAssociatedObject(self, &ObjCKey.setNavBackgroundColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    //MARK: - 设置navigationItem的字体颜色
    var navigationItemTitleColor:UIColor{
        get{ objc_getAssociatedObject(self, &ObjCKey.setNavTitleColor) as? UIColor ?? .black }
        set{ objc_setAssociatedObject(self, &ObjCKey.setNavTitleColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    //MARK: - font
    var navigationItemFont:UIFont{
        get{ objc_getAssociatedObject(self, &ObjCKey.setTitleFont) as? UIFont ?? UIFont.systemFont(ofSize: 16) }
    }
    
    //MARK: - 设置NavigationBar tintColor
    var navigationBarTintColor:UIColor{
        get{ objc_getAssociatedObject(self, &ObjCKey.setNavTintColor) as? UIColor ?? .black }
        set{ objc_setAssociatedObject(self, &ObjCKey.setNavTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    //MARK: - navigationBarShadowColor
    var navigationBarShadowColor:UIColor{
        get{ objc_getAssociatedObject(self, &ObjCKey.setShadowColor) as? UIColor ?? UIColor.clear }
        set{ objc_setAssociatedObject(self, &ObjCKey.setShadowColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}


//MARK: - BaseNavigationController
class BaseNavigationController: UINavigationController,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakSelf = self
        weakSelf?.delegate = self
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        //MARK: - 导航栏是否隐藏
        self.setNavigationBarHidden(viewController.hideNavigationBar, animated: true)
        
        //MARK: - 导航栏的背景颜色
        self.navigationBar.setBackgroundImage(UIImage(named: "nav_background")?.withRenderingMode(.alwaysOriginal), for: .default)
        
        //MARK: - 导航栏的渲染色
        self.navigationBar.tintColor = viewController.navigationBarTintColor;
        
        //MARK: - 导航栏标题字体
        self.navigationBar.titleTextAttributes = [
            .foregroundColor:viewController.navigationItemTitleColor,///字体颜色
            NSAttributedString.Key.font:viewController.navigationItemFont/// 字体和大小
        ]
        
        //MARK: - 导航栏shadowImage的颜色
        navigationController.navigationBar.shadowImage = viewController.navigationBarShadowColor.toImage(withSize: CGSize(width: UIScreen.Width, height: 0.7))
    }
    
}
