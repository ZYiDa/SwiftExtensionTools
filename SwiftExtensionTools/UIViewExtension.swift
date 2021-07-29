//
//  UIViewExtension.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/26.
//
/**
 1 - 扩展UIView的动画
 2 - 添加抖动效果
 */

import UIKit
import Foundation
import AudioToolbox

//MARK: - ** 针对于UIView动画的extension **
extension UIView{
    
    fileprivate struct ObjCKey{
        static var AnimationColorKey:String = "AnimationColorKey"
        static var AnimationTypeKey:String = "AnimationTypeKey"
        static var AnimatedIconKey:String = "AnimatedIconKey"
    }
    
    #warning("动画颜色  ==>   一定要在动画类型和icon属性之前设置动画填充颜色")
    public var animationColor:UIColor{
        get{ objc_getAssociatedObject(self, &ObjCKey.AnimationColorKey) as? UIColor ?? UIColor.white }
        set{ objc_setAssociatedObject(self, &ObjCKey.AnimationColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)}
    }
    
    ///** UIView动画类型 **
    public enum UIViewAnimationType{
        case None
        /// 系统菊花
        case SystemActivityIndicator
        /// 水平波动圆
        case HorizontalCirclesPulse
        /// 水平方向垂直线条波动
        case LineScaling
        /// 单个脉冲圆
        case SingleCirclePulse
        /// 多个脉冲圆
        case MultipleCirclePulse
        /// 单个缩放波纹圆
        case SingleCircleScaleRipple
        /// 多个缩放波纹圆
        case MultipleCircleScaleRipple
        /// 旋转渐变圆
        case CircleSpinFade
        /// 旋转渐变线条
        case LineSpinFade
        /// 旋转追逐圆
        case CircleRotateChase
        /// 旋转追逐中空圆
        case CircleStrokeSpin
    }
    
    //MARK: - UIView动画Icon
    public enum UIViewAnimatedIcon{
        case None
        /// 成功
        case Success
        /// 失败
        case Fail
        /// 添加
        case Add
    }
    
    //MARK: - 动画类型属性
    public var animatonType:UIViewAnimationType{
        get{ objc_getAssociatedObject(self, &ObjCKey.AnimationTypeKey) as? UIViewAnimationType ?? UIViewAnimationType.None }
        set{
            self.layer.removeAllAnimations()
            objc_setAssociatedObject(self, &ObjCKey.AnimationTypeKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            switch newValue {
                case .None: break;
                case .SystemActivityIndicator:  self.animationSystemActivityIndicator()
                case .HorizontalCirclesPulse:   self.animationHorizontalCirclesPulse()
                case .LineScaling:              self.animationLineScaling()
                case .SingleCirclePulse:        self.animationSingleCirclePulse()
                case .MultipleCirclePulse:      self.animationMultipleCirclePulse()
                case .SingleCircleScaleRipple:  self.animationSingleCircleScaleRipple()
                case .MultipleCircleScaleRipple:self.animationMultipleCircleScaleRipple()
                case .CircleSpinFade:           self.animationCircleSpinFade()
                case .LineSpinFade:             self.animationLineSpinFade()
                case .CircleRotateChase:        self.animationCircleRotateChase()
                case .CircleStrokeSpin:         self.animationCircleStrokeSpin()
            }
        }
    }
    
    //MARK: - 动画Icon属性
    public var animatedIcon:UIViewAnimatedIcon{
        get{ objc_getAssociatedObject(self, &ObjCKey.AnimatedIconKey) as? UIViewAnimatedIcon ?? UIViewAnimatedIcon.Success }
        set{
            self.layer.removeAllAnimations()
            objc_setAssociatedObject(self, &ObjCKey.AnimatedIconKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            switch newValue {
                case .None: break
                case .Success:  self.animatedIconSucceed()
                case .Fail:     self.animatedIconFailed()
                case .Add:      self.animatedIconAdded()
            }
        }
    }
    
    // MARK: - Animation
    //MARK: - SystemActivityIndicator
    private func animationSystemActivityIndicator() {

        let spinner = UIActivityIndicatorView(style: .white)
        spinner.frame = self.bounds
        spinner.color = animationColor
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
        self.addSubview(spinner)
    }

    //MARK: - HorizontalCirclesPulse
    private func animationHorizontalCirclesPulse() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        let spacing: CGFloat = 3
        let radius: CGFloat = (width - spacing * 2) / 3
        let ypos: CGFloat = (height - radius) / 2

        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.36, 0.24, 0.12]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.3, 1]
        animation.duration = 1
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(arcCenter: CGPoint(x: radius/2, y: radius/2), radius: radius/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

        for i in 0..<3 {
            let layer = CAShapeLayer()
            layer.frame = CGRect(x: (radius + spacing) * CGFloat(i), y: ypos, width: radius, height: radius)
            layer.path = path.cgPath
            layer.fillColor = animationColor.cgColor

            animation.beginTime = beginTime - beginTimes[i]

            layer.add(animation, forKey: "animation")
            self.layer.addSublayer(layer)
        }
    }

    //MARK: - LineScaling
    private func animationLineScaling() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        let lineWidth = width / 9

        let beginTime = CACurrentMediaTime()
        let beginTimes = [0.5, 0.4, 0.3, 0.2, 0.1]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)

        let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.4, 1]
        animation.duration = 1
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: lineWidth, height: height), cornerRadius: width/2)

        for i in 0..<5 {
            let layer = CAShapeLayer()
            layer.frame = CGRect(x: lineWidth * 2 * CGFloat(i), y: 0, width: lineWidth, height: height)
            layer.path = path.cgPath
            layer.backgroundColor = nil
            layer.fillColor = animationColor.cgColor

            animation.beginTime = beginTime - beginTimes[i]

            layer.add(animation, forKey: "animation")
            self.layer.addSublayer(layer)
        }
    }

    //MARK: - SingleCirclePulse
    private func animationSingleCirclePulse() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        let duration: CFTimeInterval = 1.0

        let animationScale = CABasicAnimation(keyPath: "transform.scale")
        animationScale.duration = duration
        animationScale.fromValue = 0
        animationScale.toValue = 1

        let animationOpacity = CABasicAnimation(keyPath: "opacity")
        animationOpacity.duration = duration
        animationOpacity.fromValue = 1
        animationOpacity.toValue = 0

        let animation = CAAnimationGroup()
        animation.animations = [animationScale, animationOpacity]
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        layer.path = path.cgPath
        layer.fillColor = animationColor.cgColor

        layer.add(animation, forKey: "animation")
        self.layer.addSublayer(layer)
    }

    //MARK: - MultipleCirclePulse
    private func animationMultipleCirclePulse() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        let duration = 1.0
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0, 0.3, 0.6]

        let animationScale = CABasicAnimation(keyPath: "transform.scale")
        animationScale.duration = duration
        animationScale.fromValue = 0
        animationScale.toValue = 1

        let animationOpacity = CAKeyframeAnimation(keyPath: "opacity")
        animationOpacity.duration = duration
        animationOpacity.keyTimes = [0, 0.05, 1]
        animationOpacity.values = [0, 1, 0]

        let animation = CAAnimationGroup()
        animation.animations = [animationScale, animationOpacity]
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

        for i in 0..<3 {
            let layer = CAShapeLayer()
            layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
            layer.path = path.cgPath
            layer.fillColor = animationColor.cgColor
            layer.opacity = 0

            animation.beginTime = beginTime + beginTimes[i]

            layer.add(animation, forKey: "animation")
            self.layer.addSublayer(layer)
        }
    }

    //MARK: - SingleCircleScaleRipple
    private func animationSingleCircleScaleRipple() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        let duration: CFTimeInterval = 1.0
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.21, 0.53, 0.56, 0.8)

        let animationScale = CAKeyframeAnimation(keyPath: "transform.scale")
        animationScale.keyTimes = [0, 0.7]
        animationScale.timingFunction = timingFunction
        animationScale.values = [0.1, 1]
        animationScale.duration = duration

        let animationOpacity = CAKeyframeAnimation(keyPath: "opacity")
        animationOpacity.keyTimes = [0, 0.7, 1]
        animationOpacity.timingFunctions = [timingFunction, timingFunction]
        animationOpacity.values = [1, 0.7, 0]
        animationOpacity.duration = duration

        let animation = CAAnimationGroup()
        animation.animations = [animationScale, animationOpacity]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        layer.path = path.cgPath
        layer.backgroundColor = nil
        layer.fillColor = nil
        layer.strokeColor = animationColor.cgColor
        layer.lineWidth = 3

        layer.add(animation, forKey: "animation")
        self.layer.addSublayer(layer)
    }

    //MARK: - MultipleCircleScaleRipple
    private func animationMultipleCircleScaleRipple() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        let duration = 1.25
        let beginTime = CACurrentMediaTime()
        let beginTimes = [0, 0.2, 0.4]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.21, 0.53, 0.56, 0.8)

        let animationScale = CAKeyframeAnimation(keyPath: "transform.scale")
        animationScale.keyTimes = [0, 0.7]
        animationScale.timingFunction = timingFunction
        animationScale.values = [0, 1]
        animationScale.duration = duration

        let animationOpacity = CAKeyframeAnimation(keyPath: "opacity")
        animationOpacity.keyTimes = [0, 0.7, 1]
        animationOpacity.timingFunctions = [timingFunction, timingFunction]
        animationOpacity.values = [1, 0.7, 0]
        animationOpacity.duration = duration

        let animation = CAAnimationGroup()
        animation.animations = [animationScale, animationOpacity]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

        for i in 0..<3 {
            let layer = CAShapeLayer()
            layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
            layer.path = path.cgPath
            layer.backgroundColor = nil
            layer.strokeColor = animationColor.cgColor
            layer.lineWidth = 3
            layer.fillColor = nil

            animation.beginTime = beginTime + beginTimes[i]

            layer.add(animation, forKey: "animation")
            self.layer.addSublayer(layer)
        }
    }

    //MARK: - CircleSpinFade
    private func animationCircleSpinFade() {

        let width = self.frame.size.width

        let spacing: CGFloat = 3
        let radius = (width - 4 * spacing) / 3.5
        let radiusX = (width - radius) / 2

        let duration = 1.0
        let beginTime = CACurrentMediaTime()
        let beginTimes: [CFTimeInterval] = [0.84, 0.72, 0.6, 0.48, 0.36, 0.24, 0.12, 0]

        let animationScale = CAKeyframeAnimation(keyPath: "transform.scale")
        animationScale.keyTimes = [0, 0.5, 1]
        animationScale.values = [1, 0.4, 1]
        animationScale.duration = duration

        let animationOpacity = CAKeyframeAnimation(keyPath: "opacity")
        animationOpacity.keyTimes = [0, 0.5, 1]
        animationOpacity.values = [1, 0.3, 1]
        animationOpacity.duration = duration

        let animation = CAAnimationGroup()
        animation.animations = [animationScale, animationOpacity]
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(arcCenter: CGPoint(x: radius/2, y: radius/2), radius: radius/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

        for i in 0..<8 {
            let angle = .pi / 4 * CGFloat(i)

            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.fillColor = animationColor.cgColor
            layer.backgroundColor = nil
            layer.frame = CGRect(x: radiusX * (cos(angle) + 1), y: radiusX * (sin(angle) + 1), width: radius, height: radius)

            animation.beginTime = beginTime - beginTimes[i]

            layer.add(animation, forKey: "animation")
            self.layer.addSublayer(layer)
        }
    }

    //MARK: - LineSpinFade
    private func animationLineSpinFade() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        let spacing: CGFloat = 3
        let lineWidth = (width - 4 * spacing) / 5
        let lineHeight = (height - 2 * spacing) / 3
        let containerSize = max(lineWidth, lineHeight)
        let radius = width / 2 - containerSize / 2

        let duration = 1.2
        let beginTime = CACurrentMediaTime()
        let beginTimes: [CFTimeInterval] = [0.96, 0.84, 0.72, 0.6, 0.48, 0.36, 0.24, 0.12]
        let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.3, 1]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: lineWidth, height: lineHeight), cornerRadius: lineWidth/2)

        for i in 0..<8 {
            let angle = .pi / 4 * CGFloat(i)

            let line = CAShapeLayer()
            line.frame = CGRect(x: (containerSize-lineWidth)/2, y: (containerSize-lineHeight)/2, width: lineWidth, height: lineHeight)
            line.path = path.cgPath
            line.backgroundColor = nil
            line.fillColor = animationColor.cgColor

            let container = CALayer()
            container.frame = CGRect(x: radius * (cos(angle) + 1), y: radius * (sin(angle) + 1), width: containerSize, height: containerSize)
            container.addSublayer(line)
            container.sublayerTransform = CATransform3DMakeRotation(.pi / 2 + angle, 0, 0, 1)

            animation.beginTime = beginTime - beginTimes[i]

            container.add(animation, forKey: "animation")
            self.layer.addSublayer(container)
        }
    }

    //MARK: - CircleRotateChase
    private func animationCircleRotateChase() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        let spacing: CGFloat = 3
        let radius = (width - 4 * spacing) / 3.5
        let radiusX = (width - radius) / 2

        let duration: CFTimeInterval = 1.5

        let path = UIBezierPath(arcCenter: CGPoint(x: radius/2, y: radius/2), radius: radius/2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

        let pathPosition = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: radiusX, startAngle: 1.5 * .pi, endAngle: 3.5 * .pi, clockwise: true)

        let count = 5
        
        for i in 0..<count {
            let rate = Float(i) * 1 / Float(count)
            let fromScale = 1 - rate
            let toScale = 0.2 + rate
            let timeFunc = CAMediaTimingFunction(controlPoints: 0.5, 0.15 + rate, 0.25, 1)

            let animationScale = CABasicAnimation(keyPath: "transform.scale")
            animationScale.duration = duration
            animationScale.repeatCount = HUGE
            animationScale.fromValue = fromScale
            animationScale.toValue = toScale

            let animationPosition = CAKeyframeAnimation(keyPath: "position")
            animationPosition.duration = duration
            animationPosition.repeatCount = HUGE
            animationPosition.path = pathPosition.cgPath

            let animation = CAAnimationGroup()
            animation.animations = [animationScale, animationPosition]
            animation.timingFunction = timeFunc
            animation.duration = duration
            animation.repeatCount = HUGE
            animation.isRemovedOnCompletion = false

            let layer = CAShapeLayer()
            layer.frame = CGRect(x: 0, y: 0, width: radius, height: radius)
            layer.path = path.cgPath
            layer.fillColor = animationColor.cgColor

            layer.add(animation, forKey: "animation")
            self.layer.addSublayer(layer)
        }
    }

    //MARK: - CircleStrokeSpin
    private func animationCircleStrokeSpin() {

        let width = self.frame.size.width
        let height = self.frame.size.height

        let beginTime: Double = 0.5
        let durationStart: Double = 1.2
        let durationStop: Double = 0.7

        let animationRotation = CABasicAnimation(keyPath: "transform.rotation")
        animationRotation.byValue = 2 * Float.pi
        animationRotation.timingFunction = CAMediaTimingFunction(name: .linear)

        let animationStart = CABasicAnimation(keyPath: "strokeStart")
        animationStart.duration = durationStart
        animationStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0, 0.2, 1)
        animationStart.fromValue = 0
        animationStart.toValue = 1
        animationStart.beginTime = beginTime

        let animationStop = CABasicAnimation(keyPath: "strokeEnd")
        animationStop.duration = durationStop
        animationStop.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0, 0.2, 1)
        animationStop.fromValue = 0
        animationStop.toValue = 1

        let animation = CAAnimationGroup()
        animation.animations = [animationRotation, animationStop, animationStart]
        animation.duration = durationStart + beginTime
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards

        let path = UIBezierPath(arcCenter: CGPoint(x: width/2, y: height/2), radius: width/2, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)

        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        layer.path = path.cgPath
        layer.fillColor = nil
        layer.strokeColor = animationColor.cgColor
        layer.lineWidth = 3

        layer.add(animation, forKey: "animation")
        self.layer.addSublayer(layer)
    }

    //MARK: UIViewAnimatedIcon
    //MARK: - IconSucceed
    private func animatedIconSucceed() {

        let length = self.frame.width
        let delay = (self.alpha == 0) ? 0.25 : 0.0

        let path = UIBezierPath()
        path.move(to: CGPoint(x: length * 0.15, y: length * 0.50))
        path.addLine(to: CGPoint(x: length * 0.5, y: length * 0.80))
        path.addLine(to: CGPoint(x: length * 1.0, y: length * 0.25))

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.25
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = CACurrentMediaTime() + delay

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = animationColor.cgColor
        layer.lineWidth = 2
        layer.lineCap = .round
        layer.lineJoin = .round
        layer.strokeEnd = 0

        layer.add(animation, forKey: "animation")
        self.layer.addSublayer(layer)
    }

    //MARK: - IconFailed
    private func animatedIconFailed() {

        let length = self.frame.width
        let delay = (self.alpha == 0) ? 0.25 : 0.0

        let path1 = UIBezierPath()
        let path2 = UIBezierPath()

        path1.move(to: CGPoint(x: length * 0.15, y: length * 0.15))
        path2.move(to: CGPoint(x: length * 0.15, y: length * 0.85))

        path1.addLine(to: CGPoint(x: length * 0.85, y: length * 0.85))
        path2.addLine(to: CGPoint(x: length * 0.85, y: length * 0.15))

        let paths = [path1, path2]

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.15
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        for i in 0..<2 {
            let layer = CAShapeLayer()
            layer.path = paths[i].cgPath
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeColor = animationColor.cgColor
            layer.lineWidth = 2
            layer.lineCap = .round
            layer.lineJoin = .round
            layer.strokeEnd = 0

            animation.beginTime = CACurrentMediaTime() + 0.25 * Double(i) + delay

            layer.add(animation, forKey: "animation")
            self.layer.addSublayer(layer)
        }
    }

    //MARK: - IconAdded
    private func animatedIconAdded() {

        let length = self.frame.width
        let delay = (self.alpha == 0) ? 0.25 : 0.0

        let path1 = UIBezierPath()
        let path2 = UIBezierPath()

        path1.move(to: CGPoint(x: length * 0.1, y: length * 0.5))
        path2.move(to: CGPoint(x: length * 0.5, y: length * 0.1))

        path1.addLine(to: CGPoint(x: length * 0.9, y: length * 0.5))
        path2.addLine(to: CGPoint(x: length * 0.5, y: length * 0.9))

        let paths = [path1, path2]

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.15
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        for i in 0..<2 {
            let layer = CAShapeLayer()
            layer.path = paths[i].cgPath
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeColor = animationColor.cgColor
            layer.lineWidth = 2
            layer.lineCap = .round
            layer.lineJoin = .round
            layer.strokeEnd = 0

            animation.beginTime = CACurrentMediaTime() + 0.25 * Double(i) + delay

            layer.add(animation, forKey: "animation")
            self.layer.addSublayer(layer)
        }
    }
}

//MARK: - *** 添加抖动效果 ***
fileprivate func Play(){
    AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate) {
        #if DEBUG
        print(#function)
        #endif
    }
}

//MARK: - 抖动方向枚举
public enum ShakeDirection: Int {
    case horizontal
    case vertical
}

extension UIView {
     
    /**
     扩展UIView增加抖动方法
      
     @param direction：抖动方向（默认是水平方向）
     @param times：抖动次数（默认5次）
     @param interval：每次抖动时间（默认0.1秒）
     @param delta：抖动偏移量（默认2）
     @param completion：抖动动画结束后的回调
     */
    public func shake(
        direction: ShakeDirection = .horizontal,
        playSound:Bool = false,
        times: Int = 5,
        interval: TimeInterval = 0.1,
        delta: CGFloat = 8,
        completion: (() -> Void)? = nil) {
        if playSound { Play() }
        //播放动画
        UIView.animate(withDuration: interval, animations: { () -> Void in
            switch direction {
            case .horizontal:
                self.layer.setAffineTransform( CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.layer.setAffineTransform( CGAffineTransform(translationX: 0, y: delta))
                break
            }
            
        }) { (complete) -> Void in
            //如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) -> Void in
                    completion?()
                })
            }
            //如果当前不是最后一次抖动，则继续播放动画（总次数减1，偏移位置变成相反的）
            else {
                self.shake(direction: direction, times: times - 1,  interval: interval,
                           delta: delta * -1, completion:completion)
            }
        }
    }
}

