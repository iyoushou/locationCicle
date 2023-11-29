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
    
    
    // 开启屏幕单击检测
    @IBAction func startAct(_ sender: Any) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        // 检测单击
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
    }
    
    // 关闭屏幕单击检测
    @IBAction func closeAct(_ sender: Any) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelTap))
        // 检测单击
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
    }
    
    // 删除所有图层
    @IBAction func delAllAct(_ sender: Any) {
        deleteAllCircles()
    }
    
    // 删除最后一个图层
    @IBAction func cancelAct(_ sender: Any) {
        deleteCircles()
    }
    
    // 单击点按删除
    @IBAction func touchDelAct(_ sender: Any) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteAnyCircles(_:)))
        // 检测单击
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
    
    
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: picImage)
        print("Touch coordinates: \(location.x), \(location.y)")
        
//        // 创建圆的路径
//        let circlePath = UIBezierPath(arcCenter: location, radius: 25, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
//        // 创建圆的图层
//        let circleLayer = CAShapeLayer()
//        circleLayer.path = circlePath.cgPath
//        circleLayer.strokeColor = UIColor.red.cgColor
//        circleLayer.fillColor = UIColor.clear.cgColor
//        circleLayer.lineWidth = 2.0
        
        // 创建x号路径
        let crossPath = createCrossPath(at: location)
        // 创建 CAShapeLayer 显示路径
        let crossrLayer = CAShapeLayer()
        crossrLayer.path = crossPath.cgPath
        crossrLayer.strokeColor = UIColor.red.cgColor
        crossrLayer.fillColor = UIColor.clear.cgColor
        crossrLayer.lineWidth = 2.0
        
//        // 创建星号路径
//        let starPath = createStarPath(at: location)
//        // 创建 CAShapeLayer 显示路径
//        let starLayer = CAShapeLayer()
//        starLayer.path = starPath.cgPath
//        starLayer.fillColor = UIColor.red.cgColor
//        starLayer.lineWidth = 2.0
        
        
        picImage.layer.addSublayer(crossrLayer)
        // 存储图层信息
        circles.append(crossrLayer)
                
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
}
