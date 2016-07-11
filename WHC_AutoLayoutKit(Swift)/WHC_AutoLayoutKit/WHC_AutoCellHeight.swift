//
//  WHC_AutoHeightCell.swift
//  WHC_AutoLayoutExample
//
//  Created by WHC on 16/7/8.
//  Copyright © 2016年 吴海超. All rights reserved.
//

//  Github <https://github.com/netyouli/WHC_AutoLayoutKit>

//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// VERSION:(2.0)

import UIKit

extension UITableView {
    
    private var isMonitorScreen: Bool {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kIsMonitorScreen, NSNumber(bool: newValue), .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kIsMonitorScreen)
            if value != nil {
                return value.boolValue
            }
            return false
        }
    }
    
    private var cacheHeightDictionary:[String : CGFloat]! {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCacheHeightDictionary, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kCacheHeightDictionary)
            return value as? [String: CGFloat]
        }
    }
    
    public override class func initialize() {
        struct WHC_TableViewLoad {
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&WHC_TableViewLoad.token) {
            let reloadData = class_getInstanceMethod(self, #selector(UITableView.reloadData))
            let whc_ReloadData = class_getInstanceMethod(self, #selector(UITableView.whc_ReloadData))
            method_exchangeImplementations(reloadData, whc_ReloadData)
            
            let reloadDataRow = class_getInstanceMethod(self, #selector(UITableView.reloadRowsAtIndexPaths(_:withRowAnimation:)))
            let whc_ReloadDataRow = class_getInstanceMethod(self, #selector(UITableView.whc_ReloadRowsAtIndexPaths(_:withRowAnimation:)))
            
            method_exchangeImplementations(reloadDataRow, whc_ReloadDataRow)
            
            let sectionReloadData = class_getInstanceMethod(self, #selector(UITableView.reloadSections(_:withRowAnimation:)))
            let whc_SectionReloadData = class_getInstanceMethod(self, #selector(UITableView.whc_ReloadSections(_:withRowAnimation:)))
            method_exchangeImplementations(sectionReloadData, whc_SectionReloadData)
        }
    }
    
    @objc private func whc_ReloadData() {
        cacheHeightDictionary?.removeAll()
        self.whc_ReloadData()
    }
    
    @objc private func whc_ReloadRowsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation: UITableViewRowAnimation) {
  
        for indexPath in indexPaths {
            let cacheHeightKey = "\(indexPath.section)-\(indexPath.row)"
            cacheHeightDictionary?.removeValueForKey(cacheHeightKey)
        }
        self.whc_ReloadRowsAtIndexPaths(indexPaths, withRowAnimation: withRowAnimation)
    }
    
    @objc private func whc_ReloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        let cacheHeightKeyArray = cacheHeightDictionary.keys
        sections.enumerateIndexesUsingBlock { (idx, stop) in
            let sectionString = "\(idx)-"
            for cacheHeightKey in cacheHeightKeyArray {
                if cacheHeightKey.containsString(sectionString) {
                    self.cacheHeightDictionary?.removeValueForKey(cacheHeightKey)
                }
            }
        }
        self.whc_ReloadSections(sections, withRowAnimation: animation)
    }
    
    @objc private func screenWillChange(notification: NSNotification) -> Void {
        self.reloadData()
    }
    
    private func monitorScreenOrientation() {
        if isMonitorScreen == false {
            isMonitorScreen = true
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.screenWillChange(_:)), name: UIApplicationDidChangeStatusBarOrientationNotification, object: nil)
        }
    }
}

extension UITableViewCell {
    /// cell上最底部的视图
    public var whc_CellBottomView: UIView! {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCellBottomView, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kCellBottomView)
            if value != nil {
                return value as! UIView
            }
            return nil
        }
    }
    
    /// cell上最底部的视图集合
    public var whc_CellBottomViews: [UIView]! {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCellBottomViews, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kCellBottomViews)
            if value != nil {
                return value as! [UIView]
            }
            return nil
        }
    }
    
    /// cell上最底部的视图与cell底部偏移量
    public var whc_CellBottomOffset: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCellBottomOffset, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kCellBottomOffset)
            if value != nil {
                return CGFloat(value.floatValue)
            }
            return 0
        }
    }
    
    /// cell上嵌套tableview对象
    public var whc_CellTableView: UITableView! {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCellTableView, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kCellTableView)
            if value != nil {
                return value as! UITableView
            }
            return nil
        }

    }
    
    /**
     * 说明: 自动计算cell高度
     * @param indexPath 当前cell index
     * @param tableView 当前列表对象
     * @return cell高度
     */
    public class func whc_CellHeightForIndexPath(indexPath: NSIndexPath, tableView: UITableView) -> CGFloat {
        if tableView.cacheHeightDictionary == nil {
            tableView.cacheHeightDictionary = [String : CGFloat]()
        }
        tableView.monitorScreenOrientation()
        let cacheHeightKey = "\(indexPath.section)-\(indexPath.row)"
        let cacheHeight = tableView.cacheHeightDictionary[cacheHeightKey]
        if cacheHeight != nil {
            return cacheHeight!
        }
        let cell = tableView.dataSource?.tableView(tableView, cellForRowAtIndexPath: indexPath)
        if cell == nil {
            return 0
        }
        cell?.whc_CellTableView?.whc_Height((cell?.whc_CellTableView?.contentSize.height)!)
        tableView.layoutIfNeeded()
        let tableViewWidth = CGRectGetWidth(tableView.frame)
        if tableViewWidth == 0 {
            return 0
        }
        var cellFrame = cell?.frame
        var contentFrame = cell?.contentView.frame
        contentFrame?.size.width = tableViewWidth
        cellFrame?.size.width = tableViewWidth
        cell?.contentView.frame = contentFrame!
        cell?.frame = cellFrame!
        cell?.layoutIfNeeded()
        var bottomView: UIView!
        if cell?.whc_CellBottomView != nil {
            bottomView = cell?.whc_CellBottomView
        }else if cell?.whc_CellBottomViews?.count > 0 {
            bottomView = cell?.whc_CellBottomViews[0]
            for i in 1 ..< cell!.whc_CellBottomViews.count {
                let view: UIView! = cell?.whc_CellBottomViews[i]
                if CGRectGetMaxY(bottomView.frame) < CGRectGetMaxY(view.frame) {
                    bottomView = view
                }
            }
        }else {
            let cellSubViews = cell?.contentView.subviews
            if cellSubViews?.count > 0 {
                bottomView = cellSubViews![0]
                for i in 1 ..< cellSubViews!.count {
                    let view = cellSubViews![i]
                    if CGRectGetMaxY(bottomView.frame) < CGRectGetMaxY(view.frame) {
                        bottomView = view
                    }
                }
            }else {
                bottomView = cell?.contentView
            }
        }
        let cellHeight = CGRectGetMaxY(bottomView.frame
        ) + cell!.whc_CellBottomOffset
        tableView.cacheHeightDictionary.updateValue(cellHeight, forKey: cacheHeightKey)
        return cellHeight
    }
}

