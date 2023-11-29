//
//  ViewController.swift
//  HelloWorld
//
//  Created by Apple on 2022/04/19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldXPoint: UITextField!
    @IBOutlet weak var textFieldYPoint: UITextField!
    
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var picImage: UIImageView!
    
    
    // 存储绘制的圆的信息
    var circles: [CAShapeLayer] = []
    
    
    // function
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        print("Hello, bug")
        
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        //
        //        // 检测双击
        //        tapGesture.numberOfTapsRequired = 2
        //        view.addGestureRecognizer(tapGesture)
        
        //        showLocation.text = tapGesture
    }
    
    
    // 开启屏幕双击检测
    @IBAction func startAct(_ sender: Any) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        // 检测双击
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
        
    }
    
    // 关闭屏幕双击检测
    @IBAction func closeAct(_ sender: Any) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelTap))
        // 检测双击
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
        
    }
    
    // 删除圆
    @IBAction func delAllAct(_ sender: Any) {
        deleteAllCircles()
    }
    
    // 删除最后一个圆
    @IBAction func cancelAct(_ sender: Any) {
        deleteCircles()
    }
    
    
    @IBAction func touchDelAct(_ sender: Any) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteAnyCircles(_:)))
        // 检测双击
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
    }
    
    
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: picImage)
        print("Touch coordinates: \(location.x), \(location.y)")
        
        // 创建圆的路径
        let circlePath = UIBezierPath(arcCenter: location, radius: 25, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        // 创建圆的图层
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = 2.0
        
        picImage.layer.addSublayer(circleLayer)
        
        // 存储图层信息
        circles.append(circleLayer)
        
        // 消圆
        // Optional: Animate the disappearance of the circle
        //           CATransaction.begin()
        //           CATransaction.setCompletionBlock {
        //               circleLayer.removeFromSuperlayer()
        //           }
        //           let animation = CABasicAnimation(keyPath: "opacity")
        //           animation.fromValue = 1.0
        //           animation.toValue = 0.0
        //           animation.duration = 0.5
        //           circleLayer.add(animation, forKey: "opacityAnimation")
        //           CATransaction.commit()
        
        // 获取双击位置展现
        if gesture.state == .ended {
            let location = gesture.location(in: picImage)
            // 处理双击位置
            let x: CGFloat = location.x
            let y: CGFloat = location.y
            textFieldXPoint.text = "\(x)"
            textFieldYPoint.text = "\(y)"
        }
    }
    
    // 关闭屏幕双击检测Act
    @objc func cancelTap() {
        print("Screen tapped!")
    }
    
    // 删除all图层信息
    @objc func deleteAllCircles() {
        for circleLayer in circles {
            circleLayer.removeFromSuperlayer()
        }
        circles.removeAll()
    }
    
    // 删除最后一个图层信息
    @objc func deleteCircles() {
        if let lastCircleLayer = circles.last {
            lastCircleLayer.removeFromSuperlayer()
            circles.removeLast()
        }
    }
    
    // 删除图层信息
    @objc func deleteAnyCircles(_ gesture: UITapGestureRecognizer) {
        // 获取按钮的中心点位置，也可以使用触摸手势的位置
        let location = gesture.location(in: picImage)
        
        // 迭代数组，找到位置在触摸点附近的图层并删除
        for (index, circleLayer) in circles.enumerated() {
            if circleLayer.path?.contains(location) == true {
                circleLayer.removeFromSuperlayer()
                circles.remove(at: index)
                break // 如果只想删除一个，可以添加 break
            }
        }
        
        
        // 获取单击位置展现
        //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        let firstTouch:UITouch = touches.first!
        //        let firstPoint = firstTouch.location(in: self.view)
        //
        //        let x:CGFloat = firstPoint.x
        //        let y:CGFloat = firstPoint.y
        //
        //        self.textFieldXPoint.text = "\(x)"
        //        self.textFieldYPoint.text = "\(y)"
        //    }
        
    }
    
}
