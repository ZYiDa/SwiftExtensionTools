//
//  UITextView+Placeholder.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/26.
//

import UIKit

final class PlaceHolderTextView :  UITextView{
    fileprivate lazy var placeHolderLabel: UILabel = {
        $0.font = UIFont(name: "PingFangSC-Regular", size: 14)
        $0.textColor = UIColor(hexString: "#575757", alpha: 0.5)
        $0.text = "有什么意见都可以反馈~"
        $0.textColor = UIColor.lightGray
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    @IBInspectable
    var placeHolder: String? {
        didSet {
            placeHolderLabel.text = placeHolder
        }
    }
    
    override var font: UIFont? {
        didSet {
            if let f = font {
                // 让在属性哪里修改的字体,赋给给我们占位label
                placeHolderLabel.font = f
            }
        }
    }
    
    // 重写text
    override var text: String? {
        didSet {
            // 根据文本是否有内容而显示占位label
            placeHolderLabel.isHidden = hasText
        }
    }
    
    // frame
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    // xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // 添加控件,设置约束
    fileprivate func setupUI() {
        // 监听内容的通知
        NotificationCenter.default.addObserver(self, selector: #selector(PlaceHolderTextView.valueChange), name: UITextView.textDidChangeNotification, object: nil)
        
        // 添加控件
        addSubview(placeHolderLabel)
        
        // 设置约束,使用系统的约束
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: placeHolderLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -10))
    }
    
    // 内容改变的通知方法
    @objc fileprivate func valueChange() {
        //占位文字的显示与隐藏
        placeHolderLabel.isHidden = hasText
    }
    // 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // 子控件布局
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置占位文字的坐标
        placeHolderLabel.frame.origin.x = 0
        placeHolderLabel.frame.origin.y = 7
    }
}

