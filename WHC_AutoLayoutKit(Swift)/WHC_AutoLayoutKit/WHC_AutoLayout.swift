//
//  WHC_AutoLayout.swift
//  WHC_AutoLayoutExample
//
//  Created by WHC on 16/7/4.
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



extension UIView {

    struct WHC_AssociatedObjectKey {
        static var kRightConstraint        = "rightConstraint"
        static var kBottomConstraint       = "bottomConstraint"
        static var kEquelWidthConstraint   = "equelWidthConstraint"
        static var kAutoWidthConstraint    = "autoWidthConstraint"
        static var kSelfWidthConstraint    = "selfWidthConstraint"
        static var kEquelHeightConstraint  = "equelHeightConstraint"
        static var kAutoHeightConstraint   = "autoHeightConstraint"
        static var kSelfHeightConstraint   = "selfHeightConstraint"
        static var kWidthWeight            = "widthWeight"
        static var kHeightWeight           = "heightWeight"
        static var kCellBottomOffset       = "cellBottomOffset"
        static var kCellBottomView         = "cellBottomView"
        static var kCellBottomViews        = "cellBottomViews"
        static var kCellTableView          = "cellTableView"
        static var kIsMonitorScreen        = "isMonitorScreen"
        static var kCacheHeightDictionary  = "cacheHeightDictionary"
        static var kLeftPadding            = "leftPadding"
        static var kRightPadding           = "rightPadding"
        static var kTopPadding             = "topPadding"
        static var kBottomPadding          = "bottomPadding"
    }
    
    public override class func initialize() {
        struct WHC_AutoLayoutLoad {
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&WHC_AutoLayoutLoad.token) {
            let addConstraint = class_getInstanceMethod(self, #selector(UIView.addConstraint(_:)))
            let whc_AddConstraint = class_getInstanceMethod(self, #selector(UIView.whc_AddConstraint(_:)))
            method_exchangeImplementations(addConstraint, whc_AddConstraint)
        }
    }
    
    //MARK: -自动布局公开接口api-
    
    /**
     * 说明: 自动计算UIScrollView的ContentSize
     */
    
    public func whc_AutoContentSize() {
        if self is UIScrollView {
            let subViewArray = subviews
            self.layoutIfNeeded()
            var contentHeight: CGFloat = 0
            var contentWidth: CGFloat = 0
            if subViewArray.count > 0 {
                let bottomView = subViewArray[0]
                for i in 0...subViewArray.count - 1 {
                    let view = subViewArray[i]
                    if CGRectGetMaxY(bottomView.frame) < CGRectGetMaxY(view.frame) {
                        contentHeight = CGRectGetMaxY(view.frame)
                    }
                    if CGRectGetMaxX(bottomView.frame) < CGRectGetMaxX(view.frame) {
                        contentWidth = CGRectGetMaxX(view.frame)
                    }
                }
                (self as! UIScrollView).contentSize = CGSizeMake(contentWidth, contentHeight)
            }
        }else {
            print("whc_AutoContentSize 只对UIScrollview有效")
        }
    }
    
    /**
     * 说明:设置左边距(默认相对父视图)
     * @param space: 左边距
     * @return 返回当前视图
     */
    
    public func whc_Left(space: CGFloat) -> UIView {
        self.constraintWithItem(self.superview, attribute: .Left, constant: space)
        return self
    }
    
    /**
     * 说明:设置左边距
     * @param space: 左边距
     * @param toView: 相对参考视图
     * @return 返回当前视图
     */
    
    public func whc_Left(space: CGFloat, toView: UIView!) -> UIView {
        var toAttribute = NSLayoutAttribute.Right
        self.constraintWithItem(self, attribute: .Left, related: .Equal, toItem: toView, toAttribute: &toAttribute, multiplier: 1, constant: space)
        return self
    }
    
    /**
     * 说明：设置左边距相等
     * @param view 左边距相等视图
     * @return 返回当前视图
     */
    
    public func whc_LeftEqual(view: UIView) -> UIView {
        var toAttribute = NSLayoutAttribute.Left
        self.constraintWithItem(self, attribute: .Left, related: .Equal, toItem: view, toAttribute: &toAttribute, multiplier: 1, constant: 0)
        return self
    }
    
    /**
     * 说明:设置右边距(默认相对父视图)
     * @param space: 右边距
     * @return 返回当前视图
     */
    
    public func whc_Right(space: CGFloat) -> UIView {
        self.constraintWithItem(self.superview, attribute: .Right, constant: 0 - space)
        return self
    }
    
    /**
     * 说明:设置右边距
     * @param space: 右边距
     * @param toView: 设置右边距参考视图
     * @return 返回当前视图
     */
    
    public func whc_Right(space: CGFloat, toView: UIView!) -> UIView {
        var toAttribute = NSLayoutAttribute.Right
        self.constraintWithItem(self, attribute: .Right, related: .Equal, toItem: toView, toAttribute: &toAttribute, multiplier: 1, constant: 0 - space)
        return self
    }
    
    /**
     * 说明: 设置右边距相等
     * @param view 右边距相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_RightEqual(view: UIView) -> UIView {
        var toAttribute = NSLayoutAttribute.Right
        self.constraintWithItem(self, attribute: .Right, related: .Equal, toItem: view, toAttribute: &toAttribute, multiplier: 1, constant: 0)
        return self
    }
    
    /**
     * 说明: 设置左边距(默认相对父视图)
     * @param leading 左边距
     * @return 返回当前视图
     */
    
    public func whc_Leading(space: CGFloat) -> UIView {
        self.constraintWithItem(self.superview, attribute: .Leading, constant: space)
        return self
    }
    
    /**
     * 说明：设置左边距
     * @param leading 左边距
     * @param toView 左边距相对参考视图
     * @return 返回当前视图
     */
    
    public func whc_Leading(space: CGFloat, toView: UIView!) -> UIView {
        var toAttribute = NSLayoutAttribute.Trailing
        self.constraintWithItem(self, attribute: .Leading, related: .Equal, toItem: toView, toAttribute: &toAttribute, multiplier: 1, constant: space)
        return self
    }
    
    /**
     * 说明：设置左边距相等
     * @param view 左边距相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_LeadingEqual(view: UIView) -> UIView {
        var toAttribute = NSLayoutAttribute.Leading
        self.constraintWithItem(self, attribute: .Leading, related: .Equal, toItem: view, toAttribute: &toAttribute, multiplier: 1, constant: 0)
        return self
    }
    
    /**
     * 说明: 设置右对齐(默认相对父视图)
     * @param trailing 右边距
     * @return 返回当前视图
     */
    
    public func whc_Trailing(space: CGFloat) -> UIView {
        self.constraintWithItem(self.superview, attribute: .Trailing, constant: space)
        return self
    }
    
    /**
     * 说明：设置右对齐
     * @param trailing 右边距
     * @param toView 右边距相对视图
     * @return 返回当前视图
     */
    
    public func whc_Trailing(space: CGFloat, toView: UIView!) -> UIView {
        var toAttribute = NSLayoutAttribute.Leading
        self.constraintWithItem(self, attribute: .Trailing, related: .Equal, toItem: toView, toAttribute: &toAttribute, multiplier: 1, constant: 0 - space)
        return self
    }
    
    /**
     * 说明：设置右对齐相等
     * @param view 右对齐相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_TrailingEqual(view: UIView) -> UIView {
        var toAttribute = NSLayoutAttribute.Trailing
        self.constraintWithItem(self, attribute: .Trailing, related: .Equal, toItem: view, toAttribute: &toAttribute, multiplier: 1, constant: 0)
        return self
    }
    
    /**
     * 说明:设置顶边距(默认相对父视图)
     * @param top: 顶边距
     * @return 返回当前视图
     */
    
    public func whc_Top(space: CGFloat) -> UIView {
        self.constraintWithItem(self.superview, attribute: .Top, constant: space)
        return self
    }
    
    /**
     * 说明:设置顶边距
     * @param top: 顶边距
     * @param toView: 顶边距相对参考视图
     * @return 返回当前视图
     */
    
    public func whc_Top(space: CGFloat, toView: UIView!) -> UIView {
        var toAttribute = NSLayoutAttribute.Bottom
        self.constraintWithItem(self, attribute: .Top, related: .Equal, toItem: toView, toAttribute: &toAttribute, multiplier: 1, constant: space)
        return self
    }
    
    /**
     * 说明：设置顶边距相等
     * @param view 顶边距相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_TopEqual(view: UIView) -> UIView {
        var toAttribute = NSLayoutAttribute.Top
        self.constraintWithItem(self, attribute: .Top, related: .Equal, toItem: view, toAttribute: &toAttribute, multiplier: 1, constant: 0)
        return self
    }
    
    /**
     * 说明:设置底边距(默认相对父视图)
     * @param bottom: 底边距
     * @return 返回当前视图
     */
    
    public func whc_Bottom(space: CGFloat) -> UIView {
        self.constraintWithItem(self.superview, attribute: .Bottom, constant: 0 - space)
        return self
    }
    
    /**
     * 说明:设置底边距
     * @param bottom: 底边距
     * @param toView: 底边距相对参考视图
     * @return 返回当前视图
     */
    
    public func whc_Bottom(space: CGFloat, toView: UIView!) -> UIView {
        var toAttribute = NSLayoutAttribute.Bottom
        self.constraintWithItem(self, attribute: .Bottom, related: .Equal, toItem: toView, toAttribute: &toAttribute, multiplier: 1, constant: 0 - space)
        return self
    }
    
    /**
     * 说明：设置底边距相等
     * @param view 底边距相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_BottomEqual(view: UIView) -> UIView {
        var toAttribute = NSLayoutAttribute.Bottom
        self.constraintWithItem(self, attribute: .Bottom, related: .Equal, toItem: view, toAttribute: &toAttribute, multiplier: 1, constant: 0)
        return self
    }
    
    /**
     * 说明:设置宽度
     * @param width: 宽度
     * @return 返回当前视图
     */
    
    public func whc_Width(width: CGFloat) -> UIView {
        var toAttribute = NSLayoutAttribute.NotAnAttribute
        self.constraintWithItem(self, attribute: .Width, related: .Equal, toItem: nil, toAttribute: &toAttribute, multiplier: 0, constant: width)
        return self
    }
    
    /**
     * 说明:设置宽度相等
     * @param view: 宽度相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_WidthEqual(view: UIView!) -> UIView {
        self.constraintWithItem(view, attribute: .Width, constant: 0)
        return self
    }
    
    /**
     * 说明:设置宽度相等
     * @param ratio: 宽度相等比例
     * @param view: 宽度相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_WidthEqual(view: UIView!, ratio: CGFloat) -> UIView {
        self.constraintWithItem(view, attribute: .Width, multiplier: ratio, constant: 0)
        return self
    }
    
    /**
     * 说明:设置自动宽度
     * @return 返回当前视图
     */
    
    public func whc_WidthAuto() -> UIView {
        if self is UILabel {
            let selfLabel = self as! UILabel
            if selfLabel.numberOfLines == 0 {
                selfLabel.numberOfLines = 1
            }
        }
        var toAttribute = NSLayoutAttribute.NotAnAttribute
        self.constraintWithItem(self, attribute: .Width, related: .GreaterThanOrEqual, toItem: nil, toAttribute: &toAttribute, multiplier: 1, constant: 0)
        return self
    }
    
    /**
     * 说明:设置高度
     * @param height: 高度
     * @return 返回当前视图
     */
    
    public func whc_Height(height: CGFloat) -> UIView {
        self.constraintWithItem(nil, attribute: .Height, constant: height)
        return self
    }
    
    /**
     * 说明:设置高度相等
     * @param view: 高度相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_HeightEqual(view: UIView!) -> UIView {
        self.constraintWithItem(view, attribute: .Height, constant: 0)
        return self
    }
    
    /**
     * 说明:设置高度相等
     * @param ratio: 高度相等比例
     * @param view: 高度相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_HeightEqual(view: UIView!, ratio: CGFloat) -> UIView {
        self.constraintWithItem(view, attribute: .Height, multiplier: ratio, constant: 0)
        return self
    }

    /**
     * 说明:设置自动高度
     * @return 返回当前视图
     */
    
    public func whc_HeightAuto() -> UIView {
        if self is UILabel {
            let selfLabel = self as! UILabel
            if selfLabel.numberOfLines != 0 {
                selfLabel.numberOfLines = 0
            }
        }
        var toAttribute = NSLayoutAttribute.NotAnAttribute
        self.constraintWithItem(self, attribute: .Height, related: .GreaterThanOrEqual, toItem: nil, toAttribute: &toAttribute, multiplier: 1, constant: 0)
        return self
    }
    
    /**
     * 说明:设置中心x(默认相对父视图)
     * @param centerX: 中心x偏移量
     * @return 返回当前视图
     */
    
    public func whc_CenterX(x: CGFloat) -> UIView {
        self.constraintWithItem(self.superview, attribute: .CenterX, constant: x)
        return self
    }
    
    /**
     * 说明:设置中心x相等
     * @param view 中心x相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_CenterXEqual(view: UIView!) -> UIView {
        self.constraintWithItem(view, attribute: .CenterX, constant: 0)
        return self
    }
    
    /**
     * 说明:设置中心x相等
     * @param view 中心x相等参考视图
     * @param offset 中心x偏移量
     * @return 返回当前视图
     */
    
    public func whc_CenterXEqual(view: UIView, offset: CGFloat) -> UIView {
        self.constraintWithItem(view, attribute: .CenterX, constant: offset)
        return self
    }
    
    /**
     * 说明:设置中心x与相对视图中心的偏移 centerX = 0 与相对视图中心x重合
     * @param centerX: 中心x坐标偏移
     * @param toView: 相对参考视图
     * @return 返回当前视图
     */
    
    public func whc_CenterX(x: CGFloat, toView: UIView!) -> UIView {
        self.constraintWithItem(toView, attribute: .CenterX, constant: x)
        return self
    }
    
    /**
     * 说明:设置中心y偏移(默认相对父视图)
     * @param centerY: 中心y坐标偏移量
     * @return 返回当前视图
     */
    
    public func whc_CenterY(y: CGFloat) -> UIView {
        self.constraintWithItem(self.superview, attribute: .CenterX, constant: y)
        return self
    }
    
    /**
     * 说明:设置中心y相等
     * @param view 相等参考视图
     * @return 返回当前视图
     */
    public func whc_CenterYEqual(view: UIView!) -> UIView {
        self.constraintWithItem(view, attribute: .CenterY, constant: 0)
        return self
    }
    
    /**
     * 说明: 设置中心y相等
     * @param view 相等参考视图
     * @param offset 偏移量
     * @return 返回当前视图
     */
    
    public func whc_CenterYEqual(view: UIView!, offset: CGFloat) -> UIView {
        self.constraintWithItem(view, attribute: .CenterY, constant: offset)
        return self
    }
    
    /**
     * 说明:设置中心y与相对视图中心的偏移 centerY = 0 与相对视图中心y重合
     * @param y: 中心y坐标偏移
     * @param toView: 相对参考视图
     * @return 返回当前视图
     */
    
    public func whc_CenterY(y: CGFloat, toView: UIView!) -> UIView {
        self.constraintWithItem(toView, attribute: .CenterX, constant: y)
        return self
    }
    
    /**
     * 说明:设置基线边距(默认相对父视图,相当于y)
     * @param space: 底部偏移量
     * @return 返回当前视图
     */
    
    public func whc_BaseLine(space: CGFloat) -> UIView {
        self.constraintWithItem(self.superview, attribute: .Baseline, constant: space)
        return self
    }
    
    /**
     * 说明:设置基线边距
     * @param space: 底部偏移
     * @param toView: 基线相对视图
     * @return 返回当前视图
     */
    
    public func whc_BaseLine(space: CGFloat, toView: UIView!) -> UIView {
        var toAttribute = NSLayoutAttribute.Top
        self.constraintWithItem(self, attribute: .Baseline, related: .Equal, toItem: toView, toAttribute: &toAttribute, multiplier: 1, constant: 0 - space)
        return self
    }
    
    /**
     * 说明:设置基线边距相等
     * @param view: 相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_BaseLineEqual(view: UIView!) -> UIView {
        self.constraintWithItem(view, attribute: .Baseline, constant: 0)
        return self
    }
    
    /**
     * 说明:设置中心偏移(默认相对父视图)x,y = 0 与父视图中心重合
     * @param x,y: 中心偏移量
     * @return 返回当前视图
     */
    
    public func whc_Center(x: CGFloat, y: CGFloat) -> UIView {
        return self.whc_CenterX(x).whc_CenterY(y)
    }
    
    /**
     * 说明:设置中心偏移(默认相对父视图)x,y = 0 与父视图中心重合
     * @param x,y: 中心偏移量
     * @param toView: 相对参考视图
     * @return 返回当前视图
     */
    
    public func whc_Center(x: CGFloat, y: CGFloat, toView: UIView!) -> UIView {
        return self.whc_CenterX(x, toView: toView).whc_CenterY(y, toView: toView)
    }
    
    /**
     * 说明:设置中心相等
     * @param view 相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_CenterEqual(view: UIView!) -> UIView {
        return self.whc_CenterXEqual(view).whc_CenterYEqual(view)
    }
    
    /**
     * 说明:设置中心相等
     * @param view 相等参考视图
     * @param offsetx 中心x偏移量
     * @param offsety 中心y偏移量
     * @return 返回当前视图
     */
    
    public func whc_CenterEqual(view: UIView!, offsetX: CGFloat, offsetY: CGFloat) -> UIView {
        return self.whc_CenterXEqual(view, offset: offsetX).whc_CenterYEqual(view, offset: offsetY)
    }
    
    /**
     * 说明:设置frame(默认相对父视图)
     * @param left 左边距
     * @param top 顶边距
     * @param width 宽度
     * @param height 高度
     * @return 返回当前视图
     */
    
    public func whc_Frame(left: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat) -> UIView {
        return self.whc_Left(left).whc_Top(top).whc_Width(width).whc_Height(height)
    }
    
    /**
     * 说明:设置frame
     * @param left 左边距
     * @param top 顶边距
     * @param width 宽度
     * @param height 高度
     * @param toView frame参考视图
     * @return 返回当前视图
     */
    
    public func whc_Frame(left: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat, toView: UIView!) -> UIView {
        return self.whc_Left(left, toView: toView).whc_Top(top, toView: toView).whc_Width(width).whc_Height(height)
    }
    
    /**
     * 说明: 设置size
     * @param width 宽度
     * @param height 高度
     * @return 返回当前视图
     */
    
    public func whc_Size(width: CGFloat, height: CGFloat) -> UIView {
        return self.whc_Width(width).whc_Height(height)
    }
    
    /**
     * 说明: 设置size相等
     * @param view size相等参考视图
     * @return 返回当前视图
     */
    
    public func whc_SizeEqual(view: UIView!) -> UIView {
        self.whc_WidthEqual(view).whc_HeightEqual(view)
        return self
    }
    
    /**
     * 说明:设置frame (默认相对父视图)
     * @param left 左边距
     * @param top 顶边距
     * @param right 右边距
     * @param bottom 底边距
     * @return 返回当前视图
     */
    
    public func whc_AutoSize(left left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) -> UIView {
        return self.whc_Left(left).whc_Top(top).whc_Right(right).whc_Bottom(bottom)
    }
    
    /**
     * 说明:设置frame
     * @param left 左边距
     * @param top 顶边距
     * @param right 右边距
     * @param bottom 底边距
     * @param toView frame参考视图
     * @return 返回当前视图
     */
    
    public func whc_AutoSize(left left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat, toView: UIView!) -> UIView {
        return self.whc_Left(left, toView: toView).whc_Top(top, toView: toView).whc_Right(right, toView: toView).whc_Bottom(bottom, toView: toView)
    }
    
    /**
     * 说明:设置frame (默认相对父视图)
     * @param left 左边距
     * @param top 顶边距
     * @param right 右边距
     * @param height 高度
     * @return 返回当前视图
     */
    
    public func whc_AutoWidth(left left: CGFloat, top: CGFloat, right: CGFloat, height: CGFloat) -> UIView {
        return self.whc_Left(left).whc_Top(top).whc_Right(right).whc_Height(height)
    }
    
    /**
     * 说明:设置frame
     * @param left 左边距
     * @param top 顶边距
     * @param right 右边距
     * @param height 高度
     * @param toView frame参考视图
     * @return 返回当前视图
     */

    public func whc_AutoWidth(left left: CGFloat, top: CGFloat, right: CGFloat, height: CGFloat, toView: UIView!) -> UIView {
        return self.whc_Left(left, toView: toView).whc_Top(top, toView: toView).whc_Right(right, toView: toView).whc_Height(height)
    }
    
    /**
     * 说明:设置frame (默认相对父视图)
     * @param left 左边距
     * @param top 顶边距
     * @param width 宽度
     * @param bottom 底边距
     * @return 返回当前视图
     */
    
    public func whc_AutoHeight(left left: CGFloat, top: CGFloat, width: CGFloat, bottom: CGFloat) -> UIView {
        return self.whc_Left(left).whc_Top(top).whc_Width(width).whc_Bottom(bottom)
    }
    
   /**
    * 说明:设置frame (默认相对父视图)
    * @param left 左边距
    * @param top 顶边距
    * @param width 宽度
    * @param bottom 底边距
    * @param toView frame参考视图
    * @return 返回当前视图
    */
    
    public func whc_AutoHeight(left left: CGFloat, top: CGFloat, width: CGFloat, bottom: CGFloat, toView: UIView!) -> UIView {
        return self.whc_Left(left, toView: toView).whc_Top(top, toView: toView).whc_Width(width).whc_Bottom(bottom, toView: toView)
    }
    
    //MARK: -私有方法-
    
    @objc private func whc_AddConstraint(constraint: NSLayoutConstraint) {
        switch constraint.firstAttribute {
        case .Height:
            if NSStringFromClass(constraint.classForCoder) == "NSContentSizeLayoutConstraint" {
                for selfConstraint in self.constraints {
                    if selfConstraint.firstAttribute == .Height &&
                        selfConstraint.relation == .Equal {
                        return
                    }
                }
                self.whc_AddConstraint(constraint)
                return
            }else {
                switch constraint.relation {
                case .Equal:
                    if constraint.secondItem == nil {
                        self.setSelfHeightConstraint(constraint)
                    }else {
                        (constraint.firstItem as! UIView).setEquelHeightConstraint(constraint)
                    }
                case .GreaterThanOrEqual:
                    self.setAutoHeightConstraint(constraint)
                default:
                    break
                }
            }
        case .Width:
            if NSStringFromClass(constraint.classForCoder) == "NSContentSizeLayoutConstraint" {
                for selfConstraint in self.constraints {
                    if selfConstraint.firstAttribute == .Width &&
                        selfConstraint.relation == .Equal {
                        return
                    }
                }
                self.whc_AddConstraint(constraint)
                return
            }else {
                switch constraint.relation {
                case .Equal:
                    if constraint.secondItem == nil {
                        self.setSelfWidthConstraint(constraint)
                    }else {
                        (constraint.firstItem as! UIView).setEquelWidthConstraint(constraint)
                    }
                case .GreaterThanOrEqual:
                    self.setAutoWidthConstraint(constraint)
                default:
                    break
                }
            }
        case .Right:
            (constraint.firstItem as! UIView).setRightConstraint(constraint)
        case .Bottom:
            (constraint.firstItem as! UIView).setBottomConstraint(constraint)
        default:
            break
        }
        self.whc_AddConstraint(constraint)
    }
    
    private func setRightConstraint(constraint: NSLayoutConstraint!) {
        objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kRightConstraint, constraint, .OBJC_ASSOCIATION_RETAIN)
    }
    
    private func rightConstraint() -> NSLayoutConstraint! {
        return objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kRightConstraint) as? NSLayoutConstraint
    }

    private func setBottomConstraint(constraint: NSLayoutConstraint!) {
        objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kBottomConstraint, constraint, .OBJC_ASSOCIATION_RETAIN)
    }
    
    private func bottomConstraint() -> NSLayoutConstraint! {
        return objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kBottomConstraint) as? NSLayoutConstraint
    }

    private func setEquelWidthConstraint(constraint: NSLayoutConstraint!) {
        objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kEquelWidthConstraint, constraint, .OBJC_ASSOCIATION_RETAIN)
    }

    private func equelWidthConstraint() -> NSLayoutConstraint! {
        return objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kEquelWidthConstraint) as? NSLayoutConstraint
    }

    private func setAutoWidthConstraint(constraint: NSLayoutConstraint!) {
        objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kAutoWidthConstraint, constraint, .OBJC_ASSOCIATION_RETAIN)
    }

    private func autoWidthConstraint() -> NSLayoutConstraint! {
        return objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kAutoWidthConstraint) as? NSLayoutConstraint
    }
 
    private func setSelfWidthConstraint(constraint: NSLayoutConstraint!) {
        objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kSelfWidthConstraint, constraint, .OBJC_ASSOCIATION_RETAIN)
    }
    
    private func selfWidthConstraint() -> NSLayoutConstraint! {
        return objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kSelfWidthConstraint) as? NSLayoutConstraint
    }
    
    private func setEquelHeightConstraint(constraint: NSLayoutConstraint!) {
        objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kEquelHeightConstraint, constraint, .OBJC_ASSOCIATION_RETAIN)
    }

    private func equelHeightConstraint() -> NSLayoutConstraint! {
        return objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kEquelHeightConstraint) as? NSLayoutConstraint
    }
    
    private func setAutoHeightConstraint(constraint: NSLayoutConstraint!) {
        objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kAutoHeightConstraint, constraint, .OBJC_ASSOCIATION_RETAIN)
    }

    private func autoHeightConstraint() -> NSLayoutConstraint! {
        return objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kAutoHeightConstraint) as? NSLayoutConstraint
    }
    
    private func setSelfHeightConstraint(constraint: NSLayoutConstraint!) {
        objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kSelfHeightConstraint, constraint, .OBJC_ASSOCIATION_RETAIN)
    }

    private func selfHeightConstraint() -> NSLayoutConstraint! {
        return objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kSelfHeightConstraint) as? NSLayoutConstraint
    }
    
    
    private func constraintWithItem(item: UIView!,
                                    attribute: NSLayoutAttribute,
                                    constant: CGFloat) {
        var toAttribute = attribute
        self.constraintWithItem(self,
                                attribute: attribute,
                                toItem: item,
                                toAttribute: &toAttribute,
                                constant: constant)
    }
    
    private func constraintWithItem(item: UIView!,
                                    attribute: NSLayoutAttribute,
                                    multiplier: CGFloat,
                                    constant: CGFloat) {
        var toAttribute = attribute
        self.constraintWithItem(self,
                                attribute: attribute,
                                toItem: item,
                                toAttribute: &toAttribute ,
                                multiplier: multiplier,
                                constant: constant)
    }

    private func constraintWithItem(item: UIView!,
                                    attribute: NSLayoutAttribute,
                                    toItem: UIView!,
                              inout toAttribute: NSLayoutAttribute,
                                    constant: CGFloat) {
        self.constraintWithItem(item,
                                attribute: attribute,
                                toItem: toItem,
                                toAttribute: &toAttribute,
                                multiplier: 1,
                                constant: constant)
    }
    
    private func constraintWithItem(item: UIView!,
                                    attribute: NSLayoutAttribute,
                                    toItem: UIView!,
                              inout toAttribute: NSLayoutAttribute,
                                    multiplier: CGFloat,
                                    constant: CGFloat) {
        self.constraintWithItem(item,
                                attribute: attribute,
                                related: .Equal,
                                toItem: toItem,
                                toAttribute: &toAttribute,
                                multiplier: multiplier,
                                constant: constant)
    }

    private func constraintWithItem(item: UIView!,
                                    attribute: NSLayoutAttribute,
                                    related: NSLayoutRelation,
                                    toItem: UIView!,
                              inout toAttribute: NSLayoutAttribute,
                                    multiplier: CGFloat,
                                    constant: CGFloat) {
        var currentSuperView = item.superview
        if toItem != nil {
            if toItem.superview == nil {
                currentSuperView = toItem
            }else if toItem.superview !== item.superview {
                currentSuperView = toItem
            }
        }else {
            currentSuperView = item
            toAttribute = .NotAnAttribute
        }
        if self.translatesAutoresizingMaskIntoConstraints {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        if ((item?.translatesAutoresizingMaskIntoConstraints) != nil) {
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        let originConstraint = self.getOriginConstraintWithMainView(currentSuperView,
                                                                    view: item,
                                                                    attribute: attribute,
                                                                    related: related,
                                                                    toView: toItem,
                                                                    toAttribute: toAttribute,
                                                                    multiplier: multiplier,
                                                                    constant: constant)
        if originConstraint == nil {
            let constraint = NSLayoutConstraint(item: item,
                                                attribute: attribute,
                                                relatedBy: related,
                                                toItem: toItem,
                                                attribute: toAttribute,
                                                multiplier: multiplier,
                                                constant: constant)
            currentSuperView?.addConstraint(constraint)
        }else {
            if originConstraint.constant != constant {
                originConstraint.constant = constant
            }
        }
    }
    
    private func getOriginConstraintWithMainView(mainView: UIView!,
                                                 view: UIView!,
                                                 attribute: NSLayoutAttribute,
                                                 related: NSLayoutRelation,
                                                 toView: UIView!,
                                                 toAttribute: NSLayoutAttribute,
                                                 multiplier: CGFloat,
                                                 constant: CGFloat) -> NSLayoutConstraint! {
        if mainView == nil {
            print("mainView not nil")
            return nil
        }
        var originConstraint: NSLayoutConstraint! = nil
        let constraintArray = mainView.constraints
        for constraint in constraintArray {
            if constraint.firstItem === view {
                switch attribute {
                case .Left:
                    if constraint.firstAttribute == .CenterX ||
                        constraint.firstAttribute == .Leading ||
                        constraint.firstAttribute == .Trailing {
                        mainView.removeConstraint(constraint)
                    }
                case .CenterX:
                    if constraint.firstAttribute == .Left ||
                        constraint.firstAttribute == .Leading ||
                        constraint.firstAttribute == .Trailing {
                        mainView.removeConstraint(constraint)
                    }
                case .Leading:
                    if constraint.firstAttribute == .Left ||
                        constraint.firstAttribute == .CenterX ||
                        constraint.firstAttribute == .Trailing {
                        mainView.removeConstraint(constraint)
                    }
                case .Trailing:
                    if constraint.firstAttribute == .Left ||
                        constraint.firstAttribute == .CenterX ||
                        constraint.firstAttribute == .Leading {
                        mainView.removeConstraint(constraint)
                    }
                case .Top:
                    if constraint.firstAttribute == .CenterY ||
                        constraint.firstAttribute == .Baseline {
                        mainView.removeConstraint(constraint)
                    }
                case .CenterY:
                    if constraint.firstAttribute == .Top ||
                        constraint.firstAttribute == .Baseline {
                        mainView.removeConstraint(constraint)
                    }
                case .Baseline:
                    if constraint.firstAttribute == .Top ||
                        constraint.firstAttribute == .CenterY {
                        mainView.removeConstraint(constraint)
                    }
                case .Right:
                    if constraint.firstAttribute == .Width {
                        mainView.removeConstraint(constraint)
                        view.setEquelWidthConstraint(nil)
                    }
                    let selfWidthConstraint = view.selfWidthConstraint()
                    if selfWidthConstraint != nil {
                        view.removeConstraint(selfWidthConstraint)
                        view.setSelfWidthConstraint(nil)
                    }
                    let autoWidthConstraint = view.autoWidthConstraint()
                    if autoWidthConstraint != nil {
                        view.removeConstraint(autoWidthConstraint)
                        view.setAutoWidthConstraint(nil)
                    }
                case .Width:
                    let rightConstraint = view.rightConstraint()
                    if rightConstraint != nil {
                        view.superview?.removeConstraint(rightConstraint)
                        view.setRightConstraint(nil)
                    }
                    if toView == nil {
                        switch related {
                        case .Equal:
                            let equelWidthConstraint = view.equelWidthConstraint()
                            if equelWidthConstraint != nil {
                                view.superview?.removeConstraint(equelWidthConstraint)
                                view.setEquelWidthConstraint(nil)
                            }
                        default:
                            break
                        }
                    }else {
                        let selfWidthConstraint = view.selfWidthConstraint()
                        if selfWidthConstraint != nil {
                            view.removeConstraint(selfWidthConstraint)
                            view.setSelfWidthConstraint(nil)
                        }
                    }
                case .Bottom:
                    if constraint.firstAttribute == .Height {
                        mainView.removeConstraint(constraint)
                        view.setEquelHeightConstraint(nil)
                    }
                    let selfHeightConstraint = view.selfHeightConstraint()
                    if selfHeightConstraint != nil {
                        view.removeConstraint(selfHeightConstraint)
                        view.setSelfHeightConstraint(nil)
                    }
                    let autoHeightConstraint = view.autoHeightConstraint()
                    if autoHeightConstraint != nil {
                        view.removeConstraint(autoHeightConstraint)
                        view.setAutoHeightConstraint(nil)
                    }
                case .Height:
                    let bottomConstraint = view.bottomConstraint()
                    if bottomConstraint != nil {
                        view.superview?.removeConstraint(bottomConstraint)
                        view.setBottomConstraint(nil)
                    }
                    if toView != nil {
                        let selfHeightConstraint = view.selfHeightConstraint()
                        if selfHeightConstraint != nil {
                            view.removeConstraint(selfHeightConstraint)
                            view.setSelfHeightConstraint(nil)
                        }
                    }else {
                        switch related {
                        case .Equal:
                            let equelHeightConstraint = view.equelHeightConstraint()
                            if equelHeightConstraint != nil {
                                view.superview?.removeConstraint(equelHeightConstraint)
                                view.setEquelHeightConstraint(nil)
                            }
                        default:
                            break
                        }
                    }
                default:
                    break
                }
                if toView != nil {
                    if constraint.firstAttribute == attribute &&
                        constraint.secondItem === toView &&
                        constraint.secondAttribute == toAttribute {
                        if constraint.multiplier == multiplier {
                            originConstraint = constraint
                        }else {
                            mainView.removeConstraint(constraint)
                        }
                    }else if constraint.firstAttribute == attribute {
                        mainView.removeConstraint(constraint)
                    }
                }else {
                    if constraint.firstAttribute == attribute {
                        let className = NSStringFromClass(constraint.classForCoder)
                        switch related {
                        case .Equal:
                            if className == "NSLayoutConstraint" {
                                originConstraint = constraint
                            }
                        case .GreaterThanOrEqual:
                            if className == "NSContentSizeLayoutConstraint" {
                                originConstraint = constraint
                            }
                        default:
                            break
                        }
                    }
                }
            }
        }
        return originConstraint
    }
    
    class WHC_Line: UIView {
        
    }
    
    struct WHC_Tag {
        static let kLeftLine = 100000
        static let kRightLine = kLeftLine + 1
        static let kTopLine = kRightLine + 1
        static let kBottomLine = kTopLine + 1
    }
    
    private func createLineWithTag(lineTag: Int)  -> WHC_Line! {
        var line: WHC_Line!
        for view in self.subviews {
            if view is WHC_Line && view.tag == lineTag {
                line = view as! WHC_Line
                break
            }
        }
        if line == nil {
            line = WHC_Line()
            line.tag = lineTag
            self.addSubview(line)
        }
        return line
    }
    
    //MARK: -自动添加底部线和顶部线-
    
    public func whc_AddBottomLine(height: CGFloat, color: UIColor) -> UIView {
        return self.whc_AddBottomLine(height, color: color, marge: 0)
    }
    
    public func whc_AddBottomLine(height: CGFloat, color: UIColor, marge: CGFloat) -> UIView {
        let line = self.createLineWithTag(WHC_Tag.kBottomLine)
        line.backgroundColor = color
        return line.whc_Right(marge).whc_Left(marge).whc_Height(height).whc_BaseLine(height)
    }
    
    public func whc_AddTopLine(height: CGFloat, color: UIColor) -> UIView {
        return self.whc_AddTopLine(height, color: color, marge: 0)
    }
    
    public func whc_AddTopLine(height: CGFloat, color: UIColor, marge: CGFloat) -> UIView {
        let line = self.createLineWithTag(WHC_Tag.kTopLine)
        line.backgroundColor = color
        return line.whc_Right(marge).whc_Left(marge).whc_Height(height).whc_Top(0)
    }
    
}
