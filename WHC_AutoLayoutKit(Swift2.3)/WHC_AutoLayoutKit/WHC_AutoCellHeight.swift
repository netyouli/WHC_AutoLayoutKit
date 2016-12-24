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


import UIKit

extension UITableView {
    private var cacheHeightDictionary:[Int : [Int: CGFloat]]! {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCacheHeightDictionary, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kCacheHeightDictionary)
            return value as? [Int : [Int: CGFloat]]
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
            
            let deleteCell = class_getInstanceMethod(self, #selector(UITableView.deleteRowsAtIndexPaths(_:withRowAnimation:)))
            let whc_deleteCell = class_getInstanceMethod(self, #selector(UITableView.whc_DeleteRowsAtIndexPaths(_:withRowAnimation:)))
            method_exchangeImplementations(deleteCell, whc_deleteCell)
            
            
            let deleteSection = class_getInstanceMethod(self, #selector(UITableView.deleteSections(_:withRowAnimation:)))
            let whc_deleteSection = class_getInstanceMethod(self, #selector(UITableView.whc_DeleteSections(_:withRowAnimation:)))
            method_exchangeImplementations(deleteSection, whc_deleteSection)
            
            let moveSection = class_getInstanceMethod(self, #selector(UITableView.moveSection(_:toSection:)))
            let whc_moveSection = class_getInstanceMethod(self, #selector(UITableView.whc_MoveSection(_:toSection:)))
            method_exchangeImplementations(moveSection, whc_moveSection)
            
            let moveRowAtIndexPath = class_getInstanceMethod(self, #selector(UITableView.moveRowAtIndexPath(_:toIndexPath:)))
            let whc_moveRowAtIndexPath = class_getInstanceMethod(self, #selector(UITableView.whc_MoveRowAtIndexPath(_:toIndexPath:)))
            method_exchangeImplementations(moveRowAtIndexPath, whc_moveRowAtIndexPath)
            
            let insertSections = class_getInstanceMethod(self, #selector(UITableView.insertSections(_:withRowAnimation:)))
            let whc_insertSections = class_getInstanceMethod(self, #selector(UITableView.whc_InsertSections(_:withRowAnimation:)))
            method_exchangeImplementations(insertSections, whc_insertSections)
            
            let insertRowsAtIndexPaths = class_getInstanceMethod(self, #selector(UITableView.insertRowsAtIndexPaths(_:withRowAnimation:)))
            let whc_insertRowsAtIndexPaths = class_getInstanceMethod(self, #selector(UITableView.whc_InsertRowsAtIndexPaths(_:withRowAnimation:)))
            method_exchangeImplementations(insertRowsAtIndexPaths, whc_insertRowsAtIndexPaths)
        }
    }
    
    @objc private func whc_ReloadData() {
        cacheHeightDictionary?.removeAll()
        self.whc_ReloadData()
    }
    
    @objc private func whc_ReloadRowsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation: UITableViewRowAnimation) {
        if cacheHeightDictionary != nil {
            for indexPath in indexPaths {
                let sectionCacheHeightDictionary = cacheHeightDictionary[indexPath.section]
                if sectionCacheHeightDictionary != nil {
                    cacheHeightDictionary[indexPath.section]!.removeValueForKey(indexPath.row)
                }
            }
        }
        self.whc_ReloadRowsAtIndexPaths(indexPaths, withRowAnimation: withRowAnimation)
    }
    
    @objc private func whc_ReloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        if cacheHeightDictionary != nil {
            sections.enumerateIndexesUsingBlock { (idx, stop) in
                self.cacheHeightDictionary?.removeValueForKey(idx)
            }
        }
        self.whc_ReloadSections(sections, withRowAnimation: animation)
    }
    
    @objc private func whc_DeleteRowsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        if cacheHeightDictionary != nil {
            for indexPath in indexPaths {
                if cacheHeightDictionary[indexPath.section] != nil {
                    cacheHeightDictionary[indexPath.section]!.removeValueForKey(indexPath.row)
                }
            }
        }
        self.whc_DeleteRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    @objc private func whc_DeleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        if cacheHeightDictionary != nil {
            sections.enumerateIndexesUsingBlock { (idx, stop) in
                self.cacheHeightDictionary?.removeValueForKey(idx)
            }
            handleCacheHeightDictionary()
        }
        self.whc_DeleteSections(sections, withRowAnimation: animation)
    }
    
    @objc private func whc_MoveSection(section: Int, toSection newSection: Int) {
        if cacheHeightDictionary != nil {
            let sectionMap = cacheHeightDictionary[section]
            cacheHeightDictionary[section] = cacheHeightDictionary[newSection]
            cacheHeightDictionary[newSection] = sectionMap
        }
        self.whc_MoveSection(section, toSection: newSection)
    }
    
    @objc private func whc_MoveRowAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        if cacheHeightDictionary != nil {
            var indexPathMap = cacheHeightDictionary[indexPath.section]
            let indexPathHeight = indexPathMap![indexPath.row]
            
            var newIndexPathMap = cacheHeightDictionary[newIndexPath.section]
            let newIndexPathHeight = newIndexPathMap![newIndexPath.row]
            
            indexPathMap?.updateValue(newIndexPathHeight!, forKey: indexPath.row)
            newIndexPathMap?.updateValue(indexPathHeight!, forKey: newIndexPath.row)
            cacheHeightDictionary.updateValue(indexPathMap!, forKey: indexPath.section)
            cacheHeightDictionary.updateValue(newIndexPathMap!, forKey: newIndexPath.section)
        }
        self.whc_MoveRowAtIndexPath(indexPath, toIndexPath: newIndexPath)
    }
    
    @objc private func whc_InsertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        if cacheHeightDictionary != nil {
            let firstSection = sections.firstIndex
            let moveSection = cacheHeightDictionary.count
            if moveSection > firstSection {
                for section in firstSection ..< moveSection {
                    let map = cacheHeightDictionary[section]
                    if map != nil {
                        cacheHeightDictionary.removeValueForKey(section)
                        cacheHeightDictionary.updateValue(map!, forKey: section + sections.count)
                    }
                }
            }
        }
        self.whc_InsertSections(sections, withRowAnimation: animation)
    }
    
    @objc private func whc_InsertRowsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        if cacheHeightDictionary != nil {
            for indexPath in indexPaths {
                var sectionMap = cacheHeightDictionary[indexPath.section]
                if sectionMap != nil {
                    let moveRow = sectionMap!.count
                    if moveRow > indexPath.row {
                        for index in indexPath.row ..< moveRow {
                            let height = sectionMap?[index]
                            if height != nil {
                                sectionMap?.removeValueForKey(index)
                                sectionMap?.updateValue(height!, forKey: index + 1)
                            }
                        }
                        cacheHeightDictionary.updateValue(sectionMap!, forKey: indexPath.section)
                    }
                }
            }
        }
        self.whc_InsertRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    private func handleCacheHeightDictionary() {
        if cacheHeightDictionary != nil {
            let allKey = cacheHeightDictionary.keys.sort{$0 < $1}
            var frontKey = -1
            var index = 0
            for (idx, key) in allKey.enumerate() {
                if frontKey == -1 {
                    frontKey = key
                }else {
                    if key - frontKey > 1 {
                        if index == 0 {
                            index = frontKey
                        }
                        cacheHeightDictionary.updateValue(cacheHeightDictionary[key]!, forKey: allKey[index] + 1)
                        cacheHeightDictionary.removeValueForKey(key)
                        index = idx
                    }
                    frontKey = key
                }
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
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCellBottomOffset, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kCellTableViewWidth, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
    public class func whc_CellHeightForIndexPath(indexPath: NSIndexPath, tableView: UITableView) -> CGFloat {
        if tableView.cacheHeightDictionary == nil {
            tableView.cacheHeightDictionary = [Int : [Int: CGFloat]]()
        }
        var sectionCacheHeightDictionary = tableView.cacheHeightDictionary[indexPath.section]
        if sectionCacheHeightDictionary != nil {
            let cellHeight = sectionCacheHeightDictionary![indexPath.row]
            if cellHeight != nil {
                return cellHeight!
            }
        }else {
            sectionCacheHeightDictionary = [Int: CGFloat]()
            tableView.cacheHeightDictionary[indexPath.section] = sectionCacheHeightDictionary
        }
        let cell = tableView.dataSource?.tableView(tableView, cellForRowAtIndexPath: indexPath)
        if cell == nil {return 0}
        cell?.whc_CellTableView?.whc_Height((cell?.whc_CellTableView?.contentSize.height)!)
        var tableViewWidth = cell?.whc_TableViewWidth
        if tableViewWidth != nil && tableViewWidth == 0 {
            tableView.layoutIfNeeded()
            tableViewWidth = CGRectGetWidth(tableView.frame)
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
        sectionCacheHeightDictionary?.updateValue(cellHeight, forKey: indexPath.row)
        tableView.cacheHeightDictionary.updateValue(sectionCacheHeightDictionary!, forKey: indexPath.section)
        return cellHeight
    }
}

