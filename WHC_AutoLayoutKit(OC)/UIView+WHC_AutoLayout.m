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

// VERSION:(2.0)

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


- (Width)whc_Width {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf whc_Width:value];
        return weakSelf;
    };
}

- (WidthAuto)whc_widthAuto {
    __weak typeof(self) weakSelf = self;
    return ^() {
        [weakSelf whc_WidthAuto];
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


- (Height)whc_Height {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value) {
        [weakSelf whc_Height:value];
        return weakSelf;
    };
}

- (HeightAuto)whc_heightAuto {
    __weak typeof(self) weakSelf = self;
    return ^() {
        [weakSelf whc_HeightAuto];
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

#pragma mark - api version 1.0 -
- (void)whc_AutoContentSize {
    if ([self isKindOfClass:[UIScrollView class]]) {
        [self layoutIfNeeded];
        NSArray * subViews = self.subviews;
        CGFloat contentHeight = 0;
        CGFloat contentWidth = 0;
        if (subViews.count > 0) {
            UIView * bottomView = subViews[0];
            for (int i = 1; i < subViews.count; i++) {
                UIView * view = subViews[i];
                if (CGRectGetMaxY(bottomView.frame) < CGRectGetMaxY(view.frame)) {
                    contentHeight = CGRectGetMaxY(view.frame);
                }
                if (CGRectGetMaxX(bottomView.frame) < CGRectGetMaxX(view.frame)) {
                    contentWidth = CGRectGetMaxX(view.frame);
                }
            }
        }
        ((UIScrollView *)self).contentSize = CGSizeMake(contentWidth, contentHeight);
    }else {
        NSLog(@"whc_AutoContentSize 只对UIScrollview有效");
    }
}

- (void)whc_LeftSpace:(CGFloat)leftSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeLeft
                        constant:leftSpace];
}

- (void)whc_LeftSpace:(CGFloat)leftSpace toView:(UIView *)toView {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeLeft
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:NSLayoutAttributeRight
                      multiplier:1
                        constant:leftSpace];
}

- (void)whc_LeftSpaceEqualView:(UIView *)view {
//    [self whc_LeadingSpaceEqualView:view];
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeLeft
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeLeft
                      multiplier:1
                        constant:0];
}

- (void)whc_RightSpace:(CGFloat)rightSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeRight
                        constant:0.0 - rightSpace];
}

- (void)whc_RightSpace:(CGFloat)rightSpace toView:(UIView *)toView {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeRight
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:NSLayoutAttributeRight
                      multiplier:1
                        constant:0.0 - rightSpace];
}

- (void)whc_RightSpaceEqualView:(UIView *)view {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeRight
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeRight
                      multiplier:1
                        constant:0];
}

- (void)whc_LeadingSpace:(CGFloat)leadingSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeLeading
                        constant:leadingSpace];
}

- (void)whc_LeadingSpace:(CGFloat)leadingSpace
            toView:(UIView *)toView {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeLeading
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:NSLayoutAttributeTrailing
                      multiplier:1
                        constant:leadingSpace];
}

- (void)whc_LeadingSpaceEqualView:(UIView *)view {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeLeading
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeLeading
                      multiplier:1
                        constant:0];
}

- (void)whc_TrailingSpace:(CGFloat)trailingSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeTrailing
                        constant:0.0 - trailingSpace];
}

- (void)whc_TrailingSpace:(CGFloat)trailingSpace
             toView:(UIView *)toView {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeTrailing
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:NSLayoutAttributeLeading
                      multiplier:1
                        constant:0.0 - trailingSpace];
}

- (void)whc_TrailingSpaceEqualView:(UIView *)view {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeTrailing
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeTrailing
                      multiplier:1
                        constant:0];
}


- (void)whc_TopSpace:(CGFloat)topSpace {
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeTop
                        constant:topSpace];
}

- (void)whc_TopSpace:(CGFloat)topSpace toView:(UIView *)toView {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeTop
                       relatedBy:NSLayoutRelationEqual
                          toItem:toView
                       attribute:NSLayoutAttributeBottom
                      multiplier:1
                        constant:topSpace];
}

- (void)whc_TopSpaceEqualView:(UIView *)view {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeTop
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeTop
                      multiplier:1
                        constant:0];
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
                       attribute:NSLayoutAttributeBottom
                      multiplier:1
                        constant:0.0 - bottomSpace];
}

- (void)whc_BottomSpaceEqualView:(UIView *)view {
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeBottom
                       relatedBy:NSLayoutRelationEqual
                          toItem:view
                       attribute:NSLayoutAttributeBottom
                      multiplier:1
                        constant:0];
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

- (void)whc_WidthAuto {
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

- (void)whc_HeightAuto {
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
    [self whc_ConstraintWithItem:view
                       attribute:NSLayoutAttributeLastBaseline
                        constant:0];
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
        if (attribute == toAttribute) {
            switch (attribute) {
                case NSLayoutAttributeRight:
                case NSLayoutAttributeBottom:
                    superView = toItem;
                    break;
                default:
                    break;
            }
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
        if (attribute == 8 && [item isKindOfClass:[UIImageView class]] && superView.constraints.count > 0) {
            NSLog(@"");
        }
        [superView addConstraint:constraint];
    }else {
        if (originConstraint.constant != constant) {
            originConstraint.constant = constant;
        }
    }
}

- (NSLayoutConstraint *)getOriginConstraintWithMainView:(UIView *)mainView
                                                   view:(UIView *)view
                                              attribute:(NSLayoutAttribute)attribute
                                              relatedBy:(NSLayoutRelation)related
                                                 toView:(UIView *)toView
                                            toAttribute:(NSLayoutAttribute)toAttribute
                                             multiplier:(CGFloat)multiplier
                                               constant:(CGFloat)constant {
    NSAssert(mainView, @"mainView can not nil");
    NSLayoutConstraint * originConstraint = nil;
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
                    if (constraint.firstAttribute == NSLayoutAttributeWidth) {
                        [mainView removeConstraint:constraint];
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
                    break;
                case NSLayoutAttributeWidth: {
                    NSLayoutConstraint * rightConstraint = [view rightConstraint];
                    if (rightConstraint) {
                        [view.superview removeConstraint:rightConstraint];
                        [view setRightConstraint:nil];
                    }
                    if (toView == nil) {
                        switch (related) {
                            case NSLayoutRelationEqual: {
                                NSLayoutConstraint * equelWidthConstraint = [view equelWidthConstraint];
                                if (equelWidthConstraint) {
                                    [view.superview removeConstraint:equelWidthConstraint];
                                    [view setEquelWidthConstraint:nil];
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
                    if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                        [mainView removeConstraint:constraint];
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
                    break;
                case NSLayoutAttributeHeight: {
                    NSLayoutConstraint * bottomConstraint = [view bottomConstraint];
                    if (bottomConstraint) {
                        [view.superview removeConstraint:bottomConstraint];
                        [view setBottomConstraint:nil];
                    }
                    if (toView) {
                        NSLayoutConstraint * selfHeightConstraint = [view selfHeightConstraint];
                        if (selfHeightConstraint) {
                            [view removeConstraint:selfHeightConstraint];
                            [view setSelfHeightConstraint:nil];
                        }
                    }else if(toView == nil) {
                        switch (related) {
                            case NSLayoutRelationEqual: {
                                NSLayoutConstraint * equelHeightConstraint = [view equelHeightConstraint];
                                if (equelHeightConstraint) {
                                    [view.superview removeConstraint:equelHeightConstraint];
                                    [view setEquelHeightConstraint:nil];
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
                    if (constraint.firstAttribute == attribute) {
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

- (void)whc_AddConstraint:(NSLayoutConstraint *)constraint {
    switch (constraint.firstAttribute) {
        case NSLayoutAttributeHeight: {
            if ([NSStringFromClass(constraint.class) isEqualToString:@"NSContentSizeLayoutConstraint"]) {
                for (NSLayoutConstraint * selfConstraint in self.constraints) {
                    if (selfConstraint.firstAttribute == NSLayoutAttributeHeight &&
                        selfConstraint.relation == NSLayoutRelationEqual) {
                        return;
                    }
                }
                [self whc_AddConstraint:constraint];
                return;
            }else {
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
                        selfConstraint.relation == NSLayoutRelationEqual) {
                        return;
                    }
                }
                [self whc_AddConstraint:constraint];
                return;
            }else {
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
            [constraint.firstItem setRightConstraint:constraint];
        }
            break;
        case NSLayoutAttributeBottom: {
            [constraint.firstItem setBottomConstraint:constraint];
        }
            break;
        default:
            break;
    }
    [self whc_AddConstraint:constraint];
}

- (void)setRightConstraint:(NSLayoutConstraint *)constraint {
   objc_setAssociatedObject(self, @selector(rightConstraint), constraint, OBJC_ASSOCIATION_RETAIN);
}

- (NSLayoutConstraint *)rightConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBottomConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(bottomConstraint), constraint, OBJC_ASSOCIATION_RETAIN);
}

- (NSLayoutConstraint *)bottomConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEquelWidthConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(equelWidthConstraint), constraint, OBJC_ASSOCIATION_RETAIN);
}

- (NSLayoutConstraint *)equelWidthConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAutoWidthConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(autoWidthConstraint), constraint, OBJC_ASSOCIATION_RETAIN);
}

- (NSLayoutConstraint *)autoWidthConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSelfWidthConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(selfWidthConstraint), constraint, OBJC_ASSOCIATION_RETAIN);
}

- (NSLayoutConstraint *)selfWidthConstraint {
    return objc_getAssociatedObject(self, _cmd);
}



- (void)setEquelHeightConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(equelHeightConstraint), constraint, OBJC_ASSOCIATION_RETAIN);
}

- (NSLayoutConstraint *)equelHeightConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAutoHeightConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(autoHeightConstraint), constraint, OBJC_ASSOCIATION_RETAIN);
}

- (NSLayoutConstraint *)autoHeightConstraint {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSelfHeightConstraint:(NSLayoutConstraint *)constraint {
    objc_setAssociatedObject(self, @selector(selfHeightConstraint), constraint, OBJC_ASSOCIATION_RETAIN);
}

- (NSLayoutConstraint *)selfHeightConstraint {
    return objc_getAssociatedObject(self, _cmd);
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

- (UIView *)whc_BottomLine:(CGFloat)value lineColor:(UIColor *)color {
    return [self whc_BottomLine:value lineColor:color pading:0];
}

- (UIView *)whc_BottomLine:(CGFloat)value lineColor:(UIColor *)color pading:(CGFloat)pading {
    WHC_Line * line = [self createLineWithTag:kBottom_Line_Tag];
    line.backgroundColor = color;
    [line whc_RightSpace:pading];
    [line whc_LeftSpace:pading];
    [line whc_Height:value];
    [line whc_BaseLineSpace:value];
    return line;
}

- (UIView *)whc_TopLine:(CGFloat)value lineColor:(UIColor *)color {
    return [self whc_TopLine:value lineColor:color pading:0];
}

- (UIView *)whc_TopLine:(CGFloat)value lineColor:(UIColor *)color pading:(CGFloat)pading {
    WHC_Line * line = [self createLineWithTag:kTop_Line_Tag];
    line.backgroundColor = color;
    [line whc_RightSpace:pading];
    [line whc_LeftSpace:pading];
    [line whc_Height:value];
    [line whc_TopSpace:0];
    return line;
}

- (UIView *)whc_LeftLine:(CGFloat)value lineColor:(UIColor *)color {
    WHC_Line * line = [self createLineWithTag:kLeft_Line_Tag];
    line.backgroundColor = color;
    [line whc_Width:value];
    [line whc_LeftSpace:0];
    [line whc_TopSpace:0];
    [line whc_BottomSpace:0];
    return line;
}

- (UIView *)whc_RightLine:(CGFloat)value lineColor:(UIColor *)color {
    WHC_Line * line = [self createLineWithTag:kRight_Line_Tag];
    line.backgroundColor = color;
    [line whc_Width:value];
    [line whc_TrailingSpace:value];
    [line whc_TopSpace:0];
    [line whc_BottomSpace:0];
    return line;
}

@end






