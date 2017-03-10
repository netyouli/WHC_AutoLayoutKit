//
//  UIView+WHC_AutoLayout.m
//  Github <https://github.com/netyouli/WHC_AutoLayoutKit>
//
//  Created by 吴海超 on 16/2/17.
//  Copyright © 2016年 吴海超. All rights reserved.
//

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

#import "UIView+WHC_AutoLayout.h"
#import <objc/runtime.h>

#define kDeprecatedVerticalAdapter (0)

typedef NS_OPTIONS(NSUInteger, WHCNibType) {
    XIB = 1 << 0,
    SB = 1 << 1
};

#pragma mark - UI自动布局 -

@interface WHC_Line : UIView
@end

@implementation WHC_Line
@end

@implementation UIView (WHC_AutoLayout)

- (void)setCurrentConstraint:(NSLayoutConstraint *)currentConstraint {
    objc_setAssociatedObject(self, @selector(currentConstraint), currentConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)currentConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - removeConstraint api v2.0 -

- (RemoveConstraintAttribute)whc_RemoveConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(NSLayoutAttribute attribute) {
        [weakSelf whc_RemoveConstraintAttribute:attribute];
        return weakSelf;
    };
}

- (RemoveConstraintAttributeItem)whc_RemoveConstraintItem {
    __weak typeof(self) weakSelf = self;
    return ^(NSLayoutAttribute attribute, UIView * item) {
        if (item == nil) {
            [weakSelf whc_RemoveConstraintAttribute:attribute];
        }else {
            [weakSelf whc_RemoveConstraintAttribute:attribute item:item];
        }
        return weakSelf;
    };
}

- (RemoveConstraintAttributeItemToItem)whc_RemoveConstraintItemToItem {
    __weak typeof(self) weakSelf = self;
    return ^(NSLayoutAttribute attribute, UIView * item, UIView * toItem) {
        [weakSelf whc_RemoveConstraintAttribute:attribute item:item toItem:toItem];
        return weakSelf;
    };
}

#pragma mark - constraintsPriority api v2.0 -

- (PriorityLow)whc_PriorityLow {
    __weak typeof(self) weakSelf = self;
    return ^() {
        [weakSelf whc_priorityLow];
        return weakSelf;
    };
}

- (PriorityHigh)whc_PriorityHigh {
    __weak typeof(self) weakSelf = self;
    return ^() {
        [weakSelf whc_priorityHigh];
        return weakSelf;
    };
}

- (PriorityRequired)whc_PriorityRequired {
    __weak typeof(self) weakSelf = self;
    return ^() {
        [weakSelf whc_priorityRequired];
        return weakSelf;
    };
}

- (PriorityFitting)whc_PriorityFitting {
    __weak typeof(self) weakSelf = self;
    return ^() {
        [weakSelf whc_priorityFitting];
        return weakSelf;
    };
}

- (PriorityValue)whc_Priority {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf whc_priority:value];
        return weakSelf;
    };
}

#pragma mark - api version 2.0 -
- (LeftSpace)whc_LeftSpace {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat space) {
        [weakSelf whc_LeftSpace:space];
        return weakSelf;
    };
}

- (LeftSpaceToView)whc_LeftSpaceToView {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat space, UIView * toView) {
        [weakSelf whc_LeftSpace:space toView:toView];
        return weakSelf;
    };
}

- (LeftSpaceEqualView)whc_LeftSpaceEqualView {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view) {
        [weakSelf whc_LeftSpaceEqualView:view];
        return weakSelf;
    };
}

- (LeftSpaceEqualViewOffset)whc_LeftSpaceEqualViewOffset {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view, CGFloat offset) {
        [weakSelf whc_LeftSpaceEqualView:view offset:offset];
        return weakSelf;
    };
}

- (LeadingSpace)whc_LeadingSpace {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat space) {
        [weakSelf whc_LeadingSpace:space];
        return weakSelf;
    };
}

- (LeadingSpaceToView)whc_LeadingSpaceToView {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value , UIView * toView) {
        [weakSelf whc_LeadingSpace:value toView:toView];
        return weakSelf;
    };
}

- (LeadingSpaceEqualView)whc_LeadingSpaceEqualView {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view) {
        [weakSelf whc_LeadingSpaceEqualView:view];
        return weakSelf;
    };
}

- (LeadingSpaceEqualViewOffset)whc_LeadingSpaceEqualViewOffset {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view, CGFloat offset) {
        [weakSelf whc_LeadingSpaceEqualView:view offset:offset];
        return weakSelf;
    };
}

- (TrailingSpace)whc_TrailingSpace {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat space) {
        [weakSelf whc_TrailingSpace:space];
        return weakSelf;
    };
}

- (TrailingSpaceToView)whc_TrailingSpaceToView {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value , UIView * toView) {
        [weakSelf whc_TrailingSpace:value toView:toView];
        return weakSelf;
    };
}

- (TrailingSpaceEqualView)whc_TrailingSpaceEqualView {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view) {
        [weakSelf whc_TrailingSpaceEqualView:view];
        return weakSelf;
    };
}

- (TrailingSpaceEqualViewOffset)whc_TrailingSpaceEqualViewOffset {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view, CGFloat offset) {
        [weakSelf whc_TrailingSpaceEqualView:view offset:offset];
        return weakSelf;
    };
}

- (BaseLineSpace)whc_BaseLineSpace {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat space) {
        [weakSelf whc_BaseLineSpace:space];
        return weakSelf;
    };
}

- (BaseLineSpaceToView)whc_BaseLineSpaceToView {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value , UIView * toView) {
        [weakSelf whc_BaseLineSpace:value toView:toView];
        return weakSelf;
    };
}

- (BaseLineSpaceEqualView)whc_BaseLineSpaceEqualView {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view) {
        [weakSelf whc_BaseLineSpaceEqualView:view];
        return weakSelf;
    };
}

- (BaseLineSpaceEqualViewOffset)whc_BaseLineSpaceEqualViewOffset {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view, CGFloat offset) {
        [weakSelf whc_BaseLineSpaceEqualView:view offset:offset];
        return weakSelf;
    };
}

- (RightSpace)whc_RightSpace {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat space) {
        [weakSelf whc_RightSpace:space];
        return weakSelf;
    };
}

- (RightSpaceToView)whc_RightSpaceToView {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value , UIView * toView) {
        [weakSelf whc_RightSpace:value toView:toView];
        return weakSelf;
    };
}

- (RightSpaceEqualView)whc_RightSpaceEqualView {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * toView) {
        [weakSelf whc_RightSpaceEqualView:toView];
        return weakSelf;
    };
}

- (RightSpaceEqualViewOffset)whc_RightSpaceEqualViewOffset {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * toView, CGFloat offset) {
        [weakSelf whc_RightSpaceEqualView:toView offset:offset];
        return weakSelf;
    };
}


- (RightSpaceKeepWidthConstraint)whc_RightSpaceKeepWidthConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat space, BOOL isKeep) {
        [weakSelf whc_RightSpace:space keepWidthConstraint:isKeep];
        return weakSelf;
    };
}

- (RightSpaceToViewKeepWidthConstraint)whc_RightSpaceToViewKeepWidthConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value , UIView * toView, BOOL isKeep) {
        [weakSelf whc_RightSpace:value toView:toView keepWidthConstraint:isKeep];
        return weakSelf;
    };
}

- (RightSpaceEqualViewKeepWidthConstraint)whc_RightSpaceEqualViewKeepWidthConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * toView, BOOL isKeep) {
        [weakSelf whc_RightSpaceEqualView:toView keepWidthConstraint:isKeep];
        return weakSelf;
    };
}

- (RightSpaceEqualViewOffsetKeepWidthConstraint)whc_RightSpaceEqualViewOffsetKeepWidthConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * toView, CGFloat offset, BOOL isKeep) {
        [weakSelf whc_RightSpaceEqualView:toView offset:offset keepWidthConstraint:isKeep];
        return weakSelf;
    };
}

- (TopSpace)whc_TopSpace {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat space) {
        [weakSelf whc_TopSpace:space];
        return weakSelf;
    };
}

- (TopSpaceToView)whc_TopSpaceToView {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value , UIView * toView) {
        [weakSelf whc_TopSpace:value toView:toView];
        return weakSelf;
    };
}

- (TopSpaceEqualView)whc_TopSpaceEqualView {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view) {
        [weakSelf whc_TopSpaceEqualView:view];
        return weakSelf;
    };
}

- (TopSpaceEqualViewOffset)whc_TopSpaceEqualViewOffset {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view, CGFloat offset) {
        [weakSelf whc_TopSpaceEqualView:view offset:offset];
        return weakSelf;
    };
}

- (BottomSpace)whc_BottomSpace {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat space) {
        [weakSelf whc_BottomSpace:space];
        return weakSelf;
    };
}

- (BottomSpaceToView)whc_BottomSpaceToView {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value , UIView * toView) {
        [weakSelf whc_BottomSpace:value toView:toView];
        return weakSelf;
    };
}

- (BottomSpaceEqualView)whc_BottomSpaceEqualView {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * toView) {
        [weakSelf whc_BottomSpaceEqualView:toView];
        return weakSelf;
    };
}

- (BottomSpaceEqualViewOffset)whc_BottomSpaceEqualViewOffset {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * toView, CGFloat offset) {
        [weakSelf whc_BottomSpaceEqualView:toView offset:offset];
        return weakSelf;
    };
}

- (BottomSpaceKeepHeightConstraint)whc_BottomSpaceKeepHeightConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat space, BOOL isKeep) {
        [weakSelf whc_BottomSpace:space keepHeightConstraint:isKeep];
        return weakSelf;
    };
}

- (BottomSpaceToViewKeepHeightConstraint)whc_BottomSpaceToViewKeepHeightConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value , UIView * toView, BOOL isKeep) {
        [weakSelf whc_BottomSpace:value toView:toView keepHeightConstraint:isKeep];
        return weakSelf;
    };
}

- (BottomSpaceEqualViewKeepHeightConstraint)whc_BottomSpaceEqualViewKeepHeightConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * toView, BOOL isKeep) {
        [weakSelf whc_BottomSpaceEqualView:toView keepHeightConstraint:isKeep];
        return weakSelf;
    };
}

- (BottomSpaceEqualViewOffsetKeepHeightConstraint)whc_BottomSpaceEqualViewOffsetKeepHeightConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * toView, CGFloat offset, BOOL isKeep) {
        [weakSelf whc_BottomSpaceEqualView:toView offset:offset keepHeightConstraint:isKeep];
        return weakSelf;
    };
}

- (Width)whc_Width {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf whc_Width:value];
        return weakSelf;
    };
}

- (WidthAuto)whc_WidthAuto {
    __weak typeof(self) weakSelf = self;
    return ^() {
        [weakSelf whc_AutoWidth];
        return weakSelf;
    };
}

- (WidthEqualView)whc_WidthEqualView {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view) {
        [weakSelf whc_WidthEqualView:view];
        return weakSelf;
    };
}

- (WidthEqualViewRatio)whc_WidthEqualViewRatio {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view , CGFloat value) {
        [weakSelf whc_WidthEqualView:view ratio:value];
        return weakSelf;
    };
}

- (WidthKeepRightConstraint)whc_WidthKeepRightConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value, BOOL isKeep) {
        [weakSelf whc_Width:value keepRightConstraint:isKeep];
        return weakSelf;
    };
}

- (WidthAutoKeepRightConstraint)whc_WidthAutoKeepRightConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(BOOL isKeep) {
        [weakSelf whc_WidthAutoKeepRightConstraint:isKeep];
        return weakSelf;
    };
}

- (WidthEqualViewKeepRightConstraint)whc_WidthEqualViewKeepRightConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view, BOOL isKeep) {
        [weakSelf whc_WidthEqualView:view keepRightConstraint:isKeep];
        return weakSelf;
    };
}

- (WidthEqualViewRatioKeepRightConstraint)whc_WidthEqualViewRatioKeepRightConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view , CGFloat value, BOOL isKeep) {
        [weakSelf whc_WidthEqualView:view ratio:value keepRightConstraint:isKeep];
        return weakSelf;
    };
}

- (WidthHeightRatio)whc_WidthHeightRatio {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf whc_WidthHeightRatio:value];
        return weakSelf;
    };
}

- (Height)whc_Height {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf whc_Height:value];
        return weakSelf;
    };
}

- (HeightAuto)whc_HeightAuto {
    __weak typeof(self) weakSelf = self;
    return ^() {
        [weakSelf whc_AutoHeight];
        return weakSelf;
    };
}

- (HeightEqualView)whc_HeightEqualView {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view) {
        [weakSelf whc_HeightEqualView:view];
        return weakSelf;
    };
}

- (HeightEqualViewRatio)whc_HeightEqualViewRatio {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view , CGFloat value) {
        [weakSelf whc_HeightEqualView:view ratio:value];
        return weakSelf;
    };
}

- (HeightKeepBottomConstraint)whc_HeightKeepBottomConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value, BOOL isKeep) {
        [weakSelf whc_Height:value keepBottomConstraint:isKeep];
        return weakSelf;
    };
}

- (HeightAutoKeepBottomConstraint)whc_HeightAutoKeepBottomConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(BOOL isKeep) {
        [weakSelf whc_HeightAutoKeepBottomConstraint:isKeep];
        return weakSelf;
    };
}

- (HeightEqualViewKeepBottomConstraint)whc_HeightEqualViewKeepBottomConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view, BOOL isKeep) {
        [weakSelf whc_HeightEqualView:view keepBottomConstraint:isKeep];
        return weakSelf;
    };
}

- (HeightEqualViewRatioKeepBottomConstraint)whc_HeightEqualViewRatioKeepBottomConstraint {
    __weak typeof(self) weakSelf = self;
    return ^(UIView * view , CGFloat value, BOOL isKeep) {
        [weakSelf whc_HeightEqualView:view ratio:value keepBottomConstraint:isKeep];
        return weakSelf;
    };
}

- (HeightWidthRatio)whc_HeightWidthRatio {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf whc_HeightWidthRatio:value];
        return weakSelf;
    };
}

- (CenterX)whc_CenterX {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf whc_CenterX:value];
        return weakSelf;
    };
}

- (CenterXToView)whc_CenterXToView {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value,UIView * toView) {
        [weakSelf whc_CenterX:value toView:toView];
        return weakSelf;
    };
}

- (CenterY)whc_CenterY {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf whc_CenterY:value];
        return weakSelf;
    };
}

- (CenterYToView)whc_CenterYToView {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value,UIView * toView) {
        [weakSelf whc_CenterY:value toView:toView];
        return weakSelf;
    };
}

- (Center)whc_Center {
    __weak typeof(self) weakSelf = self;
    return ^(CGPoint center) {
        [weakSelf whc_Center:center];
        return weakSelf;
    };
}

- (CenterToView)whc_CenterToView {
    __weak typeof(self) weakSelf = self;
    return ^(CGPoint center,UIView * toView) {
        [weakSelf whc_Center:center toView:toView];
        return weakSelf;
    };
}

- (size)whc_Size {
    __weak typeof(self) weakSelf = self;
    return ^(CGSize size) {
        [weakSelf whc_Size:size];
        return weakSelf;
    };
}

#pragma mark - removeConstraint api v1.0 -

- (void)whc_RemoveConstraintAttribute:(NSLayoutAttribute)Attribute {
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstAttribute == Attribute && obj.secondItem == nil) {
            [self removeConstraint:obj];
        }
    }];
}

- (void)whc_RemoveConstraintAttribute:(NSLayoutAttribute)Attribute item:(UIView *)item {
    if (item == nil) {
        [self whc_RemoveConstraintAttribute:Attribute];
    }else {
        [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.firstAttribute == Attribute &&
                ((obj.secondItem == item &&
                  obj.firstItem == self) ||
                 (obj.secondItem == self &&
                  obj.firstItem == item)) ) {
                     [self removeConstraint:obj];
            }
        }];
    }
}

- (void)whc_RemoveConstraintAttribute:(NSLayoutAttribute)Attribute item:(UIView *)item toItem:(UIView *)toItem {
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstAttribute == Attribute &&
            obj.firstItem == item &&
            obj.secondItem == toItem) {
            [self removeConstraint:obj];
        }
    }];
}

#pragma mark - constraintsPriority api v1.0 -
- (void)whc_HandleConstraintsPriority:(UILayoutPriority)priority {
    NSLayoutConstraint * constraints = [self currentConstraint];
    if (constraints && constraints.priority != priority) {
        if (constraints.priority == UILayoutPriorityRequired) {
            if (!constraints.secondItem ||
                constraints.secondAttribute == NSLayoutAttributeNotAnAttribute) {
                [self removeConstraint:constraints];
                constraints.priority = priority;
                [self addConstraint:constraints];
            }else {
                if (self.superview) {
                    [self.superview removeConstraint:constraints];
                    constraints.priority = priority;
                    [self.superview addConstraint:constraints];
                }
            }
        }else if (constraints) {
            constraints.priority = priority;
        }
    }
}

- (void)whc_priorityLow {
    [self whc_HandleConstraintsPriority:UILayoutPriorityDefaultLow];
}

- (void)whc_priorityHigh {
    [self whc_HandleConstraintsPriority:UILayoutPriorityDefaultHigh];
}

- (void)whc_priorityRequired {
    [self whc_HandleConstraintsPriority:UILayoutPriorityRequired];
}

- (void)whc_priorityFitting {
    [self whc_HandleConstraintsPriority:UILayoutPriorityFittingSizeLevel];
}

- (void)whc_priority:(CGFloat)value {
    [self whc_HandleConstraintsPriority:value];
}

#pragma mark - api version 1.0 -

- (void)whc_LeftSpace:(CGFloat)leftSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeLeft
                        constant:leftSpace];
}

- (void)whc_LeftSpace:(CGFloat)leftSpace toView:(UIView *)toView {
    NSLayoutAttribute toAttribute = NSLayoutAttributeRight;
    if (toView.superview == nil) {
        toAttribute = NSLayoutAttributeLeft;
    }else if (self.superview != toView.superview) {
        toAttribute = NSLayoutAttributeLeft;
    }
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeLeft
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:toAttribute
                      multiplier:1
                        constant:leftSpace];
}

- (void)whc_LeftSpaceEqualView:(UIView *)view {
    [self whc_LeftSpaceEqualView:view offset:0];
}

- (void)whc_LeftSpaceEqualView:(UIView *)view offset:(CGFloat)offset {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeLeft
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeLeft
                      multiplier:1
                        constant:offset];
}

- (void)whc_RightSpace:(CGFloat)rightSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeRight
                        constant:0.0 - rightSpace];
}

- (void)whc_RightSpace:(CGFloat)rightSpace toView:(UIView *)toView {
    NSLayoutAttribute toAttribute = NSLayoutAttributeLeft;
    if (toView.superview == nil) {
        toAttribute = NSLayoutAttributeRight;
    }else if (self.superview != toView.superview) {
        toAttribute = NSLayoutAttributeRight;
    }
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeRight
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:toAttribute
                      multiplier:1
                        constant:0.0 - rightSpace];
}

- (void)whc_RightSpaceEqualView:(UIView *)view {
    [self whc_RightSpaceEqualView:view offset:0];
}

- (void)whc_RightSpaceEqualView:(UIView *)view offset:(CGFloat)offset {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeRight
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeRight
                      multiplier:1
                        constant:0.0 - offset];
}

- (void)whc_RightSpace:(CGFloat)rightSpace keepWidthConstraint:(BOOL)isKeep {
    [self setKeepWidthConstraint:isKeep];
    [self whc_RightSpace:rightSpace];
}


- (void)whc_RightSpace:(CGFloat)rightSpace toView:(UIView *)toView keepWidthConstraint:(BOOL)isKeep {
    [self setKeepWidthConstraint:isKeep];
    [self whc_RightSpace:rightSpace toView:toView];
}


- (void)whc_RightSpaceEqualView:(UIView *)view keepWidthConstraint:(BOOL)isKeep {
    [self setKeepWidthConstraint:isKeep];
    [self whc_RightSpaceEqualView:view];
}

- (void)whc_RightSpaceEqualView:(UIView *)view offset:(CGFloat)offset keepWidthConstraint:(BOOL)isKeep {
    [self setKeepWidthConstraint:isKeep];
    [self whc_RightSpaceEqualView:view offset:offset];
}

- (void)whc_LeadingSpace:(CGFloat)leadingSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeLeading
                        constant:leadingSpace];
}

- (void)whc_LeadingSpace:(CGFloat)leadingSpace
            toView:(UIView *)toView {
    NSLayoutAttribute toAttribute = NSLayoutAttributeTrailing;
    if (toView.superview == nil) {
        toAttribute = NSLayoutAttributeLeading;
    }else if (self.superview != toView.superview) {
        toAttribute = NSLayoutAttributeLeading;
    }
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeLeading
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:toAttribute
                      multiplier:1
                        constant:leadingSpace];
}

- (void)whc_LeadingSpaceEqualView:(UIView *)view {
    [self whc_LeadingSpaceEqualView:view offset:0];
}

- (void)whc_LeadingSpaceEqualView:(UIView *)view offset:(CGFloat)offset {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeLeading
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeLeading
                      multiplier:1
                        constant:offset];
}

- (void)whc_TrailingSpace:(CGFloat)trailingSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeTrailing
                        constant:0.0 - trailingSpace];
}

- (void)whc_TrailingSpace:(CGFloat)trailingSpace
             toView:(UIView *)toView {
    NSLayoutAttribute toAttribute = NSLayoutAttributeLeading;
    if (toView.superview == nil) {
        toAttribute = NSLayoutAttributeTrailing;
    }else if (self.superview != toView.superview) {
        toAttribute = NSLayoutAttributeTrailing;
    }
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeTrailing
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:toAttribute
                      multiplier:1
                        constant:0.0 - trailingSpace];
}

- (void)whc_TrailingSpaceEqualView:(UIView *)view {
    [self whc_TrailingSpaceEqualView:view offset:0];
}

- (void)whc_TrailingSpaceEqualView:(UIView *)view offset:(CGFloat)offset {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeTrailing
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeTrailing
                      multiplier:1
                        constant:0.0 - offset];
}

- (void)whc_TopSpace:(CGFloat)topSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeTop
                        constant:topSpace];
}

- (void)whc_TopSpace:(CGFloat)topSpace toView:(UIView *)toView {
    NSLayoutAttribute toAttribute = NSLayoutAttributeBottom;
    if (toView.superview == nil) {
        toAttribute = NSLayoutAttributeTop;
    }else if (self.superview != toView.superview) {
        toAttribute = NSLayoutAttributeTop;
    }
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeTop
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:toAttribute
                      multiplier:1
                        constant:topSpace];
}

- (void)whc_TopSpaceEqualView:(UIView *)view {
    [self whc_TopSpaceEqualView:view offset:0];
}

- (void)whc_TopSpaceEqualView:(UIView *)view offset:(CGFloat)offset {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeTop
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeTop
                      multiplier:1
                        constant:offset];
}

- (void)whc_BottomSpace:(CGFloat)bottomSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeBottom
                        constant:0.0 - bottomSpace];
}

- (void)whc_BottomSpace:(CGFloat)bottomSpace toView:(UIView *)toView {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeBottom
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:NSLayoutAttributeTop
                      multiplier:1
                        constant:bottomSpace];
}

- (void)whc_BottomSpaceEqualView:(UIView *)view {
    [self whc_BottomSpaceEqualView:view offset:0];
}

- (void)whc_BottomSpaceEqualView:(UIView *)view offset:(CGFloat)offset {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeBottom
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeBottom
                      multiplier:1
                        constant:0.0 - offset];
}

- (void)whc_BottomSpace:(CGFloat)bottomSpace keepHeightConstraint:(BOOL)isKeep {
    [self setKeepHeightConstraint:isKeep];
    [self whc_BottomSpace:bottomSpace];
}


- (void)whc_BottomSpace:(CGFloat)bottomSpace toView:(UIView *)toView keepHeightConstraint:(BOOL)isKeep {
    [self setKeepHeightConstraint:isKeep];
    [self whc_BottomSpace:bottomSpace toView:toView];
}


- (void)whc_BottomSpaceEqualView:(UIView *)view keepHeightConstraint:(BOOL)isKeep {
    [self setKeepHeightConstraint:isKeep];
    [self whc_BottomSpaceEqualView:view];
}

- (void)whc_BottomSpaceEqualView:(UIView *)view offset:(CGFloat)offset keepHeightConstraint:(BOOL)isKeep {
    [self setKeepHeightConstraint:isKeep];
    [self whc_BottomSpaceEqualView:view offset:offset];
}

- (void)whc_Width:(CGFloat)width{
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeWidth
                       relatedBy:NSLayoutRelationEqual
                          toItem:nil
                       attribute:NSLayoutAttributeNotAnAttribute
                      multiplier:0
                        constant:width];
}

- (void)whc_WidthEqualView:(UIView *)view {
    [self whc_ConstraintWithItem:view
                       attribute:NSLayoutAttributeWidth
                        constant:0];
}

- (void)whc_WidthEqualView:(UIView *)view ratio:(CGFloat)ratio {
    [self whc_ConstraintWithItem:view
                       attribute:NSLayoutAttributeWidth
                        constant:0
                      multiplier:ratio];

}

- (void)whc_AutoWidth {
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel * selfLabel = (UILabel *)self;
        if (selfLabel.numberOfLines == 0) {
            selfLabel.numberOfLines = 1;
        }
    }
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeWidth
                       relatedBy:NSLayoutRelationGreaterThanOrEqual
                          toItem:nil
                       attribute:NSLayoutAttributeNotAnAttribute
                      multiplier:1
                        constant:0];
}

- (void)whc_Width:(CGFloat)width keepRightConstraint:(BOOL)isKeep {
    [self setKeepRightConstraint:isKeep];
    [self whc_Width:width];
}

- (void)whc_WidthEqualView:(UIView *)view keepRightConstraint:(BOOL)isKeep {
    [self setKeepRightConstraint:isKeep];
    [self whc_WidthEqualView:view];
}

- (void)whc_WidthEqualView:(UIView *)view ratio:(CGFloat)ratio keepRightConstraint:(BOOL)isKeep {
    [self setKeepRightConstraint:isKeep];
    [self whc_WidthEqualView:view ratio:ratio];
}

- (void)whc_WidthAutoKeepRightConstraint:(BOOL)isKeep {
    [self setKeepRightConstraint:isKeep];
    [self whc_AutoWidth];
}

- (void)whc_WidthHeightRatio:(CGFloat)ratio {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeWidth
                       relatedBy:NSLayoutRelationEqual
                          toItem:self
                       attribute:NSLayoutAttributeHeight
                      multiplier:ratio
                        constant:0];
}

- (void)whc_Height:(CGFloat)height{
    [self whc_ConstraintWithItem:nil
                       attribute:NSLayoutAttributeHeight
                        constant:height];
}

- (void)whc_HeightEqualView:(UIView *)view {
    [self whc_ConstraintWithItem:view
                       attribute:NSLayoutAttributeHeight
                        constant:0];
}

- (void)whc_HeightEqualView:(UIView *)view ratio:(CGFloat)ratio {
    [self whc_ConstraintWithItem:view
                       attribute:NSLayoutAttributeHeight
                        constant:0
                      multiplier:ratio];
}

- (void)whc_AutoHeight {
    if ([self isKindOfClass:[UILabel class]]) {
        if (((UILabel *)self).numberOfLines != 0) {
            ((UILabel *)self).numberOfLines = 0;
        }
    }
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeHeight
                       relatedBy:NSLayoutRelationGreaterThanOrEqual
                          toItem:nil
                       attribute:NSLayoutAttributeNotAnAttribute
                      multiplier:1
                        constant:0];

}

- (void)whc_Height:(CGFloat)height keepBottomConstraint:(BOOL)isKeep {
    [self setKeepBottomConstraint:isKeep];
    [self whc_Height:height];
}

- (void)whc_HeightEqualView:(UIView *)view keepBottomConstraint:(BOOL)isKeep {
    [self setKeepBottomConstraint:isKeep];
    [self whc_HeightEqualView:view];
}

- (void)whc_HeightEqualView:(UIView *)view ratio:(CGFloat)ratio keepBottomConstraint:(BOOL)isKeep {
    [self setKeepBottomConstraint:isKeep];
    [self whc_HeightEqualView:view ratio:ratio];
}

- (void)whc_HeightAutoKeepBottomConstraint:(BOOL)isKeep {
    [self setKeepBottomConstraint:isKeep];
    [self whc_AutoHeight];
}

- (void)whc_HeightWidthRatio:(CGFloat)ratio {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeHeight
                       relatedBy:NSLayoutRelationEqual
                          toItem:self
                       attribute:NSLayoutAttributeWidth
                      multiplier:ratio
                        constant:0];
}

- (void)whc_CenterX:(CGFloat)centerX {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeCenterX
                        constant:centerX];
}

- (void)whc_CenterX:(CGFloat)centerX toView:(UIView *)toView {
    [self whc_ConstraintWithItem:toView
                       attribute:NSLayoutAttributeCenterX
                        constant:centerX];
}

- (void)whc_CenterY:(CGFloat)centerY {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeCenterY
                        constant:centerY];
}

- (void)whc_CenterY:(CGFloat)centerY toView:(UIView *)toView {
    [self whc_ConstraintWithItem:toView
                       attribute:NSLayoutAttributeCenterY
                        constant:centerY];
}

- (void)whc_BaseLineSpace:(CGFloat)lineSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeLastBaseline
                        constant:0.0 - lineSpace];
}

- (void)whc_BaseLineSpace:(CGFloat)lineSpace toView:(UIView *)toView {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeLastBaseline
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:NSLayoutAttributeTop
                      multiplier:1
                        constant:0.0 - lineSpace];
}

- (void)whc_BaseLineSpaceEqualView:(UIView *)view {
    [self whc_BaseLineSpaceEqualView:view offset:0];
}

- (void)whc_BaseLineSpaceEqualView:(UIView *)view offset:(CGFloat)offset {
    [self whc_ConstraintWithItem:view
                       attribute:NSLayoutAttributeLastBaseline
                        constant:0.0 - offset];
}


- (void)whc_Center:(CGPoint)center {
    [self whc_CenterX:center.x];
    [self whc_CenterY:center.y];
}

- (void)whc_Center:(CGPoint)center toView:(UIView *)toView {
    [self whc_CenterX:center.x toView:toView];
    [self whc_CenterY:center.y toView:toView];
}

- (void)whc_Frame:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height {
    [self whc_LeftSpace:left];
    [self whc_TopSpace:top];
    [self whc_Width:width];
    [self whc_Height:height];
}

- (void)whc_Size:(CGSize)size {
    [self whc_Width:size.width];
    [self whc_Height:size.height];
}

- (void)whc_Frame:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height toView:(UIView *)toView {
    [self whc_LeftSpace:left toView:toView];
    [self whc_TopSpace:top toView:toView];
    [self whc_Width:width];
    [self whc_Height:height];
}

- (void)whc_AutoSize:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom {
    [self whc_LeftSpace:left];
    [self whc_TopSpace:top];
    [self whc_RightSpace:right];
    [self whc_BottomSpace:bottom];
}

- (void)whc_AutoWidth:(CGFloat)left top:(CGFloat)top right:(CGFloat)right height:(CGFloat)height {
    [self whc_LeftSpace:left];
    [self whc_TopSpace:top];
    [self whc_RightSpace:right];
    [self whc_Height:height];
}

- (void)whc_AutoHeight:(CGFloat)left top:(CGFloat)top width:(CGFloat)width bottom:(CGFloat)bottom {
    [self whc_LeftSpace:left];
    [self whc_TopSpace:top];
    [self whc_Width:width];
    [self whc_BottomSpace:bottom];
}

- (void)whc_AutoSize:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom toView:(UIView *)toView {
    [self whc_LeftSpace:left toView:toView];
    [self whc_TopSpace:top toView:toView];
    [self whc_RightSpace:right toView:toView];
    [self whc_BottomSpace:bottom toView:toView];
}

- (void)whc_AutoWidth:(CGFloat)left top:(CGFloat)top right:(CGFloat)right height:(CGFloat)height toView:(UIView *)toView {
    [self whc_LeftSpace:left toView:toView];
    [self whc_TopSpace:top toView:toView];
    [self whc_RightSpace:right toView:toView];
    [self whc_Height:height];
}

- (void)whc_AutoHeight:(CGFloat)left top:(CGFloat)top width:(CGFloat)width bottom:(CGFloat)bottom toView:(UIView *)toView {
    [self whc_LeftSpace:left toView:toView];
    [self whc_TopSpace:top toView:toView];
    [self whc_Width:width];
    [self whc_BottomSpace:bottom toView:toView];
}

- (void)whc_ConstraintWithItem:(UIView *)item
                     attribute:(NSLayoutAttribute)attribute
                      constant:(CGFloat)constant {
    [self whc_ConstraintWithItem:self
                       attribute:attribute
                          toItem:item
                       attribute:attribute
                        constant:constant];
}

- (void)whc_ConstraintWithItem:(UIView *)item
                     attribute:(NSLayoutAttribute)attribute
                      constant:(CGFloat)constant
                    multiplier:(CGFloat)multiplier {
    [self whc_ConstraintWithItem:self
                       attribute:attribute
                          toItem:item
                       attribute:attribute
                        constant:constant
                      multiplier:multiplier];
}

- (void)whc_ConstraintWithItem:(UIView *)item
                     attribute:(NSLayoutAttribute)attribute
                        toItem:(UIView *)toItem
                     attribute:(NSLayoutAttribute)toAttribute
                      constant:(CGFloat)constant {
    [self whc_ConstraintWithItem:item
                       attribute:attribute
                       relatedBy:NSLayoutRelationEqual
                          toItem:toItem
                       attribute:toAttribute
                      multiplier:1
                        constant:constant];
}

- (void)whc_ConstraintWithItem:(UIView *)item
                     attribute:(NSLayoutAttribute)attribute
                        toItem:(UIView *)toItem
                     attribute:(NSLayoutAttribute)toAttribute
                      constant:(CGFloat)constant
                    multiplier:(CGFloat)multiplier {
    [self whc_ConstraintWithItem:item
                       attribute:attribute
                       relatedBy:NSLayoutRelationEqual
                          toItem:toItem
                       attribute:toAttribute
                      multiplier:multiplier
                        constant:constant];
}

- (void)whc_ConstraintWithItem:(UIView *)item
                     attribute:(NSLayoutAttribute)attribute
                     relatedBy:(NSLayoutRelation)related
                        toItem:(UIView *)toItem
                     attribute:(NSLayoutAttribute)toAttribute
                    multiplier:(CGFloat)multiplier
                      constant:(CGFloat)constant {
    UIView * superView = item.superview;
    if (toItem) {
        if (toItem.superview == nil) {
            superView = toItem;
        }else if (toItem.superview != item.superview) {
            superView = toItem;
        }
    }else {
        superView = item;
        toAttribute = NSLayoutAttributeNotAnAttribute;
    }
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    if (item && item.translatesAutoresizingMaskIntoConstraints) {
        item.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSLayoutConstraint * originConstraint = [self getOriginConstraintWithMainView:superView
                                                                             view:item
                                                                        attribute:attribute
                                                                        relatedBy:related
                                                                           toView:toItem
                                                                      toAttribute:toAttribute
                                                                       multiplier:multiplier
                                                                         constant:constant];
    if (originConstraint == nil) {
        NSLayoutConstraint * constraint = nil;
        constraint =[NSLayoutConstraint constraintWithItem:item
                                                 attribute:attribute
                                                 relatedBy:related
                                                    toItem:toItem
                                                 attribute:toAttribute
                                                multiplier:multiplier
                                                  constant:constant];
        [superView addConstraint:constraint];
        [self setCurrentConstraint:constraint];
    }else {
        [self setCurrentConstraint:originConstraint];
        if (originConstraint.constant != constant) {
            originConstraint.constant = constant;
        }
    }
    
    /// reset keep constraint
    [self setKeepRightConstraint:NO];
    [self setKeepWidthConstraint:NO];
    [self setKeepHeightConstraint:NO];
    [self setKeepBottomConstraint:NO];
}

- (NSLayoutConstraint *)getOriginConstraintWithMainView:(UIView *)mainView
                                                   view:(UIView *)view
                                              attribute:(NSLayoutAttribute)attribute
                                              relatedBy:(NSLayoutRelation)related
                                                 toView:(UIView *)toView
                                            toAttribute:(NSLayoutAttribute)toAttribute
                                             multiplier:(CGFloat)multiplier
                                               constant:(CGFloat)constant {
    
    NSLayoutConstraint * originConstraint = nil;
    if (mainView == nil) return originConstraint;
    NSArray * constraintArray = [mainView constraints];
    for (NSLayoutConstraint * constraint in constraintArray) {
        if (constraint.firstItem == view) {
            switch (attribute) {
                case NSLayoutAttributeLeft: {
                    if (constraint.firstAttribute == NSLayoutAttributeCenterX ||
                        constraint.firstAttribute == NSLayoutAttributeLeading ||
                        constraint.firstAttribute == NSLayoutAttributeTrailing) {
                        [mainView removeConstraint:constraint];
                    }
                }
                    break;
                case NSLayoutAttributeCenterX: {
                    if (constraint.firstAttribute == NSLayoutAttributeLeft ||
                        constraint.firstAttribute == NSLayoutAttributeLeading ||
                        constraint.firstAttribute == NSLayoutAttributeTrailing) {
                        [mainView removeConstraint:constraint];
                    }
                }
                    break;
                case NSLayoutAttributeLeading: {
                    if (constraint.firstAttribute == NSLayoutAttributeLeft ||
                        constraint.firstAttribute == NSLayoutAttributeCenterX ||
                        constraint.firstAttribute == NSLayoutAttributeTrailing) {
                        [mainView removeConstraint:constraint];
                    }
                }
                    break;
                case NSLayoutAttributeTrailing: {
                    if (constraint.firstAttribute == NSLayoutAttributeLeft ||
                        constraint.firstAttribute == NSLayoutAttributeCenterX ||
                        constraint.firstAttribute == NSLayoutAttributeLeading) {
                        [mainView removeConstraint:constraint];
                    }
                }
                    break;
                case NSLayoutAttributeTop: {
                    if (constraint.firstAttribute == NSLayoutAttributeCenterY ||
                        constraint.firstAttribute == NSLayoutAttributeBaseline) {
                        [mainView removeConstraint:constraint];
                    }
                }
                    break;
                case NSLayoutAttributeCenterY: {
                    if (constraint.firstAttribute == NSLayoutAttributeTop ||
                        constraint.firstAttribute == NSLayoutAttributeBaseline) {
                        [mainView removeConstraint:constraint];
                    }
                }
                    break;
                case NSLayoutAttributeBaseline: {
                    if (constraint.firstAttribute == NSLayoutAttributeTop ||
                        constraint.firstAttribute == NSLayoutAttributeCenterY) {
                        [mainView removeConstraint:constraint];
                    }
                }
                    break;
                case NSLayoutAttributeRight: {
                    if (constraint.firstAttribute == NSLayoutAttributeWidth && [NSStringFromClass(constraint.class) isEqualToString:@"NSIBPrototypingLayoutConstraint"]) {
                        [mainView removeConstraint:constraint];
                    }
                    if (![self keepWidthConstraint]) {
                        NSLayoutConstraint * equelWidthConstraint = [view equelWidthConstraint];
                        if (equelWidthConstraint) {
                            [mainView removeConstraint:equelWidthConstraint];
                            [view setEquelWidthConstraint:nil];
                        }
                        
                        NSLayoutConstraint * selfWidthConstraint = [view selfWidthConstraint];
                        if (selfWidthConstraint) {
                            [view removeConstraint:selfWidthConstraint];
                            [view setSelfWidthConstraint:nil];
                        }
                        NSLayoutConstraint * autoWidthConstraint = [view autoWidthConstraint];
                        if (autoWidthConstraint) {
                            [view removeConstraint:autoWidthConstraint];
                            [view setAutoWidthConstraint:nil];
                        }
                    }
                }
                    break;
                case NSLayoutAttributeWidth: {
                    if (![self keepRightConstraint]) {
                        NSLayoutConstraint * rightConstraint = [view rightConstraint];
                        if (rightConstraint) {
                            [view.superview removeConstraint:rightConstraint];
                            [view setRightConstraint:nil];
                        }
                    }
                    if (toView == nil) {
                        NSLayoutConstraint * equelWidthConstraint = [view equelWidthConstraint];
                        if (equelWidthConstraint) {
                            [view.superview removeConstraint:equelWidthConstraint];
                            [view setEquelWidthConstraint:nil];
                        }
                        switch (related) {
                            case NSLayoutRelationEqual: {
                                NSLayoutConstraint * autoWidthConstraint = [view autoWidthConstraint];
                                if (autoWidthConstraint && [NSStringFromClass(autoWidthConstraint.class) isEqualToString:@"NSLayoutConstraint"]) {
                                    [view removeConstraint:autoWidthConstraint];
                                    [view setAutoWidthConstraint:nil];
                                }
                            }
                                break;
                            case NSLayoutRelationGreaterThanOrEqual: {
                                NSLayoutConstraint * selfWidthConstraint = [view selfWidthConstraint];
                                if (selfWidthConstraint && [NSStringFromClass(selfWidthConstraint.class) isEqualToString:@"NSLayoutConstraint"]) {
                                    [view removeConstraint:selfWidthConstraint];
                                    [view setSelfWidthConstraint:nil];
                                }
                            }
                                break;
                            default:
                                break;
                        }
                        
                    }else {
                        NSLayoutConstraint * selfWidthConstraint = [view selfWidthConstraint];
                        if (selfWidthConstraint) {
                            [view removeConstraint:selfWidthConstraint];
                            [view setSelfWidthConstraint:nil];
                        }
                    }
                }
                    break;
                case NSLayoutAttributeBottom: {
                    if (constraint.firstAttribute == NSLayoutAttributeHeight && [NSStringFromClass(constraint.class) isEqualToString:@"NSIBPrototypingLayoutConstraint"]) {
                        [mainView removeConstraint:constraint];
                    }
                    if (![self keepHeightConstraint]) {
                        NSLayoutConstraint * equelHeightConstraint = [view equelHeightConstraint];
                        if (equelHeightConstraint) {
                            [mainView removeConstraint:equelHeightConstraint];
                            [view setEquelHeightConstraint:nil];
                        }
                        NSLayoutConstraint * selfHeightConstraint = [view selfHeightConstraint];
                        if (selfHeightConstraint) {
                            [view removeConstraint:selfHeightConstraint];
                            [view setSelfHeightConstraint:nil];
                        }
                        NSLayoutConstraint * autoHeightConstraint = [view autoHeightConstraint];
                        if (autoHeightConstraint) {
                            [view removeConstraint:autoHeightConstraint];
                            [view setAutoHeightConstraint:nil];
                        }
                    }
                }
                    break;
                case NSLayoutAttributeHeight: {
                    if (![self keepBottomConstraint]) {
                        NSLayoutConstraint * bottomConstraint = [view bottomConstraint];
                        if (bottomConstraint) {
                            [view.superview removeConstraint:bottomConstraint];
                            [view setBottomConstraint:nil];
                        }
                    }
                    if (toView) {
                        NSLayoutConstraint * selfHeightConstraint = [view selfHeightConstraint];
                        if (selfHeightConstraint) {
                            [view removeConstraint:selfHeightConstraint];
                            [view setSelfHeightConstraint:nil];
                        }
                    }else if(toView == nil) {
                        NSLayoutConstraint * equelHeightConstraint = [view equelHeightConstraint];
                        if (equelHeightConstraint) {
                            [view.superview removeConstraint:equelHeightConstraint];
                            [view setEquelHeightConstraint:nil];
                        }
                        switch (related) {
                            case NSLayoutRelationEqual: {
                                NSLayoutConstraint * autoHeightConstraint = [view autoHeightConstraint];
                                if (autoHeightConstraint && [NSStringFromClass(autoHeightConstraint.class) isEqualToString:@"NSLayoutConstraint"]) {
                                    [view removeConstraint:autoHeightConstraint];
                                    [view setAutoHeightConstraint:nil];
                                }
                            }
                                break;
                            case NSLayoutRelationGreaterThanOrEqual: {
                                NSLayoutConstraint * selfHeightConstraint = [view selfHeightConstraint];
                                if (selfHeightConstraint && [NSStringFromClass(selfHeightConstraint.class) isEqualToString:@"NSLayoutConstraint"]) {
                                    [view removeConstraint:selfHeightConstraint];
                                    [view setSelfHeightConstraint:nil];
                                }
                            }
                                break;
                            default:
                                break;
                        }
                    }
                }
                    break;
                default:
                    break;
                }
                if (toView) {
                    if (constraint.firstAttribute == attribute &&
                        constraint.secondItem == toView &&
                        constraint.secondAttribute == toAttribute) {
                        if (constraint.multiplier == multiplier) {
                            originConstraint = constraint;
                        }else {
                            [mainView removeConstraint:constraint];
                        }
                    }else if ((constraint.firstAttribute == attribute)) {
                        [mainView removeConstraint:constraint];
                    }
                }else {
                    if (constraint.firstAttribute == attribute &&
                        constraint.relation == related) {
                        switch (related) {
                            case NSLayoutRelationEqual:
                                if ([NSStringFromClass(constraint.class) isEqualToString:@"NSLayoutConstraint"]) {
                                    originConstraint = constraint;
                                }
                                break;
                            case NSLayoutRelationGreaterThanOrEqual:
                                if ([NSStringFromClass(constraint.class) isEqualToString:@"NSContentSizeLayoutConstraint"]) {
                                    originConstraint = constraint;
                                }
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
        }
        return originConstraint;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method addConstraint = class_getInstanceMethod(self, @selector(addConstraint:));
        Method whc_AddConstraint = class_getInstanceMethod(self, @selector(whc_AddConstraint:));
        method_exchangeImplementations(addConstraint, whc_AddConstraint);
    });
}

- (void)handleXibConstraint:(NSLayoutAttribute)attribute {
    UIView * superView = self.superview;
    if (superView != nil) {
        NSArray<NSLayoutConstraint *> * constraintArray = superView.constraints;
        [constraintArray enumerateObjectsUsingBlock:^(NSLayoutConstraint * _Nonnull constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([NSStringFromClass(constraint.class) isEqualToString:@"NSIBPrototypingLayoutConstraint"] &&
                constraint.firstItem == self &&
                constraint.firstAttribute == attribute &&
                constraint.secondItem == nil) {
                [superView removeConstraint:constraint];
                *stop = YES;
            }
        }];
    }
}

- (void)whc_AddConstraint:(NSLayoutConstraint *)constraint {
    NSString * constraintClassString = NSStringFromClass(constraint.class);
    if ([constraintClassString hasPrefix:@"NS"]) {
        switch (constraint.firstAttribute) {
            case NSLayoutAttributeHeight: {
                if ([constraintClassString isEqualToString:@"NSContentSizeLayoutConstraint"]) {
                    for (NSLayoutConstraint * selfConstraint in self.constraints) {
                        if (selfConstraint.firstAttribute == NSLayoutAttributeHeight &&
                            selfConstraint.relation == constraint.relation && [NSStringFromClass(selfConstraint.class) isEqualToString:@"NSContentSizeLayoutConstraint"]) {
                            return;
                        }
                    }
                    [self whc_AddConstraint:constraint];
                    return;
                }else {
                    /*[self handleXibConstraint:NSLayoutAttributeHeight];*/
                    switch (constraint.relation) {
                        case NSLayoutRelationEqual: {
                            if (constraint.secondItem == nil) {
                                [self setSelfHeightConstraint:constraint];
                            }else {
                                [constraint.firstItem setEquelHeightConstraint:constraint];
                            }
                        }
                            break;
                        case NSLayoutRelationGreaterThanOrEqual: {
                            [self setAutoHeightConstraint:constraint];
                        }
                            break;
                        default:
                            break;
                    }
                }
            }
                break;
            case NSLayoutAttributeWidth: {
                if ([NSStringFromClass(constraint.class) isEqualToString:@"NSContentSizeLayoutConstraint"]) {
                    for (NSLayoutConstraint * selfConstraint in self.constraints) {
                        if (selfConstraint.firstAttribute == NSLayoutAttributeWidth &&
                            selfConstraint.relation == constraint.relation && [NSStringFromClass(selfConstraint.class) isEqualToString:@"NSContentSizeLayoutConstraint"]) {
                            return;
                        }
                    }
                    [self whc_AddConstraint:constraint];
                    return;
                }else {
                    /*[self handleXibConstraint:NSLayoutAttributeWidth];*/
                    switch (constraint.relation) {
                        case NSLayoutRelationEqual: {
                            if (constraint.secondItem == nil) {
                                [self setSelfWidthConstraint:constraint];
                            }else {
                                [constraint.firstItem setEquelWidthConstraint:constraint];
                            }
                        }
                            break;
                        case NSLayoutRelationGreaterThanOrEqual: {
                            [self setAutoWidthConstraint:constraint];
                        }
                            break;
                        default:
                            break;
                    }
                }
            }
                break;
            case NSLayoutAttributeRight: {
                if ([constraint.firstItem respondsToSelector:@selector(setRightConstraint:)]) {
                    [constraint.firstItem setRightConstraint:constraint];
                }
            }
                break;
            case NSLayoutAttributeBottom: {
                if ([constraint.firstItem respondsToSelector:@selector(setBottomConstraint:)]) {
                    [constraint.firstItem setBottomConstraint:constraint];
                }
            }
                break;
            default:
                break;
        }
    }
    [self whc_AddConstraint:constraint];
}

- (void)setRightConstraint:(NSLayoutConstraint *)constraint {
   objc_setAssociatedObject(self, @selector(rightConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)rightConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBottomConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(bottomConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)bottomConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEquelWidthConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(equelWidthConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)equelWidthConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAutoWidthConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(autoWidthConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)autoWidthConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSelfWidthConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(selfWidthConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)selfWidthConstraint {
    return objc_getAssociatedObject(self, _cmd);
}



- (void)setEquelHeightConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(equelHeightConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)equelHeightConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAutoHeightConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(autoHeightConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)autoHeightConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSelfHeightConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(selfHeightConstraint), constraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)selfHeightConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setKeepHeightConstraint:(BOOL)keepHeightConstraint {
    objc_setAssociatedObject(self, @selector(keepHeightConstraint), @(keepHeightConstraint), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)keepHeightConstraint {
    NSNumber * value = objc_getAssociatedObject(self, _cmd);
    return value != nil ? value.boolValue : NO;
}

- (void)setKeepBottomConstraint:(BOOL)keepBottomConstraint {
    objc_setAssociatedObject(self, @selector(keepBottomConstraint), @(keepBottomConstraint), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)keepBottomConstraint {
    NSNumber * value = objc_getAssociatedObject(self, _cmd);
    return value != nil ? value.boolValue : NO;
}

- (void)setKeepWidthConstraint:(BOOL)keepWidthConstraint {
    objc_setAssociatedObject(self, @selector(keepWidthConstraint), @(keepWidthConstraint), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)keepWidthConstraint {
    NSNumber * value = objc_getAssociatedObject(self, _cmd);
    return value != nil ? value.boolValue : NO;
}

- (void)setKeepRightConstraint:(BOOL)keepRightConstraint {
    objc_setAssociatedObject(self, @selector(keepRightConstraint), @(keepRightConstraint), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)keepRightConstraint {
    NSNumber * value = objc_getAssociatedObject(self, _cmd);
    return value != nil ? value.boolValue : NO;
}

#pragma mark - Xib智能布局模块 -

- (void)whc_AutoXibLayout {
#if kDeprecatedVerticalAdapter
    [self whc_AutoXibLayoutType:DefaultType];
#else
    [self whc_AutoXibHorizontalLayout];
#endif
}

- (void)whc_AutoXibLayoutType:(WHC_LayoutTypeOptions)type {
#if kDeprecatedVerticalAdapter
    [self whc_RunLayoutEngineWithOrientation:All layoutType:type nibType:XIB];
#else
    [self whc_RunLayoutEngineWithOrientation:Horizontal layoutType:type nibType:XIB];
#endif
    
}

- (void)whc_AutoXibHorizontalLayout {
    [self whc_AutoXibHorizontalLayoutType:DefaultType];
}

- (void)whc_AutoXibHorizontalLayoutType:(WHC_LayoutTypeOptions)type {
    [self whc_RunLayoutEngineWithOrientation:Horizontal layoutType:type nibType:XIB];
}

- (void)whc_AutoSBLayout {
#if kDeprecatedVerticalAdapter
    [self whc_AutoSBLayoutType:DefaultType];
#else
    [self whc_AutoSBHorizontalLayout];
#endif
}

- (void)whc_AutoSBLayoutType:(WHC_LayoutTypeOptions)type {
    CGRect initRect = self.bounds;
    self.bounds = CGRectMake(0, 0, 375, 667);
#if kDeprecatedVerticalAdapter
    [self whc_RunLayoutEngineWithOrientation:All layoutType:type nibType:SB];
#else
    [self whc_RunLayoutEngineWithOrientation:Horizontal layoutType:type nibType:SB];
#endif
    
    self.bounds = initRect;
}

- (void)whc_AutoSBHorizontalLayout {
    [self whc_AutoSBHorizontalLayoutType:DefaultType];
}

- (void)whc_AutoSBHorizontalLayoutType:(WHC_LayoutTypeOptions)type {
    CGRect initRect = self.bounds;
    self.bounds = CGRectMake(0, 0, 375, 667);
    [self whc_RunLayoutEngineWithOrientation:Horizontal layoutType:type nibType:SB];
    self.bounds = initRect;
}

- (void)whc_RunLayoutEngineWithOrientation:(WHC_LayoutOrientationOptions)orientation
                                layoutType:(WHC_LayoutTypeOptions)layoutType
                                   nibType:(WHCNibType)nibType {
    NSMutableArray  * subViewArray = [NSMutableArray array];
    if (nibType == SB) {
        for (NSObject * view in self.subviews) {
            if (![NSStringFromClass(view.class) isEqualToString:@"_UILayoutGuide"]) {
                [subViewArray addObject:view];
            }
        }
    }else {
        [subViewArray addObjectsFromArray:self.subviews];
    }
    NSMutableArray  * rowViewArray = [NSMutableArray array];
    for (NSInteger i = 0; i < subViewArray.count; i++) {
        UIView * subView = subViewArray[i];
        if(rowViewArray.count == 0) {
            NSMutableArray * subRowViewArray = [NSMutableArray array];
            [subRowViewArray addObject:subView];
            [rowViewArray addObject:subRowViewArray];
        }else{
            BOOL isAddSubView = NO;
            for (NSInteger j = 0; j < rowViewArray.count; j++) {
                NSMutableArray  * subRowViewArray = rowViewArray[j];
                BOOL  isAtRow = YES;
                for (NSInteger w = 0; w < subRowViewArray.count; w++) {
                    UIView * rowSubView = subRowViewArray[w];
                    if(CGRectGetMinY(subView.frame) > rowSubView.center.y ||
                       CGRectGetMaxY(subView.frame) < rowSubView.center.y){
                        isAtRow = NO;
                        break;
                    }
                }
                if(isAtRow) {
                    isAddSubView = YES;
                    [subRowViewArray addObject:subView];
                    break;
                }
            }
            if(!isAddSubView) {
                NSMutableArray * subRowViewArr = [NSMutableArray array];
                [subRowViewArr addObject:subView];
                [rowViewArray addObject:subRowViewArr];
            }
        }
    }
    
    NSInteger rowCount = rowViewArray.count;
    for(NSInteger row = 0; row < rowCount; row++){
        NSMutableArray  * subRowViewArray = rowViewArray[row];
        NSInteger columnCount = subRowViewArray.count;
        for (NSInteger column = 0; column < columnCount; column++) {
            for (NSInteger j = column + 1; j < columnCount; j++) {
                UIView  * view1 = subRowViewArray[column];
                UIView  * view2 = subRowViewArray[j];
                if(view1.center.x > view2.center.x){
                    [subRowViewArray exchangeObjectAtIndex:column withObjectAtIndex:j];
                }
            }
        }
    }

    UIView * frontRowView = nil;
    UIView * nextRowView = nil;
    
    for (NSInteger row = 0; row < rowCount; row++) {
        NSArray * subRowViewArray = rowViewArray[row];
        NSInteger columnCount = subRowViewArray.count;
        for (NSInteger column = 0; column < columnCount; column++) {
            UIView * view = subRowViewArray[column];
            CGFloat superWidthHalf = CGRectGetWidth(view.superview.frame) / 2;
            UIView * nextColumnView = nil;
            UIView * frontColumnView = nil;
            frontRowView = nil;
            nextRowView = nil;
            BOOL canFitWidthOrHeight = [self canFitWidthOrHeightWithView:view];
            if (row < rowCount - 1) {
                nextRowView = [self getNextRowView:rowViewArray[row + 1] currentView:view];
            }
            if (column < columnCount - 1) {
                nextColumnView = subRowViewArray[column + 1];
            }
            if (row == 0) {
                [view whc_TopSpace:CGRectGetMinY(view.frame)];
            }else {
                frontRowView = [self getFrontRowView:rowViewArray[row - 1] currentView:view];
                [view whc_TopSpace:CGRectGetMinY(view.frame) - CGRectGetMaxY(frontRowView.frame)
                      toView:frontRowView];
            }
            if (column == 0) {
                if (!canFitWidthOrHeight && layoutType == LeftRightType) {
                    if (view.center.x == superWidthHalf) {
                        [view whc_CenterX:0];
                    } else if (view.center.x > superWidthHalf) {
                        if (nextColumnView) {
                            [view whc_TrailingSpace:CGRectGetMinX(nextColumnView.frame) - CGRectGetMaxX(view.frame) toView:nextColumnView];
                        }else {
                            [view whc_TrailingSpace:CGRectGetWidth(view.superview.frame) - CGRectGetMaxX(view.frame)];
                        }
                    }
                }else {
                    [view whc_LeftSpace:CGRectGetMinX(view.frame)];
                }
            }else {
                frontColumnView = subRowViewArray[column - 1];
                if (!canFitWidthOrHeight && layoutType == LeftRightType) {
                    if (view.center.x == superWidthHalf) {
                        [view whc_CenterX:0];
                    }else if (view.center.x > superWidthHalf) {
                        if (nextColumnView) {
                            [view whc_TrailingSpace:CGRectGetMinX(nextColumnView.frame) - CGRectGetMaxX(view.frame) toView:nextColumnView];
                        }else {
                            [view whc_TrailingSpace:CGRectGetWidth(view.superview.frame) - CGRectGetMaxX(view.frame)];
                        }
                    }
                }else {
                    [view whc_LeftSpace:CGRectGetMinX(view.frame) - CGRectGetMaxX(frontColumnView.frame)
                           toView:frontColumnView];
                }
            }
            if (orientation == All ||
                orientation == Vertical) {
                if (canFitWidthOrHeight) {
                    if (nextRowView) {
                        [view whc_HeightEqualView:nextRowView
                                            ratio:CGRectGetHeight(view.frame) / CGRectGetHeight(nextRowView.frame)];
                    }else {
                        [view whc_BottomSpace:CGRectGetHeight(view.superview.frame) - CGRectGetMaxY(view.frame)];
                    }
                }else {
                    [view whc_Height:CGRectGetHeight(view.frame)];
                }
                goto WHC_FIT_WIDTH;
            }else {
            WHC_FIT_WIDTH:
                if (canFitWidthOrHeight) {
                    [view whc_RightSpace:CGRectGetWidth(view.superview.frame) - CGRectGetMaxX(view.frame)];
                }else {
                    [view whc_Width:CGRectGetWidth(view.frame)];
                }
                [view whc_Height:CGRectGetHeight(view.frame)];
            }
            if ([view isKindOfClass:[UITableViewCell class]] ||
                (view.subviews.count > 0 && ([NSStringFromClass(view.class) isEqualToString:@"UIView"] ||
                                             [NSStringFromClass(view.class) isEqualToString:@"UIScrollView"])) ||
                [NSStringFromClass(view.class) isEqualToString:@"UITableViewCellContentView"]) {
                [view whc_RunLayoutEngineWithOrientation:orientation layoutType:layoutType nibType:nibType];
            }
        }
    }
}

- (BOOL)canFitWidthOrHeightWithView:(UIView *) view {
    if ([view isKindOfClass:[UIImageView class]] ||
        (([view isKindOfClass:[UIButton class]] &&
          (((UIButton *)view).layer.cornerRadius == CGRectGetWidth(view.frame) / 2 ||
           ((UIButton *)view).layer.cornerRadius == CGRectGetHeight(view.frame) / 2 ||
           CGRectGetWidth(view.frame) == CGRectGetHeight(view.frame) ||
           [((UIButton *)view) backgroundImageForState:UIControlStateNormal])))) {
              return NO;
          }
    return YES;
}


- (UIView *)getFrontRowView:(NSArray *)rowViewArray
                currentView:(UIView *)currentView {
    if (currentView) {
        NSInteger columnCount = rowViewArray.count;
        NSInteger currentViewY = CGRectGetMinY(currentView.frame);
        for (NSInteger row = 0; row < columnCount; row++) {
            UIView * view = rowViewArray[row];
            if (CGRectContainsPoint(currentView.frame, CGPointMake(CGRectGetMinX(view.frame), currentViewY)) ||
                CGRectContainsPoint(currentView.frame, CGPointMake(view.center.x, currentViewY)) ||
                CGRectContainsPoint(currentView.frame, CGPointMake(CGRectGetMaxX(view.frame), currentViewY))) {
                return view;
            }
        }
    }else {
        return nil;
    }
    return rowViewArray[0];
}

- (UIView *)getNextRowView:(NSArray *)rowViewArray
               currentView:(UIView *)currentView {
    return [self getFrontRowView:rowViewArray currentView:currentView];
}


#pragma mark - 自动加边线模块 -

static const int kLeft_Line_Tag = 100000;
static const int kRight_Line_Tag = kLeft_Line_Tag + 1;
static const int kTop_Line_Tag = kRight_Line_Tag + 1;
static const int kBottom_Line_Tag = kTop_Line_Tag + 1;

- (WHC_Line *)createLineWithTag:(int)lineTag {
    WHC_Line * line = nil;
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[WHC_Line class]] &&
            view.tag == lineTag) {
            line = (WHC_Line *)view;
            break;
        }
    }
    if (line == nil) {
        line = [WHC_Line new];
        line.tag = lineTag;
        [self addSubview:line];
    }
    return line;
}

- (UIView *)whc_AddBottomLine:(CGFloat)value lineColor:(UIColor *)color {
    return [self whc_AddBottomLine:value lineColor:color pading:0];
}

- (UIView *)whc_AddBottomLine:(CGFloat)value lineColor:(UIColor *)color pading:(CGFloat)pading {
    WHC_Line * line = [self createLineWithTag:kBottom_Line_Tag];
    line.backgroundColor = color;
    [line whc_RightSpace:pading];
    [line whc_LeftSpace:pading];
    [line whc_Height:value];
    [line whc_BaseLineSpace:0];
    return line;
}

- (UIView *)whc_AddTopLine:(CGFloat)value lineColor:(UIColor *)color {
    return [self whc_AddTopLine:value lineColor:color pading:0];
}

- (UIView *)whc_AddTopLine:(CGFloat)value lineColor:(UIColor *)color pading:(CGFloat)pading {
    WHC_Line * line = [self createLineWithTag:kTop_Line_Tag];
    line.backgroundColor = color;
    [line whc_RightSpace:pading];
    [line whc_LeftSpace:pading];
    [line whc_Height:value];
    [line whc_TopSpace:0];
    return line;
}

- (UIView *)whc_AddLeftLine:(CGFloat)value lineColor:(UIColor *)color padding:(CGFloat)padding
{
    WHC_Line * line = [self createLineWithTag:kLeft_Line_Tag];
    line.backgroundColor = color;
    [line whc_Width:value];
    [line whc_LeftSpace:0];
    [line whc_TopSpace:padding];
    [line whc_BottomSpace:padding];
    return line;
}

- (UIView *)whc_AddLeftLine:(CGFloat)value lineColor:(UIColor *)color {
    WHC_Line * line = [self createLineWithTag:kLeft_Line_Tag];
    line.backgroundColor = color;
    [line whc_Width:value];
    [line whc_LeftSpace:0];
    [line whc_TopSpace:0];
    [line whc_BottomSpace:0];
    return line;
}

- (UIView *)whc_AddRightLine:(CGFloat)value lineColor:(UIColor *)color {
    WHC_Line * line = [self createLineWithTag:kRight_Line_Tag];
    line.backgroundColor = color;
    [line whc_Width:value];
    [line whc_TrailingSpace:0];
    [line whc_TopSpace:0];
    [line whc_BottomSpace:0];
    return line;
}

- (UIView *)whc_AddRightLine:(CGFloat)value lineColor:(UIColor *)color padding:(CGFloat)padding
{
    WHC_Line * line = [self createLineWithTag:kRight_Line_Tag];
    line.backgroundColor = color;
    [line whc_Width:value];
    [line whc_TrailingSpace:0];
    [line whc_TopSpace:padding];
    [line whc_BottomSpace:padding];
    return line;
}

@end






