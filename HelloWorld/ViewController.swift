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
    }
    
    
    // 开启屏幕双击检测
    @IBAction func startAct(_ sender: Any) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        // 检测双击
        tapGesture.numberOfTapsRequired = 2
        picImage.addGestureRecognizer(tapGesture)
        
    }
    
    // 关闭屏幕双击检测
    @IBAction func closeAct(_ sender: Any) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelTap))
        // 检测双击
        tapGesture.numberOfTapsRequired = 2
        picImage.addGestureRecognizer(tapGesture)
        
    }
    
    // 删除所有图层
    @IBAction func delAllAct(_ sender: Any) {
        deleteAllCircles()
    }
    
    // 删除最后一个图层
    @IBAction func cancelAct(_ sender: Any) {
        deleteCircles()
    }
    
    // 双击点按删除
    @IBAction func touchDelAct(_ sender: Any) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteAnyCircles(_:)))
        // 检测双击
        tapGesture.numberOfTapsRequired = 2
        picImage.addGestureRecognizer(tapGesture)
    }
    
    
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            let location = gesture.location(in: picImage)
            let circleLayer = CAShapeLayer()
            
            
            // 是否存在标记
            if circles.isEmpty{
                // 创建圆的路径
                let circlePath = UIBezierPath(arcCenter: location, radius: 15, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
                // 创建圆的图层
                circleLayer.path = circlePath.cgPath
                circleLayer.strokeColor = UIColor.red.cgColor
                circleLayer.fillColor = UIColor.clear.cgColor
                circleLayer.lineWidth = 2.0
                picImage.layer.addSublayer(circleLayer)
                // 存储图层信息
                circles.append(circleLayer)
                
                createButtonsAroundCircle(center: location, radius: 50.0)
            }else{
                // 遍历已存在的圆，判断触摸位置是否在某个圆内
                var isTouchInsideExistingCircle = false
                
                for (index, existingCircleLayer) in circles.enumerated() {
                    if existingCircleLayer.path?.contains(location) == true {
                        
                        circles.append(circles.remove(at: index))
                        for circle in circles {
                            picImage.layer.addSublayer(circle)
                                   }
                    
//                        
//                       // 如果触摸位置在某个已有的圆内，创建按钮
                        createButtonsAroundCircle(center: location, radius: 50.0)
                        isTouchInsideExistingCircle = true
                        break
                    }
                }
                
                if !isTouchInsideExistingCircle {
                    // 创建圆的路径
                    let circlePath = UIBezierPath(arcCenter: location, radius: 15, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
                    // 创建圆的图层
                    circleLayer.path = circlePath.cgPath
                    circleLayer.strokeColor = UIColor.red.cgColor
                    circleLayer.fillColor = UIColor.clear.cgColor
                    circleLayer.lineWidth = 2.0
                    
                    // 添加图层
                    picImage.layer.addSublayer(circleLayer)
                    // 存储图层信息
                    circles.append(circleLayer)
                    
                    createButtonsAroundCircle(center: location, radius: 50.0)
                    
                }
                
            }
            
    //        // 创建x号路径
    //        let crossPath = createCrossPath(at: location)
    //        // 创建 CAShapeLayer 显示路径
    //        let crossrLayer = CAShapeLayer()
    //        crossrLayer.path = crossPath.cgPath
    //        crossrLayer.strokeColor = UIColor.red.cgColor
    //        crossrLayer.fillColor = UIColor.clear.cgColor
    //        crossrLayer.lineWidth = 2.0
            
    //        // 创建星号路径
    //        let starPath = createStarPath(at: location)
    //        // 创建 CAShapeLayer 显示路径
    //        let starLayer = CAShapeLayer()
    //        starLayer.path = starPath.cgPath
    //        starLayer.fillColor = UIColor.red.cgColor
    //        starLayer.lineWidth = 2.0
    //
            
//            picImage.layer.addSublayer(crossPath)
//            // 存储图层信息
//            circles.append(crossPath)
//
//            createButtonsAroundCircle(center: location, radius: 50.0)
            
            
            print("Touch 坐标: \(location.x), \(location.y)")
            // 获取双击位置展现
            // 处理双击位置
            let x: CGFloat = location.x
            let y: CGFloat = location.y
            textFieldXPoint.text = "x:\(x)"
            textFieldYPoint.text = "y:\(y)"
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelTap))
            // 检测双击
            tapGesture.numberOfTapsRequired = 2
            picImage.addGestureRecognizer(tapGesture)
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
    }
    
    
    
    
    // 画星路径函数
    func createStarPath(at center: CGPoint) -> UIBezierPath {
        let starPath = UIBezierPath()

        let numberOfPoints = 5
        let starRadius: CGFloat = 10.0
        let angleIncrement = CGFloat.pi * 4.0 / CGFloat(numberOfPoints * 2)

        for i in 0..<numberOfPoints * 2 {
            let radius = i % 2 == 0 ? starRadius : starRadius / 2.0
            let angle = CGFloat(i) * angleIncrement
            let x = center.x + radius * sin(angle)
            let y = center.y + radius * cos(angle)

            if i == 0 {
                starPath.move(to: CGPoint(x: x, y: y))
            } else {
                starPath.addLine(to: CGPoint(x: x, y: y))
            }
        }
        starPath.close()
        return starPath
    }
    
    // 画×路径函数
    func createCrossPath(at center: CGPoint) -> UIBezierPath {
        let crossPath = UIBezierPath()
        // 定义叉号的大小
        let crossSize: CGFloat = 20.0
        // 移动到左上角
        crossPath.move(to: CGPoint(x: center.x - crossSize/2, y: center.y - crossSize/2))
        // 添加斜线
        crossPath.addLine(to: CGPoint(x: center.x + crossSize/2, y: center.y + crossSize/2))
        // 移动到左下角
        crossPath.move(to: CGPoint(x: center.x - crossSize/2, y: center.y + crossSize/2))
        // 添加斜线
        crossPath.addLine(to: CGPoint(x: center.x + crossSize/2, y: center.y - crossSize/2))
        crossPath.close()
        return crossPath
    }
    
    
    // 围绕标记生成按钮
    func createButtonsAroundCircle(center: CGPoint, radius: CGFloat) {
         let buttonTitles = ["delete", "OK", "Button C", "Button D"]
         let buttonActions = [#selector(cancelTapped), #selector(oKTapped), #selector(buttonCTapped), #selector(buttonDTapped)]

         for i in 0..<buttonTitles.count {
             let angle = CGFloat(i) * (CGFloat.pi * 2.0 / CGFloat(buttonTitles.count))
             let x = center.x + radius * cos(angle)
             let y = center.y + radius * sin(angle)

             let button = UIButton(type: .system)
             button.setTitle(buttonTitles[i], for: .normal)
             button.frame = CGRect(x: x - 50, y: y - 25, width: 100, height: 50)
             button.addTarget(self, action: buttonActions[i], for: .touchUpInside)

             picImage.bringSubviewToFront(button)
             picImage.addSubview(button)
         }
     }
    
    @objc func cancelTapped() {
        print("delete!")
        
        deleteCircles()
        
        picImage.subviews.forEach { subview in
            if subview is UIButton {
                subview.isHidden = true
            }
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        // 检测双击
        tapGesture.numberOfTapsRequired = 2
        picImage.addGestureRecognizer(tapGesture)
    }

    @objc func oKTapped() {
        print("OK tapped!")
        
        picImage.subviews.forEach { subview in
            if subview is UIButton {
                subview.isHidden = true
            }
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        // 检测双击
        tapGesture.numberOfTapsRequired = 2
        picImage.addGestureRecognizer(tapGesture)
    }

    @objc func buttonCTapped() {
        print("Button C tapped!")
        
        picImage.subviews.forEach { subview in
            if subview is UIButton {
                subview.isHidden = true
            }
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        // 检测双击
        tapGesture.numberOfTapsRequired = 2
        picImage.addGestureRecognizer(tapGesture)
    }

    @objc func buttonDTapped() {
        print("Button D tapped!")
        
        picImage.subviews.forEach { subview in
            if subview is UIButton {
                subview.isHidden = true
            }
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        // 检测双击
        tapGesture.numberOfTapsRequired = 2
        picImage.addGestureRecognizer(tapGesture)
    }
    
    
}
