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

extension UITextField {
    open override class func initialize() {
        struct WHC_TextFieldLoad {
            static var token: Int = 0
        }
        if WHC_TextFieldLoad.token == 0 {
            WHC_TextFieldLoad.token = 1
            let editingRectForBounds = class_getInstanceMethod(self, #selector(UITextField.editingRect(forBounds:)))
            let myEditingRectForBounds = class_getInstanceMethod(self, #selector(UITextField.myEditingRectForBounds(_:)))
            method_exchangeImplementations(editingRectForBounds, myEditingRectForBounds)
            
            let textRectForBounds =  class_getInstanceMethod(self, #selector(UITextField.textRect(forBounds:)))
            let myTextRectForBounds =  class_getInstanceMethod(self, #selector(UITextField.myTextRectForBounds(_:)))
            method_exchangeImplementations(textRectForBounds, myTextRectForBounds)
        }
    }
    
    /// 文字左边距
    public var whc_LeftPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldLeftPadding, NSNumber(value: Float(newValue) as Float), .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldLeftPadding)
            if value != nil {
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    /// 文字右边距
    public var whc_RightPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldRightPadding, NSNumber(value: Float(newValue) as Float), .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldRightPadding)
            if value != nil {
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    /// 文字顶边距
    public var whc_TopPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldTopPadding, NSNumber(value: Float(newValue) as Float), .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldTopPadding)
            if value != nil {
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    /// 文字底边距
    public var whc_BottomPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldBottomPadding, NSNumber(value: Float(newValue) as Float), .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldBottomPadding)
            if value != nil {
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    @objc fileprivate func myEditingRectForBounds(_ bounds: CGRect) -> CGRect {
        
        return self.myEditingRectForBounds(CGRect(x: self.whc_LeftPadding, y: self.whc_TopPadding, width: bounds.width - self.whc_LeftPadding - self.whc_RightPadding, height: bounds.height - whc_TopPadding - whc_BottomPadding))
    }
    
    @objc fileprivate func myTextRectForBounds(_ bounds: CGRect) -> CGRect {
        return self.myTextRectForBounds(CGRect(x: self.whc_LeftPadding, y: self.whc_TopPadding, width: bounds.width - self.whc_LeftPadding - self.whc_RightPadding, height: bounds.height - whc_TopPadding - whc_BottomPadding))
    }
    
}


extension UIButton {
    
    fileprivate func calcTextSize() -> CGSize {
        if self.titleLabel?.text != nil {
            let value = (self.titleLabel?.text!)! as NSString
            return value.size(attributes: [NSFontAttributeName: (self.titleLabel?.font)!])
        }
        return CGSize.zero
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
    
    /// 文字左边距
    public var whc_LeftPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kLeftPadding, NSNumber(value: Float(newValue) as Float), .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kLeftPadding)
            if value != nil {
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    /// 文字右边距
    public var whc_RightPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kRightPadding, NSNumber(value: Float(newValue) as Float), .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kRightPadding)
            if value != nil {
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    /// 文字顶边距
    public var whc_TopPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kTopPadding, NSNumber(value: Float(newValue) as Float), .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kTopPadding)
            if value != nil {
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    /// 文字底边距
    public var whc_BottomPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kBottomPadding, NSNumber(value: Float(newValue) as Float), .OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kBottomPadding)
            if value != nil {
                return CGFloat((value as! NSNumber).floatValue)
            }
            return 0
        }
    }
    
    open override class func initialize() {
        struct WHC_LabelLoad {
            static var token: Int = 0
        }
        if WHC_LabelLoad.token == 0 {
            WHC_LabelLoad.token = 1
            let drawTextInRect = class_getInstanceMethod(self, #selector(UILabel.drawText(in:)))
            let myDrawTextInRect = class_getInstanceMethod(self, #selector(UILabel.myDrawText(in:)))
            method_exchangeImplementations(drawTextInRect, myDrawTextInRect)
        }
    }
    
    fileprivate func calcTextSize() -> CGSize {
        if self.text != nil {
            let value = self.text! as NSString
            return value.size(attributes: [NSFontAttributeName: self.font])
        }
        return CGSize.zero
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
    
    @objc fileprivate func myDrawText(in rect: CGRect) {
        self.myDrawText(in: UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(whc_TopPadding, whc_LeftPadding, whc_BottomPadding, whc_RightPadding)))
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
    case vertical
    /// StackView横向布局
    case horizontal
    /// StackView垂直横向混合布局
    case all
}

open class WHC_StackView: UIView {

    class WHC_VacntView: UIView {
        
    }
    
    fileprivate var lastRowVacantCount = 0
    fileprivate var autoHeight = false
    fileprivate var autoWidth = false
    
    /// StackView列数
    open var whc_Column = 0
    /// StackView内边距
    open var whc_Edge = UIEdgeInsets.zero
    /// StackView子视图横向间隙
    open var whc_HSpace = CGFloat(0)
    /// StackView子视图垂直间隙
    open var whc_VSpace = CGFloat(0)
    /// StackView子视图高宽比(目前只针对图片视图)
    open var whc_HeightWidthRatio = CGFloat(0)
    /// StackView子视图个数
    open var whc_SubViewCount: Int {
        if self.whc_Orientation == .all {
            return self.subviews.count - lastRowVacantCount
        }
        return self.subviews.count
    }
    
    open var whc_Orientation = WHC_LayoutOrientationOptions.horizontal
    
    open override func whc_WidthAuto() -> UIView {
        autoWidth = true
        return super.whc_WidthAuto()
    }
    
    open override func whc_HeightAuto() -> UIView {
        autoHeight = true
        return super.whc_HeightAuto()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 开始布局
    open func whc_StartLayout() {
        runStackLayoutEngine()
    }
    
    fileprivate func runStackLayoutEngine() {
        var currentSubViews = self.subviews
        var count = currentSubViews.count
        if count == 0 {
            return
        }
        var toView: UIView!
        switch whc_Orientation {
        case .horizontal:
            for i in 0 ..< count {
                let view = currentSubViews[i]
                let nextView: UIView! = i < count - 1 ? currentSubViews[i + 1] : nil
                if i == 0 {
                    view.whc_Left(whc_Edge.left).whc_Top(whc_Edge.top)
                }else {
                    view.whc_Left(whc_HSpace, toView: toView).whc_Top(whc_Edge.top)
                }
                if nextView != nil {
                    if autoHeight {
                        view.whc_HeightAuto()
                    }else {
                        view.whc_Bottom(whc_Edge.bottom)
                    }
                    if autoWidth {
                        view.whc_WidthAuto()
                    }else {
                        view.whc_WidthEqual(nextView, ratio: view.whc_WidthWeight / nextView.whc_WidthWeight)
                    }
                }else {
                    if autoHeight {
                        view.whc_HeightAuto()
                        .whc_Bottom(whc_Edge.bottom, keepHeightConstraint: true)
                    }else {
                        view.whc_Bottom(whc_Edge.bottom)
                    }
                    if autoWidth {
                        view.whc_WidthAuto()
                        .whc_Right(whc_Edge.right, keepWidthConstraint: true)
                    }else {
                        view.whc_Right(whc_Edge.right)
                    }
                }
                toView = view
                if toView is WHC_StackView {
                    (toView as! WHC_StackView).whc_StartLayout()
                }
            }
        case .vertical:
            for i in 0 ..< count {
                let view = currentSubViews[i]
                let nextView: UIView! = i < count - 1 ? currentSubViews[i + 1] : nil
                if i == 0 {
                    view.whc_Left(whc_Edge.left).whc_Top(whc_Edge.top)
                }else {
                    view.whc_Left(whc_Edge.left).whc_Top(whc_VSpace, toView: toView)
                }
                if nextView != nil {
                    if autoWidth {
                        view.whc_WidthAuto()
                    }else {
                        view.whc_Right(whc_Edge.right)
                    }
                    if autoHeight {
                        view.whc_HeightAuto()
                    }else {
                        view.whc_HeightEqual(nextView, ratio: view.whc_HeightWeight / nextView.whc_HeightWeight)
                    }
                }else {
                    if autoWidth {
                        view.whc_WidthAuto()
                        .whc_Right(whc_Edge.right, keepWidthConstraint: true)
                    }else {
                        view.whc_Right(whc_Edge.right)
                    }
                    if autoHeight {
                        view.whc_HeightAuto()
                        .whc_Bottom(whc_Edge.bottom, keepHeightConstraint: true)
                    }else {
                        view.whc_Bottom(whc_Edge.bottom)
                    }
                }
                toView = view
                if toView is WHC_StackView {
                    (toView as! WHC_StackView).whc_StartLayout()
                }
            }
        case .all:
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
                        if autoHeight {
                            view.whc_HeightAuto()
                        }else {
                            view.whc_HeightEqual(nextRowView, ratio: view.whc_HeightWeight / nextRowView.whc_HeightWeight)
                        }
                    }else {
                        if autoHeight {
                            view.whc_HeightAuto()
                            .whc_Bottom(whc_Edge.bottom, keepHeightConstraint: true)
                        }else {
                            view.whc_Bottom(whc_Edge.bottom)
                        }
                    }
                    if nextColumnView != nil {
                        if autoWidth {
                            view.whc_WidthAuto()
                        }else {
                            view.whc_WidthEqual(nextColumnView, ratio: view.whc_WidthWeight / nextColumnView.whc_WidthWeight)
                        }
                    }else {
                        if autoWidth {
                            view.whc_WidthAuto()
                            .whc_Right(whc_Edge.right, keepWidthConstraint: true)
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
