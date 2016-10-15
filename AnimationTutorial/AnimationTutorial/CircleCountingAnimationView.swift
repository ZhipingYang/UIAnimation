//
//  CircleCountingAnimationView.swift
//  AnimationTutorial
//
//  Created by Daniel on 16/10/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

enum AnimationPeriod: UInt {
    
    case Start,First,Second,Third,End
    
    func description() -> String {
        switch self {
        case .Start, .First:    return "正在提取学校最新\n录取条件"
        case .Second:           return "正在与学校进行匹配"
        case .Third, .End:      return "正在根据匹配结果\n生成选校方案"
        }
    }
    
    func duration() -> TimeInterval {
        switch self {
        case .Start:    return 0.8
        case .First:    return 1
        case .Second:   return 2
        case .Third:    return 0.5
        case .End:      return 0.25
        }
    }
}

extension AnimationPeriod {
    
    mutating func next() {
        switch self {
        case .Start:    self = .First
        case .First:    self = .Second
        case .Second:   self = .Third
        case .Third:    self = .End
        default:        self = .End
        }
    }
}

private let mainColor = UIColor.purple
private let lightBlueColor = UIColor.white.withAlphaComponent(0.5)
private let ScreenWidth = UIScreen.main.bounds.width
private let ScreenHeight = UIScreen.main.bounds.height

class CircleCountingAnimationView: UIView, CAAnimationDelegate {
    private var completion: ((Void) -> (Void))?
    private var mainView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        return view
    }()
    
    private var backColorView: UIView = {
        //计算直径
        let diameter = sqrt(ScreenWidth * ScreenWidth + ScreenHeight * ScreenHeight)
        let backColorView = UIView(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        backColorView.layer.cornerRadius = diameter/2.0
        backColorView.backgroundColor = UIColor.white
        return backColorView
    }()
    
    private var mainBackView: UIView = {
        let mainBackView = UIView(frame: CGRect(x: 0, y: 0, width: 260, height: 260))
        mainBackView.layer.cornerRadius = 130
        mainBackView.layer.masksToBounds = true
        return mainBackView
    }()
    
    private var percentLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.textAlignment = .center
        label.textColor = mainColor
        return label
    }()
    
    private var descripLabel: UILabel! = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 240, height: 50))
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textColor = mainColor
        label.textAlignment = .center
        return label
    }()
    
    private var animationPeriod: AnimationPeriod = .Start
    
    private var temporaryView:UIView?
    
    private var time:Timer?
    
    class func showCountingAnimation(completion aCompletion: @escaping (Void)->(Void)) {
        let view = CircleCountingAnimationView(frame: UIScreen.main.bounds)
        view.completion = aCompletion
        let window = UIApplication.shared.keyWindow
        window?.addSubview(view)
        
        view.startShow()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backColorView.center = center
        addSubview(backColorView)
        
        backColorView.addSubview(mainView)
        
        mainView.addSubview(mainBackView)
        mainView.addSubview(percentLabel)
        mainView.addSubview(descripLabel)
        
        mainView.center = CGPoint(x: backColorView.bounds.midX, y: backColorView.bounds.midY)
        mainBackView.center = CGPoint(x: mainView.bounds.midX, y: mainView.bounds.midY)
        percentLabel.center = CGPoint(x: mainView.bounds.midX, y: mainView.bounds.midY-20)
        percentLabel.text = "0%"
        
        descripLabel.center = CGPoint(x: mainView.bounds.midX, y: mainView.bounds.midY+60)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func startShow() {
        
        let startTime = animationPeriod.duration()
        
        descripLabel.text = animationPeriod.description()
        
        temporaryView = UIView(frame: mainView.bounds)
        let temporaryLayer = self.getCricleLayer(inview: mainView, radius: 135, borderWidth: 5, strokeColor: mainColor, startAngle: CGFloat(-M_PI_2*1.2), endAngle: CGFloat(-M_PI_2))
        temporaryView!.layer.addSublayer(temporaryLayer)
        mainView.addSubview(temporaryView!)
        
        // 旋转
        let rotateAnimation = CABasicAnimation(keyPath:"transform.rotation")
        rotateAnimation.duration = startTime
        rotateAnimation.byValue = -2*M_PI
        rotateAnimation.autoreverses = false
        
        let frameAnimation = CAKeyframeAnimation(keyPath:"opacity")
        frameAnimation.duration = startTime
        frameAnimation.values = [0.5,1,1,1,0.7,0]
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [rotateAnimation,frameAnimation]
        animationGroup.duration = startTime
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        
        temporaryView!.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        temporaryView!.layer.add(animationGroup, forKey: "animationGroup")
        
        // 完整的圆圈
        let circleLayer = getCricleLayer(inview:mainView, radius: 142, borderWidth: 8, strokeColor: lightBlueColor)
        mainView.layer.insertSublayer(circleLayer, at: 0)
        circleLayer.configAnimation(startTime)
        
        //继续下第一步
        DispatchQueue.main.asyncAfter(deadline: .now() + startTime) {
            self.animationPeriod.next()
            self.firstShow()
        }
    }
    
    private func firstShow() {
        let firstTime = animationPeriod.duration()
        
        // 完整的圆圈
        let circleLayer = getCricleLayer(inview:mainView, radius: 142, borderWidth: 16, strokeColor: mainColor)
        mainView.layer.addSublayer(circleLayer)
        circleLayer.configAnimation(firstTime + AnimationPeriod.Second.duration())
        
        // 背景颜色变化
        let colorAnimation = CABasicAnimation(keyPath:"backgroundColor")
        colorAnimation.duration = firstTime + AnimationPeriod.Second.duration()
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.toValue = mainColor.cgColor
        colorAnimation.fillMode = kCAFillModeForwards
        colorAnimation.isRemovedOnCompletion = false
        backColorView.layer.add(colorAnimation, forKey: "colorAnimation")
        
        // 上升动画
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: mainBackView.bounds.midX, y: mainBackView.bounds.maxY))
        bezierPath.addLine(to: CGPoint(x: mainBackView.bounds.midX, y: mainBackView.bounds.minY))
        let riseLayer = CAShapeLayer()
        riseLayer.path = bezierPath.cgPath
        riseLayer.strokeColor = lightBlueColor.cgColor
        riseLayer.fillColor = UIColor.clear.cgColor
        riseLayer.lineWidth = mainBackView.bounds.width
        riseLayer.strokeEnd = 1.0
        riseLayer.configAnimation(colorAnimation.duration)
        mainBackView.layer.addSublayer(riseLayer)
        
        // 百分比计算
        percentLabelChange(percent: 0)
    }
    
    private func secondShow() {
        descripLabel.text = animationPeriod.description()
        self.animationPeriod.next()
    }
    
    private func thirdShow() {
        
        descripLabel.text = animationPeriod.description()

        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(animationPeriod.duration() * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            self.animationPeriod.next()
            self.endShow()
        })

    }
    
    private func endShow() {
        
        let opacityAnimation = CABasicAnimation(keyPath:"opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = animationPeriod.duration()*0.8
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = false
        mainView.layer.add(opacityAnimation, forKey: "opacityAnimation")
        
        let scaleAnimation = CABasicAnimation(keyPath:"transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 0
        scaleAnimation.duration = animationPeriod.duration()
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.delegate = self
        backColorView.layer.add(scaleAnimation, forKey: "scaleAnimation")
    }
    
    private let interval = (AnimationPeriod.First.duration() + AnimationPeriod.Second.duration())/200.0
    
    private func percentLabelChange(percent: Int) {
        
        var newPercent = percent
        
        time = Timer(timeInterval: interval, repeats: true) { [weak self] timer in
            
            guard let weakSelf = self else { return }
            if newPercent < 100 {
                newPercent += 1
                if newPercent == 30 {
                    weakSelf.secondShow()
                    weakSelf.animationPeriod.next()
                }
            } else {
                weakSelf.thirdShow()
                timer.invalidate()
            }
            weakSelf.percentLabel.text = "\(newPercent)%"
        }
        RunLoop.current.add(time!, forMode: .commonModes)
    }
    
    //MARK: CAAnimation Delegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        self.completion?()
        self.removeFromSuperview()
    }
}

extension CircleCountingAnimationView {
    
    func getCricleLayer(inview inView: UIView, radius:CGFloat, borderWidth:CGFloat, strokeColor:UIColor) -> CAShapeLayer {
        return getCricleLayer(inview: inView, radius: radius, borderWidth: borderWidth, strokeColor: strokeColor, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(M_PI_2*3))
    }
    
    func getCricleLayer(inview inView: UIView, radius:CGFloat, borderWidth:CGFloat, strokeColor:UIColor, startAngle: CGFloat, endAngle:CGFloat) -> CAShapeLayer {
        
        let circle = CAShapeLayer()
        let viewCenter = CGPoint(x: inView.bounds.midX, y: inView.bounds.midY)
        let path = UIBezierPath(arcCenter: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circle.path        = path.cgPath
        circle.fillColor   = UIColor.clear.cgColor
        circle.strokeColor = strokeColor.cgColor
        circle.strokeStart = 0
        circle.strokeEnd   = 1
        circle.lineWidth   = borderWidth
        
        return circle
    }
}

extension CAShapeLayer {
    
    func configAnimation(_ duration:CFTimeInterval) {
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = duration
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathAnimation.autoreverses = false
        self.add(pathAnimation, forKey: "strokeEndAnimation")
    }
}
