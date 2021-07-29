//
//  LoadingHUD.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/29.
//

import UIKit
import MBProgressHUD

private class LoadingView: UIView {
    
    var width = 225.0
    var height = 76.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = false
        self.contentMode = .scaleAspectFit
        
        width = Double(frame.size.width)
        height = Double(frame.size.height)
        if width >= 225.0 { width = 225.0 }
        if height >= 76.0 { height = 76.0 }
    }
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class LoadingHUD {
    
    //MARK: - Loaing动画范围宽度
    public static var LoadingAnimationViewWidth:CGFloat = 54
    //MARK: - LoadingHUD的最小Size
    public static var MinLoadingSize:CGSize = CGSize(width: 180, height: 100)
    //MARK: - LoadingHUD的背景色
    public static var LoadingBackgroundColor:UIColor = UIColor(hexString: "#6070FC")!.withAlphaComponent(0.2)
    //MARK: - LoaingHUD的内容颜色，包括msg以及button的颜色
    public static var LoadingContentColor:UIColor = UIColor(hexString: "#6070FC")!
    //MARK: - LoadingHUD的动画颜色
    public static var LoadingAnimationColor:UIColor = UIColor(hexString: "#6070FC")!
    //MARK: - HUD停留时间
    public static var LoadingHUDDissmissDelayTime:TimeInterval = 1.8
    //MARK: - 当前显示的HUD
    public static var current:MBProgressHUD?
    
    //MARK: - 加载动画HUD
    public static func show(
        message msg:String,
        inView view:UIView,
        animationType aType:UIView.UIViewAnimationType = .CircleRotateChase,
        cancelButtonTitle title:String?,
        cancelAction cancel:((_ btn:UIButton)->Void)?){
        
        if let current = current {
            current.hide(animated: true, afterDelay: 0)
        }
        
        DispatchQueue.main.async {
            
            MBProgressHUD.forView(view)?.hide(animated: true, afterDelay: 0)
            
            let loadingHUD:MBProgressHUD = MBProgressHUD.showAdded(to: view, animated: true)
            let animationView = LoadingView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: LoadingAnimationViewWidth,
                    height: LoadingAnimationViewWidth
                )
            )
            animationView.animationColor = LoadingAnimationColor
            animationView.animatonType = aType
            loadingHUD.animationType = .zoom
            loadingHUD.mode = .customView;
            loadingHUD.customView = animationView;
            loadingHUD.minSize = MinLoadingSize
            loadingHUD.detailsLabel.text = msg;
            loadingHUD.bezelView.blurEffectStyle = .light
            loadingHUD.bezelView.color = LoadingBackgroundColor
            loadingHUD.contentColor = LoadingContentColor
            loadingHUD.detailsLabel.numberOfLines = 2
            loadingHUD.isSquare = false
            loadingHUD.margin = 16
            loadingHUD.removeFromSuperViewOnHide = true;
            loadingHUD.isUserInteractionEnabled = true
            
            if let cancel = cancel,let t = title{
                loadingHUD.button.setTitle(t, for: .normal)
                loadingHUD.button.add(action: cancel, controlEvent: .touchUpInside)
            }
            
            current = loadingHUD
        }
    }
    
    //MARK: - 显示Success
    public static func showSuccess(withMessage msg:String,
                                   inView view:UIView){
        let hud = showResult(message: msg, inView: view, animationType: .Success)
        hud.hide(animated: true, afterDelay: LoadingHUDDissmissDelayTime)
    }
    
    //MARK: - 显示Error
    public static func showError(withMessage msg:String,
                                 inView view:UIView){
        let hud = showResult(message: msg, inView: view, animationType: .Fail)
        hud.hide(animated: true, afterDelay: LoadingHUDDissmissDelayTime)
    }
    
    //MARK: - 显示添加
    public static func showAdd(withMessage msg:String,
                               inView view:UIView){
        let hud = showResult(message: msg, inView: view, animationType: .Add)
        hud.hide(animated: true, afterDelay: LoadingHUDDissmissDelayTime)
    }
    
    //MARK: - 显示单独的文字信息
    public static func showInfo(withMessage msg:String,
                                inView view:UIView){
        let hud = showResult(message: msg, inView: view, animationType: nil)
        hud.hide(animated: true, afterDelay: LoadingHUDDissmissDelayTime)
    }
    
    //MARK: - 加载结果显示的HUD
    private static func showResult(message msg:String,
                                  inView view:UIView,
                                  animationType aType:UIView.UIViewAnimatedIcon? = .None)->MBProgressHUD{
        
        if let current = current {
            current.hide(animated: true, afterDelay: 0)
        }
        MBProgressHUD.forView(view)?.hide(animated: true, afterDelay: 0)
        
        let loadingHUD:MBProgressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        
        if let type = aType {
            let animationView = LoadingView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: LoadingAnimationViewWidth,
                    height: LoadingAnimationViewWidth
                )
            )
            animationView.animationColor = LoadingAnimationColor
            animationView.animatedIcon = type
            loadingHUD.mode = .customView
            loadingHUD.customView = animationView
            loadingHUD.minSize = MinLoadingSize
        }else{
            loadingHUD.mode = .text
            loadingHUD.minSize = .zero
        }
        
        loadingHUD.animationType = .zoom
        loadingHUD.isUserInteractionEnabled = true
        loadingHUD.detailsLabel.text = msg;
        loadingHUD.bezelView.blurEffectStyle = .light
        loadingHUD.bezelView.color = LoadingBackgroundColor
        loadingHUD.contentColor = LoadingContentColor
        loadingHUD.detailsLabel.numberOfLines = 2
        loadingHUD.isSquare = false
        loadingHUD.margin = 16
        loadingHUD.removeFromSuperViewOnHide = true;
        current = loadingHUD
        return loadingHUD
    }
}
