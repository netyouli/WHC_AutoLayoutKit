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


import UIKit

extension UITextField {
    public override class func initialize() {
        struct WHC_TextFieldLoad {
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&WHC_TextFieldLoad.token) {
            let editingRectForBounds = class_getInstanceMethod(self, #selector(UITextField.editingRectForBounds(_:)))
            let myEditingRectForBounds = class_getInstanceMethod(self, #selector(UITextField.myEditingRectForBounds(_:)))
            method_exchangeImplementations(editingRectForBounds, myEditingRectForBounds)
            
            let textRectForBounds =  class_getInstanceMethod(self, #selector(UITextField.textRectForBounds(_:)))
            let myTextRectForBounds =  class_getInstanceMethod(self, #selector(UITextField.myTextRectForBounds(_:)))
            method_exchangeImplementations(textRectForBounds, myTextRectForBounds)
        }
    }
    
    /// 文字左边距
    public var whc_LeftPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldLeftPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldLeftPadding)
            if value != nil {
                return CGFloat(value.floatValue)
            }
            return 0
        }
    }
    
    /// 文字右边距
    public var whc_RightPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldRightPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldRightPadding)
            if value != nil {
                return CGFloat(value.floatValue)
            }
            return 0
        }
    }
    
    /// 文字顶边距
    public var whc_TopPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldTopPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldTopPadding)
            if value != nil {
                return CGFloat(value.floatValue)
            }
            return 0
        }
    }
    
    /// 文字底边距
    public var whc_BottomPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldBottomPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            let value = objc_getAssociatedObject(self, &WHC_AssociatedObjectKey.kFieldBottomPadding)
            if value != nil {
                return CGFloat(value.floatValue)
            }
            return 0
        }
    }
    
    @objc private func myEditingRectForBounds(bounds: CGRect) -> CGRect {
        
        return self.myEditingRectForBounds(CGRectMake(self.whc_LeftPadding, self.whc_TopPadding, CGRectGetWidth(bounds) - self.whc_LeftPadding - self.whc_RightPadding, CGRectGetHeight(bounds) - whc_TopPadding - whc_BottomPadding))
    }
    
    @objc private func myTextRectForBounds(bounds: CGRect) -> CGRect {
        return self.myTextRectForBounds(CGRectMake(self.whc_LeftPadding, self.whc_TopPadding, CGRectGetWidth(bounds) - self.whc_LeftPadding - self.whc_RightPadding, CGRectGetHeight(bounds) - whc_TopPadding - whc_BottomPadding))
    }
    
}


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
    
    /// 文字左边距
    public var whc_LeftPadding: CGFloat {
        set {
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kLeftPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kRightPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kTopPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kBottomPadding, NSNumber(float: Float(newValue)), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
            return self.whc_Width(calcTextSize().width + whc_LeftPadding + whc_RightPadding + 1)
        }
        return super.whc_WidthAuto()
    }
    
    public override func whc_HeightAuto() -> UIView {
        if whc_TopPadding + whc_BottomPadding != 0 {
            return self.whc_Height(calcTextSize().height + whc_TopPadding + whc_BottomPadding + 1)
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
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kWidthWeight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
            objc_setAssociatedObject(self, &WHC_AssociatedObjectKey.kHeightWeight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
    private class WHC_StackViewLineView: UIView {}
    private class WHC_VacntView: UIView {}
    
    private lazy var lastRowVacantCount = 0
    private lazy var autoHeight = false
    private lazy var autoWidth = false
    
    /// StackView列数
    public lazy var whc_Column = 1
    /// StackView内边距
    public lazy var whc_Edge = UIEdgeInsetsZero
    /// StackView子视图横向间隙
    public lazy var whc_HSpace = CGFloat(0)
    /// StackView子视图垂直间隙
    public lazy var whc_VSpace = CGFloat(0)
    /// StackView布局方向
    public lazy var whc_Orientation = WHC_LayoutOrientationOptions.Horizontal
    /// StackView子视图个数
    public var whc_SubViewCount: Int {
        if self.whc_Orientation == .All {
            return self.subviews.count - lastRowVacantCount
        }
        return self.subviews.count
    }
    
    /// 子元素高宽比
    public lazy var whc_ElementHeightWidthRatio: CGFloat = 0
    /// 子元素宽高比
    public lazy var whc_ElementWidthHeightRatio: CGFloat = 0
    
    /// 子视图固定宽度
    public lazy var whc_SubViewWidth: CGFloat = 0
    /// 子视图固定高度
    public lazy var whc_SubViewHeight: CGFloat = 0
    /// 设置分割线尺寸
    public lazy var whc_SegmentLineSize: CGFloat = 0
    /// 设置分割线内边距
    public lazy var whc_SegmentLinePadding: CGFloat = 0
    /// 设置分割线的颜色
    public lazy var whc_SegmentLineColor = UIColor(white: 0.9, alpha: 1.0)
    
    public override func whc_WidthAuto() -> UIView {
        autoWidth = true
        return super.whc_WidthAuto()
    }
    
    public override func whc_HeightAuto() -> UIView {
        autoHeight = true
        return super.whc_HeightAuto()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// 开始布局
    public func whc_StartLayout() {
        runStackLayoutEngine()
    }
    
    /// 移除StackView上所有子视图
    public func whc_removeAllSubviews() {
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    }
    
    private func makeLine() -> WHC_StackViewLineView {
        let lineView = WHC_StackViewLineView()
        lineView.backgroundColor = whc_SegmentLineColor
        return lineView
    }
    
    private func removeAllSegmentLine() {
        for subView in self.subviews {
            if subView is WHC_StackViewLineView {
                subView.removeFromSuperview()
            }
        }
    }
    
    /// 布局引擎
    private func runStackLayoutEngine() {
        var currentSubViews = self.subviews
        var count = currentSubViews.count
        if count == 0 {return}
        var toView: UIView!
        switch whc_Orientation {
        case .Horizontal: /// 横向布局
            for i in 0 ..< count {
                let view = currentSubViews[i]
                let nextView: UIView! = i < count - 1 ? currentSubViews[i + 1] : nil
                if i == 0 {
                    view.whc_Left(whc_Edge.left)
                }else {
                    if whc_SegmentLineSize > 0 {
                        let lineView = makeLine()
                        self.addSubview(lineView)
                        lineView.whc_Top(whc_SegmentLinePadding)
                        lineView.whc_Bottom(whc_SegmentLinePadding)
                        lineView.whc_Left(whc_HSpace / 2.0 , toView: toView)
                        lineView.whc_Width(whc_SegmentLineSize)
                        view.whc_Left(whc_HSpace / 2.0, toView: lineView)
                    }else {
                        view.whc_Left(whc_HSpace, toView: toView)
                    }
                }
                view.whc_Top(whc_Edge.top)
                if nextView != nil {
                    if whc_SubViewWidth > 0 {
                        view.whc_Width(whc_SubViewWidth)
                    }else {
                        if whc_ElementWidthHeightRatio > 0 {
                            view.whc_WidthHeightRatio(whc_ElementWidthHeightRatio)
                        }else {
                            if autoWidth {
                                view.whc_WidthAuto()
                            }else {
                                view.whc_WidthEqual(nextView, ratio: view.whc_WidthWeight / nextView.whc_WidthWeight)
                            }
                        }
                    }
                    if whc_SubViewHeight > 0 {
                        view.whc_Height(whc_SubViewHeight)
                    }else {
                        if whc_ElementHeightWidthRatio > 0 {
                            view.whc_HeightWidthRatio(whc_ElementHeightWidthRatio)
                        }else {
                            if autoHeight {
                                view.whc_HeightAuto()
                            }else {
                                view.whc_Bottom(whc_Edge.bottom)
                            }
                        }
                    }
                }else {
                    if whc_SubViewWidth > 0 {
                        view.whc_Width(whc_SubViewWidth)
                        if autoWidth {
                            view.whc_Right(whc_Edge.right , keepWidthConstraint: true)
                        }
                    }else {
                        if whc_ElementWidthHeightRatio > 0 {
                            view.whc_WidthHeightRatio(whc_ElementWidthHeightRatio)
                            if autoWidth {
                                view.whc_Right(whc_Edge.right , keepWidthConstraint:true)
                            }
                        }else {
                            if autoWidth {
                                view.whc_WidthAuto()
                                view.whc_Right(whc_Edge.right , keepWidthConstraint:true)
                            }else {
                                view.whc_Right(whc_Edge.right)
                            }
                        }
                    }
                    if whc_SubViewHeight > 0 {
                        view.whc_Height(whc_SubViewHeight)
                        if autoHeight {
                            view.whc_Bottom(whc_Edge.bottom , keepHeightConstraint:true)
                        }
                    }else {
                        if whc_ElementHeightWidthRatio > 0 {
                            view.whc_HeightWidthRatio(whc_ElementHeightWidthRatio)
                            if autoHeight {
                                view.whc_Bottom(whc_Edge.bottom , keepHeightConstraint:true)
                            }
                        }else {
                            if autoHeight {
                                view.whc_HeightAuto()
                                view.whc_Bottom(whc_Edge.bottom ,keepHeightConstraint:true)
                            }else {
                                view.whc_Bottom(whc_Edge.bottom)
                            }
                        }
                    }
                }
                toView = view;
                if toView is WHC_StackView {
                    (toView as! WHC_StackView).whc_StartLayout()
                }
            }
        case .Vertical: /// 垂直布局
            for i in 0 ..< count {
                let view = currentSubViews[i];
                let nextView: UIView! = i < count - 1 ? currentSubViews[i + 1] : nil;
                if i == 0 {
                    view.whc_Top(whc_Edge.top)
                }else {
                    if whc_SegmentLineSize > 0.0 {
                        let lineView = makeLine()
                        self.addSubview(lineView)
                        lineView.whc_Left(whc_SegmentLinePadding)
                        lineView.whc_Right(whc_SegmentLinePadding)
                        lineView.whc_Height(whc_SegmentLineSize)
                        lineView.whc_Top(whc_VSpace / 2.0 , toView:toView)
                        view.whc_Top(whc_VSpace / 2.0 , toView:lineView)
                    }else {
                        view.whc_Top(whc_VSpace ,toView:toView)
                    }
                }
                view.whc_Left(whc_Edge.left)
                if nextView != nil {
                    if whc_SubViewWidth > 0 {
                        view.whc_Width(whc_SubViewWidth)
                    }else {
                        if whc_ElementWidthHeightRatio > 0 {
                            view.whc_WidthHeightRatio(whc_ElementWidthHeightRatio)
                        }else {
                            if autoWidth {
                                view.whc_WidthAuto()
                            }else {
                                view.whc_Right(whc_Edge.right)
                            }
                        }
                    }
                    if whc_SubViewHeight > 0 {
                        view.whc_Height(whc_SubViewHeight)
                    }else {
                        if whc_ElementHeightWidthRatio > 0 {
                            view.whc_HeightWidthRatio(whc_ElementHeightWidthRatio)
                        }else {
                            if autoHeight {
                                view.whc_HeightAuto()
                            }else {
                                view.whc_HeightEqual(nextView, ratio: view.whc_HeightWeight / nextView.whc_HeightWeight)
                            }
                        }
                    }
                }else {
                    if whc_SubViewWidth > 0 {
                        view.whc_Width(whc_SubViewWidth)
                        if autoWidth {
                            view.whc_Right(whc_Edge.right, keepWidthConstraint:true)
                        }
                    }else {
                        if whc_ElementWidthHeightRatio > 0 {
                            view.whc_WidthHeightRatio(whc_ElementWidthHeightRatio)
                            if autoWidth {
                                view.whc_Right(whc_Edge.right, keepWidthConstraint:true)
                            }
                        }else {
                            if autoWidth {
                                view.whc_WidthAuto()
                                view.whc_Right(whc_Edge.right, keepWidthConstraint:true)
                            }else {
                                view.whc_Right(whc_Edge.right)
                            }
                        }
                    }
                    if whc_SubViewHeight > 0 {
                        view.whc_Height(whc_SubViewHeight)
                        if autoHeight {
                            view.whc_Bottom(whc_Edge.bottom, keepHeightConstraint:true)
                        }
                    }else {
                        if whc_ElementHeightWidthRatio > 0 {
                            view.whc_HeightWidthRatio(whc_ElementHeightWidthRatio)
                            if autoHeight {
                                view.whc_Bottom(whc_Edge.bottom, keepHeightConstraint:true)
                            }
                        }else {
                            if autoHeight {
                                view.whc_HeightAuto()
                                view.whc_Bottom(whc_Edge.bottom, keepHeightConstraint:true)
                            }else {
                                view.whc_Bottom(whc_Edge.bottom)
                            }
                        }
                    }
                }
                toView = view;
                if toView is WHC_StackView {
                    (toView as! WHC_StackView).whc_StartLayout()
                }
            }
        case .All: // 横向垂直很混布局
            for view in self.subviews {
                if view is WHC_VacntView {
                    view.removeFromSuperview()
                }
            }
            currentSubViews = self.subviews;
            count = currentSubViews.count;
            let rowCount = count / self.whc_Column + (count % self.whc_Column == 0 ? 0 : 1);
            var index = 0;
            lastRowVacantCount = rowCount * whc_Column - count;
            for _ in 0 ..< lastRowVacantCount {
                let view = WHC_VacntView()
                view.backgroundColor = UIColor.clearColor()
                self.addSubview(view)
            }
            if lastRowVacantCount > 0 {
                currentSubViews = self.subviews
                count = currentSubViews.count
            }
            var frontRowView: UIView!
            var frontColumnView: UIView!
            
            var columnLineView: WHC_StackViewLineView!
            for row in 0 ..< rowCount {
                var nextRowView: UIView!
                let rowView = currentSubViews[row * self.whc_Column]
                let nextRow = (row + 1) * self.whc_Column
                if nextRow < count {
                    nextRowView = currentSubViews[nextRow]
                }
                var rowLineView: WHC_StackViewLineView!
                if whc_SegmentLineSize > 0.0 && row > 0 {
                    rowLineView = makeLine()
                    self.addSubview(rowLineView)
                    rowLineView.whc_Left(whc_SegmentLinePadding)
                    rowLineView.whc_Right(whc_SegmentLinePadding)
                    rowLineView.whc_Height(whc_SegmentLineSize)
                    rowLineView.whc_Top(whc_VSpace / 2.0 , toView:frontRowView)
                }
                for column in 0 ..< whc_Column {
                    index = row * self.whc_Column + column
                    let view  = currentSubViews[index]
                    var nextColumnView: UIView!
                    if column > 0 && whc_SegmentLineSize > 0.0 {
                        columnLineView = makeLine()
                        self.addSubview(columnLineView)
                        columnLineView.whc_Left(whc_HSpace / 2.0 ,toView:frontColumnView)
                        columnLineView.whc_Top(whc_SegmentLinePadding)
                        columnLineView.whc_Bottom(whc_SegmentLinePadding)
                        columnLineView.whc_Width(whc_SegmentLineSize)
                    }
                    if column < self.whc_Column - 1 && index < count {
                        nextColumnView = currentSubViews[index + 1]
                    }
                    if row == 0 {
                        view.whc_Top(whc_Edge.top)
                    }else {
                        if rowLineView != nil {
                            view.whc_Top(whc_VSpace / 2.0, toView:rowLineView)
                        }else {
                            view.whc_Top(whc_VSpace , toView:frontRowView)
                        }
                    }
                    if column == 0 {
                        view.whc_Left(whc_Edge.left)
                    }else {
                        if columnLineView != nil {
                            view.whc_Left(whc_HSpace / 2.0, toView:columnLineView)
                        }else {
                            view.whc_Left(whc_HSpace , toView:frontColumnView)
                        }
                        
                    }
                    if nextRowView != nil {
                        if whc_SubViewHeight > 0 {
                            view.whc_Height(whc_SubViewHeight)
                        }else {
                            if whc_ElementHeightWidthRatio > 0 {
                                view.whc_HeightWidthRatio(whc_ElementHeightWidthRatio)
                            }else {
                                if autoHeight {
                                    view.whc_HeightAuto()
                                }else {
                                    view.whc_HeightEqual(nextRowView ,
                                        ratio:view.whc_HeightWeight / nextRowView.whc_HeightWeight)
                                }
                            }
                        }
                    }else {
                        if whc_SubViewHeight > 0 {
                            view.whc_Height(whc_SubViewHeight)
                        }else {
                            if whc_ElementHeightWidthRatio > 0 {
                                view.whc_HeightWidthRatio(whc_ElementHeightWidthRatio)
                            }else {
                                if autoHeight {
                                    view.whc_HeightAuto()
                                }else {
                                    view.whc_Bottom(whc_Edge.bottom)
                                }
                            }
                        }
                    }
                    if nextColumnView != nil {
                        if whc_SubViewWidth > 0 {
                            view.whc_Width(whc_SubViewWidth)
                        }else {
                            if whc_ElementWidthHeightRatio > 0 {
                                view.whc_WidthHeightRatio(whc_ElementWidthHeightRatio)
                            }else {
                                if autoWidth {
                                    view.whc_WidthAuto()
                                }else {
                                    view.whc_WidthEqual(nextColumnView ,
                                        ratio:view.whc_WidthWeight / nextColumnView.whc_WidthWeight)
                                }
                            }
                        }
                    }else {
                        if whc_SubViewWidth > 0 {
                            view.whc_Width(whc_SubViewWidth)
                        }else {
                            if whc_ElementWidthHeightRatio > 0 {
                                view.whc_WidthHeightRatio(whc_ElementWidthHeightRatio)
                            }else {
                                if autoWidth {
                                    view.whc_WidthAuto()
                                }else {
                                    view.whc_Right(whc_Edge.right)
                                }
                            }
                        }
                    }
                    frontColumnView = view
                    if frontColumnView is WHC_StackView {
                        (frontColumnView as! WHC_StackView).whc_StartLayout()
                    }
                }
                frontRowView = rowView;
            }
            if autoWidth {
                self.layoutIfNeeded()
                var rowLastColumnViewMaxX: CGFloat = 0
                var rowLastColumnViewMaxXView: UIView!
                for r in 1 ... rowCount {
                    let index = r * whc_Column - 1
                    let maxWidthView = subviews[index]
                    maxWidthView.layoutIfNeeded()
                    if maxWidthView.whc_MaxX > rowLastColumnViewMaxX {
                        rowLastColumnViewMaxX = maxWidthView.whc_MaxX
                        rowLastColumnViewMaxXView = maxWidthView
                    }
                }
                rowLastColumnViewMaxXView.whc_Right(whc_Edge.right, keepWidthConstraint: true)
            }
            
            if autoHeight {
                self.layoutIfNeeded()
                var columnLastRowViewMaxY: CGFloat = 0
                var columnLastRowViewMaxYView: UIView!
                for r in 1 ... rowCount {
                    let index = r * whc_Column - 1
                    let maxHeightView = subviews[index]
                    maxHeightView.layoutIfNeeded()
                    if maxHeightView.whc_MaxY > columnLastRowViewMaxY {
                        columnLastRowViewMaxY = maxHeightView.whc_MaxY
                        columnLastRowViewMaxYView = maxHeightView
                    }
                }
                columnLastRowViewMaxYView.whc_Bottom(whc_Edge.bottom, keepHeightConstraint: true)
            }
        }
    }
}
