//
//  MyCell.swift
//  WHC_AutoLayoutKit(Swift)
//
//  Created by WHC on 16/7/10.
//  Copyright © 2016年 WHC. All rights reserved.
//

/*********************************************************
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit *
 *  本人其他优秀开源库：https://github.com/netyouli          *
 *********************************************************/

import UIKit

class MyCell: UITableViewCell , UITableViewDataSource, UITableViewDelegate {

    fileprivate let myImage = UILabel()
    fileprivate let title = UILabel()
    fileprivate let content = UILabel()
    fileprivate let tableView = UITableView()
    fileprivate var other: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        self.contentView.addSubview(myImage)
        self.contentView.addSubview(title)
        self.contentView.addSubview(content)
        self.contentView.addSubview(tableView)
        
        title.text = "WHC";
        myImage.textAlignment = .center
        myImage.backgroundColor = UIColor.orange
        
        // 添加约束
        title.whc_AutoWidth(left: 10, top: 0, right: 10, height: 30)
        myImage.whc_Left(10).whc_Top(10, toView: title).whc_Size(40, height: 40)
        content.whc_Top(10, toView: title).whc_Left(10, toView: myImage).whc_Right(10).whc_HeightAuto()

        tableView.whc_Top(10, toView: content).whc_LeftEqual(myImage).whc_Right(10).whc_Height(44)
        
        // 设置cell子视图内容与底部间隙
        self.whc_CellBottomOffset = 10
        self.whc_CellTableView = tableView

        
    }
    
    func setContent(_ content: String, index: Int) -> Void {
        self.content.text = content
        myImage.text = String(index)
        tableView.reloadData()
        tableView.whc_Height(tableView.contentSize.height)
        if index < 5 {
            if other == nil {
                other = UILabel()
                other.backgroundColor = UIColor.magenta
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "WHC_AutoLayout"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = "cell嵌套tableView演示"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
