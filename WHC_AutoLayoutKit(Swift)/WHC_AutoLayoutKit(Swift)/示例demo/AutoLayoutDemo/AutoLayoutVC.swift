//
//  AutoLayoutDemoVC.swift
//  WHC_AutoLayoutKit(Swift)
//
//  Created by WHC on 16/7/9.
//  Copyright © 2016年 WHC. All rights reserved.
//

/*
 *  iOS技术交流群:490149447
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit
 */

import UIKit

class AutoLayoutVC: UIViewController {
    
    private let leftTopLable = UILabel()
    private let rightTopLable = UILabel()
    private let leftBottomLable = UILabel()
    private let rightBottomLable = UILabel()
    
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "AutoLayout示例"
        self.view.addSubview(leftTopLable)
        self.view.addSubview(rightTopLable)
        self.view.addSubview(leftBottomLable)
        self.view.addSubview(rightBottomLable)
        self.view.addSubview(button)
        
        // 添加约束
        leftTopLable.whc_Left(0).whc_Top(64).whc_Size(100, height: 100)
        leftBottomLable.whc_Left(0).whc_BaseLine(0).whc_SizeEqual(rightTopLable)
        rightTopLable.whc_Trailing(0).whc_Top(64).whc_SizeEqual(leftTopLable)
        rightBottomLable.whc_Trailing(0).whc_BaseLine(0).whc_SizeEqual(leftBottomLable)
        
        button.whc_CenterEqual(self.view, offsetX: 0, offsetY: 32).whc_WidthEqual(leftTopLable)
        
        
        leftTopLable.backgroundColor = UIColor.orangeColor()
        leftBottomLable.backgroundColor = UIColor.orangeColor()
        rightTopLable.backgroundColor = UIColor.orangeColor()
        rightBottomLable.backgroundColor = UIColor.orangeColor()
        
        leftTopLable.text = "1"
        rightTopLable.text = "2"
        leftBottomLable.text = "3"
        rightBottomLable.text = "4"
        
        leftTopLable.textAlignment = .Center
        rightTopLable.textAlignment = .Center
        leftBottomLable.textAlignment = .Center
        rightBottomLable.textAlignment = .Center
        
        button.backgroundColor = UIColor.redColor()
        
        button.setTitle("开始动画", forState: .Normal)
        button.addTarget(self, action: #selector(self.clickStartAnimation(_:)), forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clickStartAnimation(sender: UIButton) -> Void {
        // 动态更新约束
        leftTopLable.whc_Trailing(0).whc_BaseLine(0)
        rightTopLable.whc_Left(0).whc_BaseLineEqual(leftTopLable)
        leftBottomLable.whc_TrailingEqual(leftTopLable).whc_Top(64)
        rightBottomLable.whc_LeftEqual(rightTopLable).whc_TopEqual(leftBottomLable)
        UIView.animateWithDuration(1) { 
            self.view.layoutIfNeeded()
        }
    }

}
