//
//  MyCell.swift
//  WHC_AutoLayoutKit(Swift)
//
//  Created by WHC on 16/7/10.
//  Copyright © 2016年 WHC. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell , UITableViewDataSource, UITableViewDelegate {

    private let myImage = UILabel()
    private let title = UILabel()
    private let content = UILabel()
    private let tableView = UITableView()
    private var other: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
        self.contentView.addSubview(myImage)
        self.contentView.addSubview(title)
        self.contentView.addSubview(content)
        self.contentView.addSubview(tableView)
        
        title.text = "WHC";
        myImage.textAlignment = .Center
        myImage.backgroundColor = UIColor.orangeColor()
        
        // 添加约束
        title.whc_AutoWidth(left: 10, top: 0, right: 10, height: 30)
        myImage.whc_Left(10).whc_Top(10, toView: title).whc_Size(40, height: 40)
        content.whc_Top(10, toView: title).whc_Left(10, toView: myImage).whc_Right(10).whc_HeightAuto()

        tableView.whc_Top(10, toView: content).whc_LeftEqual(myImage).whc_Right(10).whc_Height(44)
        
        // 设置cell子视图内容与底部间隙
        self.whc_CellBottomOffset = 10
        self.whc_CellTableView = tableView

        
    }
    
    func setContent(content: String, index: Int) -> Void {
        self.content.text = content
        myImage.text = String(index)
        tableView.reloadData()
        tableView.whc_Height(tableView.contentSize.height)
        if index < 5 {
            if other == nil {
                other = UILabel()
                other.backgroundColor = UIColor.magentaColor()
            }
            other.text = content
            if !self.contentView.subviews.contains(other) {
                self.contentView.addSubview(other)
                // 添加约束
                other.whc_Top(10, toView: tableView)
                     .whc_Left(10, toView: myImage)
                     .whc_Right(10).whc_HeightAuto()
            }
            self.whc_CellBottomView = other
        }else {
            if other != nil && self.contentView.subviews.contains(other) {
                other.removeFromSuperview()
            }
            self.whc_CellBottomView = tableView
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "WHC_AutoLayout"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = "cell嵌套tableView演示"
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

}
