//
//  ViewController.swift
//  WHC_AutoLayoutKit(Swift)
//
//  Created by WHC on 16/7/8.
//  Copyright © 2016年 WHC. All rights reserved.
//

/*
 *  iOS技术交流群:490149447
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit
 */

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    fileprivate let tableView = UITableView()
    fileprivate let contents = ["AutoLayout示例","UIStackView示例","自动计算cell高度示例","动态修改XIB约束"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "WHC_AutoLayoutKit"
        self.view.addSubview(tableView)
        
        // 使用WHC_AutoLayout 添加约束
        
        // 添加约束方式1
//        tableView.whc_AutoSize(left: 0, top: 0, right: 0, bottom: 0)
        
        // 添加约束方式2
        tableView.whc_Left(0).whc_Top(0).whc_Right(0).whc_Bottom(0)
        
        tableView.delegate =  self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "WHC_AutoLayout"
        let row = (indexPath as NSIndexPath).row
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = contents[row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController!
        switch (indexPath as NSIndexPath).row {
        case 0:// AutoLayout示例
            vc = AutoLayoutVC()
        case 1:// UIStackView示例
            vc = StackViewVC()
        case 2:// 自动计算cell高度示例
            vc = AutoCellHeightVC()
        case 3:// 修改xib约束
            vc = ModityXibVC(nibName: "ModityXibVC", bundle: nil)
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

