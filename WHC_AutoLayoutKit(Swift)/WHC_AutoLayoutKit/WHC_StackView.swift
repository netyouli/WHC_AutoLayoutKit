//
//  WHC_StackView.swift
//  WHC_AutoLayoutExample
//
//  Created by WHC on 16/7/7.
//  Copyright © 2016年 吴海超. All rights reserved.

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

extension UIButton {
    
    private func calcTextSize() -> CGSize {
        if self.titleLabel?.text != nil {
            let value = (self.titleLabel?.text!)! as NSString
            return value.sizeWithAttributes([NSFontAttributeName: (self.titleLabel?.font)!])
        }
        return CGSizeZero
    }
    
    public override func whc_WidthAuto() -> UIView {
        if self.titleEdgeInsets.left + self.titleEdgeInsets.right != 0 {
            return self.whc_Width(calcTextSize().width + self.titleEdgeInsets.left + self.titleEdgeInsets.right + 0.5)
        }
        return super.whc_WidthAuto()
    }
    
    public override func whc_HeightAuto() -> UIView {
        if self.titleEdgeInsets.top + self.titleEdgeInsets.bottom != 0 {
            return self.whc_Height(calcTextSize().height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom  + 0.5)
        }
        return super.whc_HeightAuto()
    }
    
}

extension UILabel {
    
    public override func layoutSubviews() {
        <#code#>
    }
    /// 文字左边距
    public var whc_LeftPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kLeftPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kLeftPadding)
            if value != nil {
                return CGFloat(value.floatValue)
            }
            return 0
        }
    }
    
    /// 文字右边距
    public var whc_RightPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kRightPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kRightPadding)
            if value != nil {
                return CGFloat(value.floatValue)
            }
            return 0
        }
    }
    
    /// 文字顶边距
    public var whc_TopPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kTopPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kTopPadding)
            if value != nil {
                return CGFloat(value.floatValue)
            }
            return 0
        }
    }
    
    /// 文字底边距
    public var whc_BottomPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kBottomPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kBottomPadding)
            if value != nil {
                return CGFloat(value.floatValue)
            }
            return 0
        }
    }
    
    public override class func initialize() {
        struct WHC_LabelLoad {
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&WHC_LabelLoad.token) {
            let drawTextInRect = class_getInstanceMethod(self, #selector(UILabel.drawTextInRect(_:)))
            let myDrawTextInRect = class_getInstanceMethod(self, #selector(UILabel.myDrawTextInRect(_:)))
            method_exchangeImplementations(drawTextInRect, myDrawTextInRect)
        }
    }
    
    private func calcTextSize() -> CGSize {
        if self.text != nil {
            let value = self.text! as NSString
            return value.sizeWithAttributes([NSFontAttributeName: self.font])
        }
        return CGSizeZero
    }
    
    public override func whc_WidthAuto() -> UIView {
        if whc_LeftPadding + whc_RightPadding != 0 {
            return self.whc_Width(calcTextSize().width + whc_LeftPadding + whc_RightPadding + 0.5)
        }
        return super.whc_WidthAuto()
    }
    
    public override func whc_HeightAuto() -> UIView {
        if whc_TopPadding + whc_BottomPadding != 0 {
            return self.whc_Height(calcTextSize().height + whc_TopPadding + whc_BottomPadding + 0.5)
        }
        return super.whc_HeightAuto()
    }
    
    @objc private func myDrawTextInRect(rect: CGRect) {
        self.myDrawTextInRect(UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(whc_TopPadding, whc_LeftPadding, whc_BottomPadding, whc_RightPadding)))
    }
}

extension UIView {
    /// 宽度权重
    public var whc_WidthWeight: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kWidthWeight, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            let id = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kWidthWeight) as? NSNumber
            if id != nil {
                return CGFloat(id!.floatValue)
            }
            return 1
        }
    }
    
    /// 高度权重
    public var whc_HeightWeight: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kHeightWeight, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            let id = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kHeightWeight) as? NSNumber
            if id != nil {
                return CGFloat(id!.floatValue)
            }
            return 1
        }
    }
}

public enum WHC_LayoutOrientationOptions {
    /// StackView垂直布局
    case Vertical
    /// StackView横向布局
    case Horizontal
    /// StackView垂直横向混合布局
    case All
}

public class WHC_StackView: UIView {

    class WHC_VacntView: UIView {
        
    }
    
    private var lastRowVacantCount = 0
    private var autoHeight = false
    private var autoWidth = false
    private var elementWidth = CGFloat(0)
    private var elementHeight = CGFloat(0)
    
    /// StackView列数
    public var whc_Column = 0
    /// StackView内边距
    public var whc_Edge = UIEdgeInsetsZero
    /// StackView子视图宽度自动
    public var whc_subViewWidthAuto = false
    /// StackView子视图高度自动
    public var whc_subViewHeightAuto = false
    /// StackView子视图横向间隙
    public var whc_HSpace = CGFloat(0)
    /// StackView子视图垂直间隙
    public var whc_VSpace = CGFloat(0)
    /// StackView子视图高宽比(目前只针对图片视图)
    public var whc_HeightWidthRatio = CGFloat(0)
    /// StackView子视图个数
    public var whc_SubViewCount: Int {
        if self.whc_Orientation == .All {
            return self.subviews.count - lastRowVacantCount
        }
        return self.subviews.count
    }
    
    public var whc_Orientation = WHC_LayoutOrientationOptions.Horizontal
    
    public override func whc_WidthAuto() -> UIView {
        autoWidth = true
        return super.whc_WidthAuto()
    }
    
    public override func whc_HeightAuto() -> UIView {
        autoHeight = true
        return super.whc_HeightAuto()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 开始布局
    public func whc_StartLayout() {
        if autoHeight && whc_HeightWidthRatio > 0 {
            self.layoutIfNeeded()
            let stackViewWidth = CGRectGetWidth(self.frame)
            elementWidth = (stackViewWidth - whc_HSpace * (CGFloat(max(1, whc_Column)) - 1) - whc_Edge.left - whc_Edge.right) / CGFloat(whc_Column)
            elementHeight = elementWidth * whc_HeightWidthRatio
        }
        runStackLayoutEngine()
        if autoHeight {
            if whc_HeightWidthRatio > 0 {
                let subViewCount = self.subviews.count
                if subViewCount == 0 {
                    self.whc_Height(0)
                }else {
                    let rowCount = (subViewCount / whc_Column + (subViewCount % whc_Column == 0 ? 0 : 1))
                    let stackViewHeight = elementHeight * CGFloat(rowCount) + whc_Edge.top + whc_Edge.bottom + CGFloat(rowCount + 1) * whc_VSpace
                    self.whc_Height(stackViewHeight)
                }
            }
        }
    }
    
    private func runStackLayoutEngine() {
        var currentSubViews = self.subviews
        var count = currentSubViews.count
        if count == 0 {
            return
        }
        var toView: UIView!
        switch whc_Orientation {
        case .Horizontal:
            let oneView = currentSubViews[0]
            let secondView: UIView! = (count > 1 ? currentSubViews[1] : nil)
            oneView.whc_Left(whc_Edge.left).whc_Top(whc_Edge.top)
            if whc_subViewHeightAuto {
                oneView.whc_HeightAuto()
            }else {
                oneView.whc_Bottom(whc_Edge.bottom)
            }
            if secondView != nil {
                if whc_subViewWidthAuto {
                    oneView.whc_WidthAuto()
                }else {
                    oneView.whc_WidthEqual(secondView, ratio: oneView.whc_WidthWeight / secondView.whc_WidthWeight)
                }
            }else {
                oneView.whc_Right(whc_Edge.right)
            }
            toView = oneView
            if toView is WHC_StackView {
                (toView as! WHC_StackView).whc_StartLayout()
            }
            for i in 1 ..< count {
                let view = currentSubViews[i]
                let nextView: UIView! = i < count - 1 ? currentSubViews[i + 1] : nil
                view.whc_Left(whc_HSpace, toView: toView).whc_Top(whc_Edge.top)
                if whc_subViewHeightAuto {
                    view.whc_HeightAuto()
                }else {
                    view.whc_Bottom(whc_Edge.bottom)
                }
                if nextView != nil {
                    if whc_subViewWidthAuto {
                        view.whc_WidthAuto()
                    }else {
                        view.whc_WidthEqual(nextView, ratio: view.whc_WidthWeight / nextView.whc_WidthWeight)
                    }
                }else {
                    view.whc_Right(whc_Edge.right)
                }
                toView = view
                if toView is WHC_StackView {
                    (toView as! WHC_StackView).whc_StartLayout()
                }
            }
        case .Vertical:
            let oneView = currentSubViews[0]
            let secondView: UIView! = count > 1 ? currentSubViews[1] : nil
            oneView.whc_Left(whc_Edge.left).whc_Top(whc_Edge.top)
            if whc_subViewWidthAuto {
                oneView.whc_WidthAuto()
            }else {
                oneView.whc_Right(whc_Edge.right)
            }
            if secondView != nil {
                if whc_subViewHeightAuto {
                    oneView.whc_HeightAuto()
                }else {
                    oneView.whc_HeightEqual(secondView, ratio: oneView.whc_HeightWeight / secondView.whc_HeightWeight)
                }
            }else {
                oneView.whc_Bottom(whc_Edge.bottom)
            }
            toView = oneView
            if toView is WHC_StackView {
                (toView as! WHC_StackView).whc_StartLayout()
            }
            for i in 1 ..< count {
                let view = currentSubViews[i]
                let nextView: UIView! = i < count - 1 ? currentSubViews[i + 1] : nil
                view.whc_Left(whc_Edge.left).whc_Top(whc_VSpace, toView: toView)
                if whc_subViewWidthAuto {
                    view.whc_WidthAuto()
                }else {
                    view.whc_Right(whc_Edge.right)
                }
                if nextView != nil {
                    if whc_subViewHeightAuto {
                        view.whc_HeightAuto()
                    }else {
                        view.whc_HeightEqual(nextView, ratio: view.whc_HeightWeight / nextView.whc_HeightWeight)
                    }
                }else {
                    view.whc_Bottom(whc_Edge.bottom)
                }
                toView = view
                if toView is WHC_StackView {
                    (toView as! WHC_StackView).whc_StartLayout()
                }
            }
        case .All:
            for view in self.subviews {
                if view is WHC_VacntView {
                    view.removeFromSuperview()
                }
            }
            currentSubViews = self.subviews
            count = currentSubViews.count
            let rowCount = count / whc_Column + ((count % whc_Column) == 0 ? 0 : 1)
            var index = 0
            lastRowVacantCount = rowCount * whc_Column - count
            for _ in 0 ..< lastRowVacantCount {
                let view = WHC_VacntView()
                view.backgroundColor = self.backgroundColor
                self.addSubview(view)
            }
            if lastRowVacantCount > 0 {
                currentSubViews = self.subviews
                count = currentSubViews.count
            }
            var frontRowView: UIView!
            var frontColumnView: UIView!
            for row in 0 ..< rowCount {
                var nextRowView: UIView!
                let rowView = currentSubViews[row * whc_Column]
                let nextRow = (row + 1) * whc_Column
                if nextRow < count {
                    nextRowView = currentSubViews[nextRow]
                }
                for column in 0 ..< whc_Column {
                    index = row * whc_Column + column
                    let view = currentSubViews[index]
                    var nextColumnView: UIView!
                    if column < whc_Column - 1 && index < count {
                        nextColumnView = currentSubViews[index + 1]
                    }
                    if row == 0 {
                        view.whc_Top(whc_Edge.top)
                    }else {
                        view.whc_Top(whc_VSpace, toView: frontRowView)
                    }
                    if column == 0 {
                        view.whc_Left(whc_Edge.left)
                    }else {
                        view.whc_Left(whc_HSpace, toView: frontColumnView)
                    }
                    if nextRowView != nil {
                        if autoHeight && view is UIImageView {
                            view.whc_Height(elementHeight)
                        }else {
                            view.whc_HeightEqual(nextRowView, ratio: view.whc_HeightWeight / nextRowView.whc_HeightWeight)
                        }
                    }else {
                        if autoHeight && view is UIImageView {
                            view.whc_Height(elementHeight)
                        }else {
                            view.whc_Bottom(whc_Edge.bottom)
                        }
                    }
                    if nextColumnView != nil {
                        if whc_subViewWidthAuto {
                            view.whc_WidthAuto()
                        }else {
                            view.whc_WidthEqual(nextColumnView, ratio: view.whc_WidthWeight / nextColumnView.whc_WidthWeight)
                        }
                    }else {
                        if whc_subViewWidthAuto {
                            view.whc_WidthAuto()
                        }else {
                            view.whc_Right(whc_Edge.right)
                        }
                    }
                    frontColumnView = view
                    if frontColumnView is WHC_StackView {
                        (frontColumnView as! WHC_StackView).whc_StartLayout()
                    }
                }
                frontRowView = rowView
            }
        }
    }

}
