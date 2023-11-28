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
    
    
    
    
    // function
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        print("Hello, bug")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        // 检测双击
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
        
        //        showLocation.text = tapGesture
    }
    
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        print("Touch coordinates: \(location.x), \(location.y)")
        
        // 画圆
        let circlePath = UIBezierPath(arcCenter: location, radius: 25, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = 2.0
        
        view.layer.addSublayer(circleLayer)
        
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
            let location = gesture.location(in: view)
            
            // 处理双击位置
            let x: CGFloat = location.x
            let y: CGFloat = location.y
            
            textFieldXPoint.text = "\(x)"
            textFieldYPoint.text = "\(y)"
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

