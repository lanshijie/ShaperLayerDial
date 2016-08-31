//
//  ViewController.swift
//  ShapeLayer
//
//  Created by lanshijie on 16/8/29.
//  Copyright © 2016年 LanSJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var btn:UIButton  = UIButton();
    var label:UILabel?;
    lazy var percent:PercentageDialView = {
        return PercentageDialView();
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.percent.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH);
        self.view .addSubview(percent);
        let d = Double(arc4random()%100);
        self.percent.percentage = d;
        
        
        let bounds = UIScreen.mainScreen().bounds;
        btn.frame = CGRectMake(bounds.width / 2 - 50, bounds.height - 100, 100, 100);
        btn.backgroundColor = UIColor.redColor();
        self.view.addSubview(btn);
        btn.addTarget(self, action: #selector(ViewController.action), forControlEvents: UIControlEvents.TouchUpInside);
        
        label = UILabel();
        label!.frame = CGRectMake(0, 0, 200, 200);
        label?.textAlignment = NSTextAlignment.Center;
        label!.text = "\(Int(d))%";
        label!.font = UIFont.systemFontOfSize(40.0);
        label!.center = percent.center;
        self.view.addSubview(label!);
        btn.setTitle("点击测试", forState: UIControlState.Normal);

        
    }
    func action() {
        let d = Double(arc4random()%100);
        percent.percentage = d;
        label!.text = "\(Int(d))%";
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

