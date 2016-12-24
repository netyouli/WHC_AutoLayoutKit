//
//  StackViewVC.swift
//  WHC_AutoLayoutKit(Swift)
//
//  Created by WHC on 16/7/9.
//  Copyright © 2016年 WHC. All rights reserved.
//

/*********************************************************
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit *
 *  本人其他优秀开源库：https://github.com/netyouli          *
 *********************************************************/

import UIKit

class StackViewVC: UIViewController {

    private let stackView1 = WHC_StackView()
    private let stackView2 = WHC_StackView()
    private let stackView3 = WHC_StackView()
    private let stackView4 = WHC_StackView()
    
    private let label1 = UILabel()
    private let label2 = UILabel()
    private let label3 = UILabel()
    private let label4 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "WHC_StackView示例"
        // Do any additional setup after loading the view.
        
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        self.view.addSubview(label4)
        
        self.view.addSubview(stackView1)
        self.view.addSubview(stackView2)
        self.view.addSubview(stackView3)
        self.view.addSubview(stackView4)
        
        /// 布局添加约束
        label1.whc_Left(20).whc_Right(0).whc_Height(40).whc_Top(64)
        stackView1.whc_Left(0).whc_Top(0, toView: label1).whc_Right(0).whc_Height(150)
        label2.whc_LeftEqual(label1)
              .whc_RightEqual(label1)
              .whc_HeightEqual(label1)
              .whc_Top(0, toView: stackView1)
        
        label3.whc_LeftEqual(label1)
              .whc_Top(0, toView: stackView2)
              .whc_RightEqual(stackView2)
              .whc_HeightEqual(label2)
        
        label4.whc_LeftEqual(label1)
              .whc_Top(0, toView: stackView3)
              .whc_HeightEqual(label1)
              .whc_RightEqual(label1)
        
        stackView2.whc_LeftEqual(stackView1)
                  .whc_Top(0, toView: label2)
                  .whc_HeightEqual(stackView1)
                  .whc_WidthAuto()
        
        stackView3.whc_LeftEqual(stackView1)
                  .whc_Top(0, toView: label3)
                  .whc_HeightEqual(stackView1, ratio:0.3)
                  .whc_RightEqual(stackView1)
        
        stackView4.whc_RightEqual(stackView3)
                  .whc_LeftEqual(stackView3)
                  .whc_Top(0, toView: label4)
                  .whc_HeightEqual(stackView3, ratio: 1.8)
        
        label1.text = "StackView混合布局"
        label2.text = "StackView混合布局(子视图宽度自适应)"
        label3.text = "StackView横向布局(普通横向布局)"
        label4.text = "StackView垂直布局(普通垂直布局)"
        
        // 填充内容
        stackView1.backgroundColor = UIColor.whiteColor()
        stackView2.backgroundColor = UIColor.whiteColor()
        stackView3.backgroundColor = UIColor.whiteColor()
        stackView4.backgroundColor = UIColor.whiteColor()
        
        makeStyle1ContentView()
        makeStyle2ContentView()
        makeStyle3ContentView()
        makeStyle4ContentView()
        
    }
    
    private func makeStyle1ContentView() {
        stackView1.whc_Column = 4
        stackView1.whc_Orientation = .All
        stackView1.whc_VSpace = 10
        stackView1.whc_HSpace = 10
        stackView1.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10)
        let titleArray = [["吴海超", "WHC", "Github", "iOS"],
                      ["开发者", "whc", "netyouli", "android"],
                      ["Star", "xx你好", "谢谢", "体验"],
                      ["还有力作", "关注", "xxxxx", "懂了吗"]]
        for titles in titleArray {
            for title in titles {
                let label = UILabel()
                stackView1.addSubview(label)
                label.backgroundColor = UIColor.whiteColor()
                label.clipsToBounds = true
                label.layer.cornerRadius = 5
                label.layer.borderWidth = 1
                label.layer.borderColor = UIColor.orangeColor().CGColor
                label.text = title
                label.textAlignment = .Center
            }
        }
        stackView1.whc_StartLayout()
    }

    private func makeStyle2ContentView() {
        stackView2.whc_Column = 4
        stackView2.whc_Orientation = .All
        stackView2.whc_HSpace = 20
        stackView2.whc_VSpace = 10
        stackView2.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10)
        let titleArray = [["吴海超", "WHC", "Github", "iOS"],
                          ["开发者", "whc", "netyouli", "android"],
                          ["Star", "xx你好", "谢谢", "体验"],
                          ["还有力作", "关注", "xxxxx", "懂了吗"]]
        for titles in titleArray {
            for title in titles {
                let button = UIButton()
                stackView2.addSubview(button)
                button.backgroundColor = UIColor.whiteColor()
                button.clipsToBounds = true
                button.layer.cornerRadius = 5
                button.layer.borderWidth = 1
                button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10)
                button.layer.borderColor = UIColor.orangeColor().CGColor
                button.setTitle(title, forState: .Normal)
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            }
        }
        stackView2.whc_StartLayout()
    }
    
    private func makeStyle3ContentView() {
        stackView3.whc_Column = 4
        stackView3.whc_Orientation = .Horizontal
        stackView3.whc_HSpace = 20
        stackView3.whc_VSpace = 10
        stackView3.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10)
        let titles = ["吴海超", "WHC", "Github", "iOS"]
            for title in titles {
                let label = UILabel()
                stackView3.addSubview(label)
                label.backgroundColor = UIColor.whiteColor()
                label.clipsToBounds = true
                label.layer.cornerRadius = 5
                label.layer.borderWidth = 1
                label.layer.borderColor = UIColor.orangeColor().CGColor
                label.text = title
                label.textAlignment = .Center
            }
        stackView3.whc_StartLayout()
    }

    private func makeStyle4ContentView() {
        stackView4.whc_Orientation = .Vertical
        stackView4.whc_VSpace = 10
        stackView4.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10)
        let titles = ["Github", "iOS"]
        for title in titles {
            let label = UILabel()
            stackView4.addSubview(label)
            label.backgroundColor = UIColor.whiteColor()
            label.clipsToBounds = true
            label.layer.cornerRadius = 5
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.orangeColor().CGColor
            label.text = title
            label.textAlignment = .Center
        }
        stackView4.whc_StartLayout()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
