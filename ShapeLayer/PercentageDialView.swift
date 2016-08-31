//
//  PercentageDialView.swift
//  ShapeLayer
//
//  Created by lanshijie on 16/8/29.
//  Copyright © 2016年 LanSJ. All rights reserved.
//

import UIKit

let Screen_Bounds = UIScreen.mainScreen().bounds
let SCREEN_HEIGHT = Screen_Bounds.size.height
let SCREEN_WIDTH  = Screen_Bounds.size.width
func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor {return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)}
func angleConversion(angle:Double) -> CGFloat {return CGFloat(angle*M_PI / 180)}

class PercentageDialView: UIView {
    var percentage:Double = 0.0 {
        didSet{
            percentage = percentage / 100 * 240 + 150;//计算出对应的角度
            self.setNeedsDisplay();
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor();
        self.setNeedsDisplay();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //表盘
    lazy var percentGLayer   :CAGradientLayer = {
        var percentGLayer = CAGradientLayer();
        var shapeL = CAShapeLayer()
        let radius:CGFloat = 150.0;
        shapeL.path = UIBezierPath(arcCenter:self.center, radius: radius, startAngle: angleConversion(150.0), endAngle: angleConversion(390.0), clockwise: true).CGPath
        
        shapeL.fillColor = UIColor.clearColor().CGColor
        shapeL.strokeColor = UIColor.purpleColor().CGColor
        shapeL.lineWidth = 15.0;
        shapeL.lineDashPattern = [2.95,8];
        
        percentGLayer.frame = self.frame;
        percentGLayer.colors = [UIColor.lightGrayColor().CGColor,UIColor.lightGrayColor().CGColor];
        percentGLayer.startPoint = CGPointMake(0,0.5);
        percentGLayer.endPoint = CGPointMake(1,0.5);
        percentGLayer.mask = shapeL;
        
        return percentGLayer
    }()
    
    lazy var lineGLayer      :CAGradientLayer = {
        var lineGLayer = CAGradientLayer();
        var shapeL = CAShapeLayer()
        let radius:CGFloat = 120.0;
        shapeL.path = UIBezierPath(arcCenter:self.center, radius: radius, startAngle: angleConversion(150.0), endAngle: angleConversion(390.0), clockwise: true).CGPath
        shapeL.fillColor = UIColor.clearColor().CGColor
        shapeL.strokeColor = UIColor.blackColor().CGColor
        shapeL.lineWidth = 1.0;
        
        lineGLayer.frame = self.frame;
        lineGLayer.colors = [UIColor.blackColor().CGColor,UIColor.blackColor().CGColor];
        lineGLayer.startPoint = CGPointMake(0,0.5);
        lineGLayer.endPoint = CGPointMake(1,0.5);
        lineGLayer.mask = shapeL;
        return lineGLayer
    }()
    
    lazy var colors:NSArray = {
        return [
                UIColor.blackColor().CGColor,
                UIColor.blackColor().CGColor]
    }()
    
    
    override func drawRect(rect: CGRect) {
        for (var i = 0; i < self.layer.sublayers?.count; i += 1)
        {
            let sub = self.layer.sublayers![i] 
            sub.removeFromSuperlayer()//减少污渍
        }
        
        self.layer.addSublayer(self.lineGLayer);
        self.layer.addSublayer(self.percentGLayer);
        
        let percentGLayer = CAGradientLayer();
        let shapeL = CAShapeLayer()
        let radius:CGFloat = 150.0;
        shapeL.path = UIBezierPath(arcCenter:self.center, radius: radius, startAngle: angleConversion(150.0), endAngle: angleConversion(self.percentage), clockwise: true).CGPath
        
        shapeL.fillColor = UIColor.clearColor().CGColor
        shapeL.strokeColor = UIColor.redColor().CGColor
        shapeL.lineWidth = 15.0;
        shapeL.lineDashPattern = [2.95,8];
        
        let drawAnimation = CABasicAnimation(keyPath:"strokeEnd");
        drawAnimation.duration            = 5.0;
        drawAnimation.repeatCount         = 1.0;
        drawAnimation.removedOnCompletion = false;
        drawAnimation.fromValue = 0;
        drawAnimation.toValue = 10;
        drawAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn);
        shapeL.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
        
        
        percentGLayer.frame = self.frame;
        percentGLayer.colors = self.colors as [AnyObject];
        percentGLayer.startPoint = CGPointMake(0,0.5);
        percentGLayer.endPoint = CGPointMake(1,0.5);
        percentGLayer.mask = shapeL;
        self.layer.addSublayer(percentGLayer);
        
    }
    
    
}
