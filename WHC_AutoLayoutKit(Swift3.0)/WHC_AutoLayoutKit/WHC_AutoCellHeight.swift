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

// VERSION:(2.6)

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


extension UITableView {
    
    fileprivate var isMonitorScreen: Bool {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kIsMonitorScreen, NSNumber(value: newValue as Bool), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kIsMonitorScreen)
            if value != nil {
                return (value as! NSNumber).boolValue
            }
            return false
        }
    }
    
    fileprivate var cacheHeightDictionary:[Int : [Int: CGFloat]]! {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCacheHeightDictionary, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kCacheHeightDictionary)
            return value as? [Int : [Int: CGFloat]]
        }
    }
    
    open override class func initialize() {
        struct WHC_TableViewLoad {
            static var token: Int = 0
        }
        if (WHC_TableViewLoad.token == 0) {
            WHC_TableViewLoad.token = 1;
            let reloadData = class_getInstanceMethod(self, #selector(UITableView.reloadData))
            let whc_ReloadData = class_getInstanceMethod(self, #selector(UITableView.whc_ReloadData))
            method_exchangeImplementations(reloadData, whc_ReloadData)
            
            let reloadDataRow = class_getInstanceMethod(self, #selector(UITableView.reloadRows(at:with:)))
            let whc_ReloadDataRow = class_getInstanceMethod(self, #selector(UITableView.whc_ReloadRowsAtIndexPaths(_:withRowAnimation:)))
            method_exchangeImplementations(reloadDataRow, whc_ReloadDataRow)
            
            let sectionReloadData = class_getInstanceMethod(self, #selector(UITableView.reloadSections(_:with:)))
            let whc_SectionReloadData = class_getInstanceMethod(self, #selector(UITableView.whc_ReloadSections(_:withRowAnimation:)))
            method_exchangeImplementations(sectionReloadData, whc_SectionReloadData)
            
            let deleteCell = class_getInstanceMethod(self, #selector(UITableView.deleteRows(at:with:)))
            let whc_deleteCell = class_getInstanceMethod(self, #selector(UITableView.whc_DeleteRowsAtIndexPaths(_:withRowAnimation:)))
            method_exchangeImplementations(deleteCell, whc_deleteCell)
            
            
            let deleteSection = class_getInstanceMethod(self, #selector(UITableView.deleteSections(_:with:)))
            let whc_deleteSection = class_getInstanceMethod(self, #selector(UITableView.whc_DeleteSections(_:withRowAnimation:)))
            method_exchangeImplementations(deleteSection, whc_deleteSection)
            
            let moveSection = class_getInstanceMethod(self, #selector(UITableView.moveSection(_:toSection:)))
            let whc_moveSection = class_getInstanceMethod(self, #selector(UITableView.whc_MoveSection(_:toSection:)))
            method_exchangeImplementations(moveSection, whc_moveSection)
            
            let moveRowAtIndexPath = class_getInstanceMethod(self, #selector(UITableView.moveRow(at:to:)))
            let whc_moveRowAtIndexPath = class_getInstanceMethod(self, #selector(UITableView.whc_MoveRowAtIndexPath(_:toIndexPath:)))
            method_exchangeImplementations(moveRowAtIndexPath, whc_moveRowAtIndexPath)
            
            let insertSections = class_getInstanceMethod(self, #selector(UITableView.self.insertSections(_:with:)))
            let whc_insertSections = class_getInstanceMethod(self, #selector(UITableView.whc_InsertSections(_:withRowAnimation:)))
            method_exchangeImplementations(insertSections, whc_insertSections)
            
            let insertRowsAtIndexPaths = class_getInstanceMethod(self, #selector(UITableView.insertRows(at:with:)))
            let whc_insertRowsAtIndexPaths = class_getInstanceMethod(self, #selector(UITableView.whc_InsertRowsAtIndexPaths(_:withRowAnimation:)))
            method_exchangeImplementations(insertRowsAtIndexPaths, whc_insertRowsAtIndexPaths)
        }
    }
    
    @objc fileprivate func whc_ReloadData() {
        cacheHeightDictionary?.removeAll()
        self.whc_ReloadData()
    }
    
    @objc fileprivate func whc_ReloadRowsAtIndexPaths(_ indexPaths: [IndexPath], withRowAnimation: UITableViewRowAnimation) {
        for indexPath in indexPaths {
            let sectionCacheHeightDictionary = cacheHeightDictionary[(indexPath as NSIndexPath).section]
            if sectionCacheHeightDictionary != nil {
                cacheHeightDictionary[(indexPath as NSIndexPath).section]!.removeValue(forKey: (indexPath as NSIndexPath).row)
            }
        }
        self.whc_ReloadRowsAtIndexPaths(indexPaths, withRowAnimation: withRowAnimation)
    }
    
    @objc fileprivate func whc_ReloadSections(_ sections: IndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        for (idx,_) in sections.enumerated() {
            let _ = self.cacheHeightDictionary?.removeValue(forKey: idx)
        }
        self.whc_ReloadSections(sections, withRowAnimation: animation)
    }
    
    @objc fileprivate func whc_DeleteRowsAtIndexPaths(_ indexPaths: [IndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        for indexPath in indexPaths {
            if cacheHeightDictionary[(indexPath as NSIndexPath).section] != nil {
                cacheHeightDictionary[(indexPath as NSIndexPath).section]!.removeValue(forKey: (indexPath as NSIndexPath).row)
            }
        }
        self.whc_DeleteRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    @objc fileprivate func whc_DeleteSections(_ sections: IndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        for (idx,_) in sections.enumerated() {
           let _ = self.cacheHeightDictionary?.removeValue(forKey: idx)
        }
        handleCacheHeightDictionary()
        self.whc_DeleteSections(sections, withRowAnimation: animation)
    }
    
    @objc fileprivate func whc_MoveSection(_ section: Int, toSection newSection: Int) {
        let sectionMap = cacheHeightDictionary[section]
        cacheHeightDictionary[section] = cacheHeightDictionary[newSection]
        cacheHeightDictionary[newSection] = sectionMap
        self.whc_MoveSection(section, toSection: newSection)
    }
    
    @objc fileprivate func whc_MoveRowAtIndexPath(_ indexPath: IndexPath, toIndexPath newIndexPath: IndexPath) {
        var indexPathMap = cacheHeightDictionary[(indexPath as NSIndexPath).section]
        let indexPathHeight = indexPathMap![(indexPath as NSIndexPath).row]
        
        var newIndexPathMap = cacheHeightDictionary[(newIndexPath as NSIndexPath).section]
        let newIndexPathHeight = newIndexPathMap![(newIndexPath as NSIndexPath).row]
        
        let _ = indexPathMap?.updateValue(newIndexPathHeight!, forKey: (indexPath as NSIndexPath).row)
        let _ = newIndexPathMap?.updateValue(indexPathHeight!, forKey: (newIndexPath as NSIndexPath).row)
        cacheHeightDictionary.updateValue(indexPathMap!, forKey: (indexPath as NSIndexPath).section)
        cacheHeightDictionary.updateValue(newIndexPathMap!, forKey: (newIndexPath as NSIndexPath).section)
        self.whc_MoveRowAtIndexPath(indexPath, toIndexPath: newIndexPath)
    }
    
    @objc fileprivate func whc_InsertSections(_ sections: IndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        let firstSection = sections.first
        let moveSection = cacheHeightDictionary.count
        if moveSection > firstSection {
            for section in firstSection! ..< moveSection {
                let map = cacheHeightDictionary[section]
                if map != nil {
                    cacheHeightDictionary.removeValue(forKey: section)
                    cacheHeightDictionary.updateValue(map!, forKey: section + sections.count)
                }
            }
        }
        self.whc_InsertSections(sections, withRowAnimation: animation)
    }
    
    @objc fileprivate func whc_InsertRowsAtIndexPaths(_ indexPaths: [IndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        for indexPath in indexPaths {
            var sectionMap = cacheHeightDictionary[(indexPath as NSIndexPath).section]
            if sectionMap != nil {
                let moveRow = sectionMap!.count
                if moveRow > (indexPath as NSIndexPath).row {
                    for index in (indexPath as NSIndexPath).row ..< moveRow {
                        let height = sectionMap?[index]
                        if height != nil {
                            let _ = sectionMap?.removeValue(forKey: index)
                            let _ = sectionMap?.updateValue(height!, forKey: index + 1)
                        }
                    }
                    cacheHeightDictionary.updateValue(sectionMap!, forKey: (indexPath as NSIndexPath).section)
                }
            }
        }
        self.whc_InsertRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    @objc fileprivate func screenWillChange(_ notification: Notification) -> Void {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64((0.1 * Double(NSEC_PER_SEC)))) / Double(NSEC_PER_SEC)) {
            self.reloadData()
        }
    }
    
    fileprivate func monitorScreenOrientation() {
        if isMonitorScreen == false {
            isMonitorScreen = true
            NotificationCenter.default.addObserver(self, selector: #selector(self.screenWillChange(_:)), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
        }
    }
    
    fileprivate func handleCacheHeightDictionary() {
        let allKey = cacheHeightDictionary.keys.sorted{$0 < $1}
        var frontKey = -1
        var index = 0
        for (idx, key) in allKey.enumerated() {
            if frontKey == -1 {
                frontKey = key
            }else {
                if key - frontKey > 1 {
                    if index == 0 {
                        index = frontKey
                    }
                    cacheHeightDictionary.updateValue(cacheHeightDictionary[key]!, forKey: allKey[index] + 1)
                    cacheHeightDictionary.removeValue(forKey: key)
                    index = idx
                }
                frontKey = key
            }
        }
    }
}

extension UITableViewCell {
    /// cell上最底部的视图
    public var whc_CellBottomView: UIView! {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCellBottomView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCellBottomViews, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCellBottomOffset, NSNumber(value: Float(newValue) as Float), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kCellBottomOffset)
            if value != nil {
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    /// cell上嵌套tableview对象
    public var whc_CellTableView: UITableView! {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCellTableView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kCellTableView)
            if value != nil {
                return value as! UITableView
            }
            return nil
        }

    }
    
    public var whc_TableViewWidth: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCellTableViewWidth, NSNumber(value: Float(newValue) as Float), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kCellTableViewWidth)
            if value != nil {
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0.0
        }
    }
    
    /**
     * 说明: 自动计算cell高度
     * @param indexPath 当前cell index
     * @param tableView 当前列表对象
     * @return cell高度
     */
    public class func whc_CellHeightForIndexPath(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        if tableView.cacheHeightDictionary == nil {
            tableView.cacheHeightDictionary = [Int : [Int: CGFloat]]()
        }
        tableView.monitorScreenOrientation()
        
        var sectionCacheHeightDictionary = tableView.cacheHeightDictionary[(indexPath as NSIndexPath).section]
        if sectionCacheHeightDictionary != nil {
            let cellHeight = sectionCacheHeightDictionary![(indexPath as NSIndexPath).row]
            if cellHeight != nil {
                return cellHeight!
            }
        }else {
            sectionCacheHeightDictionary = [Int: CGFloat]()
            tableView.cacheHeightDictionary[(indexPath as NSIndexPath).section] = sectionCacheHeightDictionary
        }
        let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath)
        if cell == nil {return 0}
        cell?.whc_CellTableView?.whc_Height((cell?.whc_CellTableView?.contentSize.height)!)
        var tableViewWidth = cell?.whc_TableViewWidth
        if tableViewWidth != nil && tableViewWidth == 0 {
            tableView.layoutIfNeeded()
            tableViewWidth = tableView.frame.width
        }
        if tableViewWidth == 0 {return 0}
        var cellFrame = cell?.frame
        var contentFrame = cell?.contentView.frame
        contentFrame?.size.width = tableViewWidth!
        cellFrame?.size.width = tableViewWidth!
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
                if bottomView.frame.maxY < view.frame.maxY {
                    bottomView = view
                }
            }
        }else {
            let cellSubViews = cell?.contentView.subviews
            if cellSubViews?.count > 0 {
                bottomView = cellSubViews![0]
                for i in 1 ..< cellSubViews!.count {
                    let view = cellSubViews![i]
                    if bottomView.frame.maxY < view.frame.maxY {
                        bottomView = view
                    }
                }
            }else {
                bottomView = cell?.contentView
            }
        }
        let cellHeight = bottomView.frame.maxY + cell!.whc_CellBottomOffset
        let _ = sectionCacheHeightDictionary?.updateValue(cellHeight, forKey: (indexPath as NSIndexPath).row)
        tableView.cacheHeightDictionary.updateValue(sectionCacheHeightDictionary!, forKey: (indexPath as NSIndexPath).section)
        return cellHeight
    }
}

