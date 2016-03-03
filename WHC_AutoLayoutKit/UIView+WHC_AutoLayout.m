//
//  UIView+WHC_AutoLayout.m
//  WHC_AutoAdpaterViewDemo
//
//  Created by 吴海超 on 16/1/16.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*
 *  qq:712641411
 *  开发作者: 吴海超(WHC)
 *  iOS技术交流群:302157745
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit
 */

#import "UIView+WHC_AutoLayout.h"
#import <objc/runtime.h>

WHCRect WHCRectMake(CGFloat left ,
                    CGFloat top ,
                    CGFloat width,
                    CGFloat height) {
    WHCRect rect;
    rect.left = left;
    rect.top = top;
    rect.width = width;
    rect.height = height;
    return rect;
}


WHCAutoRect WHCAutoRectMake(CGFloat left ,
                            CGFloat top ,
                            CGFloat right,
                            CGFloat bottom) {
    WHCAutoRect rect;
    rect.left = left;
    rect.top = top;
    rect.right = right;
    rect.bottom = bottom;
    return rect;
}

WHCWidthAutoRect WHCWidthAutoRectMake(CGFloat left ,
                                      CGFloat top ,
                                      CGFloat right,
                                      CGFloat height) {
    WHCWidthAutoRect rect;
    rect.left = left;
    rect.top = top;
    rect.right = right;
    rect.height = height;
    return rect;
}

WHCHeightAutoRect WHCHeightAutoRectMake(CGFloat left ,
                                        CGFloat top ,
                                        CGFloat width,
                                        CGFloat bottom) {
    WHCHeightAutoRect rect;
    rect.left = left;
    rect.top = top;
    rect.width = width;
    rect.bottom = bottom;
    return rect;
}

#pragma mark - UI自动布局 -

@implementation UIView (WHC_AutoLayout)

- (void)setWhc_WidthWeight:(CGFloat)whc_WidthWeight {
    objc_setAssociatedObject(self,
                             @selector(whc_WidthWeight),
                             @(whc_WidthWeight),
                             OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)whc_WidthWeight {
    CGFloat weight = [objc_getAssociatedObject(self, _cmd) floatValue];
    if (weight == 0) {
        weight = 1;
    }
    return weight;
}

- (void)setWhc_HeightWeight:(CGFloat)whc_HeightWeight {
    objc_setAssociatedObject(self,
                             @selector(whc_HeightWeight),
                             @(whc_HeightWeight),
                             OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)whc_HeightWeight {
    CGFloat weight = [objc_getAssociatedObject(self, _cmd) floatValue];
    if (weight == 0) {
        weight = 1;
    }
    return weight;
}


- (void)whc_X:(CGFloat)x {
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeCenterX];
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeLeft
                        constant:x];
}

- (void)whc_X:(CGFloat)x relativeView:(UIView *)relativeView {
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeCenterX];
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeLeft
                       relatedBy:NSLayoutRelationEqual
                          toItem:relativeView
                       attribute:NSLayoutAttributeRight
                      multiplier:1
                        constant:x];
}

- (void)whc_LeftSpace:(CGFloat)leftSpace {
    [self whc_X:leftSpace];
}

- (void)whc_LeftSpace:(CGFloat)leftSpace relativeView:(UIView *)relativeView {
    [self whc_X:leftSpace relativeView:relativeView];
}

- (void)whc_RightSpace:(CGFloat)rightSpace {
    [self removeConstraintFromView:self
                         attribute:NSLayoutAttributeWidth];
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeRight
                        constant:0.0 - rightSpace];
}

- (void)whc_RightSpace:(CGFloat)rightSpace relativeView:(UIView *)relativeView {
    UIView * superView = relativeView;
    if (!superView) {
        superView = self.superview;
    }
    [self removeConstraintFromView:self
                                 attribute:NSLayoutAttributeWidth];
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeRight
                       relatedBy:NSLayoutRelationEqual
                          toItem:relativeView
                       attribute:NSLayoutAttributeLeft
                      multiplier:1
                        constant:0.0 - rightSpace];
}

- (void)whc_Y:(CGFloat)y {
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeCenterY];
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeBaseline];
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeTop
                        constant:y];
}

- (void)whc_Y:(CGFloat)y relativeView:(UIView *)relativeView {
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeCenterY];
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeBaseline];
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeTop
                       relatedBy:NSLayoutRelationEqual
                          toItem:relativeView
                       attribute:NSLayoutAttributeBottom
                      multiplier:1
                        constant:y];
}

- (void)whc_TopSpace:(CGFloat)topSpace {
    [self whc_Y:topSpace];
}

- (void)whc_TopSpace:(CGFloat)topSpace relativeView:(UIView *)relativeView {
    [self whc_Y:topSpace relativeView:relativeView];
}

- (void)whc_BottomSpace:(CGFloat)bottomSpace {
    [self removeConstraintFromView:self
                         attribute:NSLayoutAttributeHeight];
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeBottom
                        constant:0.0 - bottomSpace];
}

- (void)whc_BottomSpace:(CGFloat)bottomSpace relativeView:(UIView *)relativeView {
    UIView * superView = relativeView;
    if (!superView) {
        superView = self.superview;
    }
    [self removeConstraintFromView:self
                                 attribute:NSLayoutAttributeHeight];
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeBottom
                       relatedBy:NSLayoutRelationEqual
                          toItem:superView
                       attribute:NSLayoutAttributeTop
                      multiplier:1
                        constant:0.0 - bottomSpace];
}

- (void)whc_Width:(CGFloat)width{
    [self removeConstraintFromView:self
                         attribute:NSLayoutAttributeWidth];
    [self removeConstraintFromView:self.superview
                                 attribute:NSLayoutAttributeRight];
    [self whc_ConstraintWithItem:self
                       attribute:NSLayoutAttributeWidth
                       relatedBy:NSLayoutRelationEqual
                          toItem:nil
                       attribute:NSLayoutAttributeNotAnAttribute
                      multiplier:0
                        constant:width];
}

- (void)whc_WidthEqualView:(UIView *)view {
    [self removeConstraintFromView:self.superview
                                 attribute:NSLayoutAttributeRight];
    [self removeConstraintFromView:self
                         attribute:NSLayoutAttributeWidth];
    [self whc_ConstraintWithItem:view
                       attribute:NSLayoutAttributeWidth
                        constant:0];
}

- (void)whc_WidthEqualView:(UIView *)view ratio:(CGFloat)ratio {
    [self removeConstraintFromView:self
                         attribute:NSLayoutAttributeWidth];
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeRight];
    [self whc_ConstraintWithItem:view
                       attribute:NSLayoutAttributeWidth
                        constant:0
                      multiplier:ratio];

}

- (void)whc_WidthAuto {
    [self removeConstraintFromView:self
                         attribute:NSLayoutAttributeWidth];
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeRight];
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel * selfLabel = (UILabel *)self;
        if (selfLabel.numberOfLines == 0) {
            selfLabel.numberOfLines = 1;
        }
        [self whc_ConstraintWithItem:self
                           attribute:NSLayoutAttributeWidth
                           relatedBy:NSLayoutRelationGreaterThanOrEqual
                              toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                          multiplier:1
                            constant:0];
    }else {
        NSLog(@"whc_WidthAuto property Only for UILabel");
    }
}

- (void)whc_Height:(CGFloat)height{
    [self removeConstraintFromView:self
                         attribute:NSLayoutAttributeHeight];
    [self removeConstraintFromView:self.superview
                                 attribute:NSLayoutAttributeBottom];
    [self whc_ConstraintWithItem:nil
                       attribute:NSLayoutAttributeHeight
                        constant:height];
}

- (void)whc_HeightEqualView:(UIView *)view {
    NSAssert(view, @"view 不能为nil");
    [self removeConstraintFromView:self
                         attribute:NSLayoutAttributeHeight];
    [self removeConstraintFromView:self.superview
                                 attribute:NSLayoutAttributeBottom];
    [self whc_ConstraintWithItem:view
                       attribute:NSLayoutAttributeHeight
                        constant:0];
}

- (void)whc_HeightEqualView:(UIView *)view ratio:(CGFloat)ratio {
    [self removeConstraintFromView:self
                         attribute:NSLayoutAttributeHeight];
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeBottom];
    [self whc_ConstraintWithItem:view
                       attribute:NSLayoutAttributeHeight
                        constant:0
                      multiplier:ratio];
}

- (void)whc_HeightAuto {
    [self removeConstraintFromView:self
                         attribute:NSLayoutAttributeHeight];
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeBottom];
    if ([self isKindOfClass:[UILabel class]]) {
        ((UILabel *)self).numberOfLines = 0;
        [self whc_ConstraintWithItem:self
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationGreaterThanOrEqual
                              toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                          multiplier:1
                            constant:0];
    }else {
        NSLog(@"whc_HeightAuto property Only for UILabel");
    }

}

- (void)whc_CenterX:(CGFloat)centerX {
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeLeft];
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeCenterX
                        constant:centerX];
}

- (void)whc_CenterX:(CGFloat)centerX relativeView:(UIView *)relativeView {
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeLeft];
    [self whc_ConstraintWithItem:relativeView
                       attribute:NSLayoutAttributeCenterX
                        constant:centerX];
}

- (void)whc_CenterY:(CGFloat)centerY {
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeTop];
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeBaseline];
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeCenterY
                        constant:centerY];
}

- (void)whc_CenterY:(CGFloat)centerY relativeView:(UIView *)relativeView {
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeTop];
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeBaseline];
    [self whc_ConstraintWithItem:relativeView
                       attribute:NSLayoutAttributeCenterY
                        constant:centerY];
}

- (void)whc_BaseLineSpace:(CGFloat)lineSpace {
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeTop];
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeCenterY];
    [self whc_ConstraintWithItem:self.superview
                       attribute:NSLayoutAttributeLastBaseline
                        constant:0.0 - lineSpace];
}

- (void)whc_BaseLineSpace:(CGFloat)lineSpace relativeView:(UIView *)relativeView {
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeTop];
    [self removeConstraintFromView:self.superview
                         attribute:NSLayoutAttributeCenterY];
    [self whc_ConstraintWithItem:relativeView
                       attribute:NSLayoutAttributeLastBaseline
                        constant:0.0 - lineSpace];
}

- (void)whc_XY:(CGPoint)xy {
    [self whc_X:xy.x];
    [self whc_Y:xy.y];
}

- (void)whc_XY:(CGPoint)xy relativeView:(UIView *)relativeView {
    [self whc_X:xy.x relativeView:relativeView];
    [self whc_Y:xy.y relativeView:relativeView];
}

- (void)whc_Center:(CGPoint)center {
    [self whc_CenterX:center.x];
    [self whc_CenterY:center.y];
}

- (void)whc_Center:(CGPoint)center relativeView:(UIView *)relativeView {
    [self whc_CenterX:center.x relativeView:relativeView];
    [self whc_CenterY:center.y relativeView:relativeView];
}

- (void)whc_Frame:(WHCRect)frame {
    [self whc_X:frame.left];
    [self whc_Y:frame.top];
    [self whc_Width:frame.width];
    [self whc_Height:frame.height];
}

- (void)whc_Size:(CGSize)size {
    [self whc_Width:size.width];
    [self whc_Height:size.height];
}

- (void)whc_Frame:(WHCRect)frame relativeView:(UIView *)relativeView {
    [self whc_X:frame.left relativeView:relativeView];
    [self whc_Y:frame.top relativeView:relativeView];
    [self whc_Width:frame.width];
    [self whc_Height:frame.height];
}

- (void)whc_FrameAuto:(WHCAutoRect)frame {
    [self whc_X:frame.left];
    [self whc_Y:frame.top];
    [self whc_RightSpace:frame.right];
    [self whc_BottomSpace:frame.bottom];
}

- (void)whc_FrameAutoWidth:(WHCWidthAutoRect)frame {
    [self whc_X:frame.left];
    [self whc_Y:frame.top];
    [self whc_RightSpace:frame.right];
    [self whc_Height:frame.height];
}

- (void)whc_FrameAutoHeight:(WHCHeightAutoRect)frame {
    [self whc_X:frame.left];
    [self whc_Y:frame.top];
    [self whc_Width:frame.width];
    [self whc_BottomSpace:frame.bottom];
}

- (void)whc_FrameAuto:(WHCAutoRect)frame relativeView:(UIView *)relativeView {
    [self whc_X:frame.left relativeView:relativeView];
    [self whc_Y:frame.top relativeView:relativeView];
    [self whc_RightSpace:frame.right relativeView:relativeView];
    [self whc_BottomSpace:frame.bottom relativeView:relativeView];
}

- (void)whc_FrameAutoWidth:(WHCWidthAutoRect)frame relativeView:(UIView *)relativeView {
    [self whc_X:frame.left relativeView:relativeView];
    [self whc_Y:frame.top relativeView:relativeView];
    [self whc_RightSpace:frame.right relativeView:relativeView];
    [self whc_Height:frame.height];
}

- (void)whc_FrameAutoHeight:(WHCHeightAutoRect)frame relativeView:(UIView *)relativeView {
    [self whc_X:frame.left relativeView:relativeView];
    [self whc_Y:frame.top relativeView:relativeView];
    [self whc_Width:frame.width];
    [self whc_BottomSpace:frame.bottom relativeView:relativeView];
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
    if (toItem == nil) {
        superView = item;
    }
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    if (item && item.translatesAutoresizingMaskIntoConstraints) {
        item.translatesAutoresizingMaskIntoConstraints = NO;
    }
    if (toItem == nil) {
        [self removeConstraintFromView:item
                             attribute:attribute];
    }else {
        [self removeConstraintFromView:item.superview
                             attribute:attribute
                                toView:toItem
                           toAttribute:toAttribute];
    }
    NSLayoutConstraint * constraint = nil;
    constraint =[NSLayoutConstraint constraintWithItem:item
                                             attribute:attribute
                                             relatedBy:related
                                                toItem:toItem
                                             attribute:toAttribute
                                            multiplier:multiplier
                                              constant:constant];
    
    [superView addConstraint:constraint];
}



- (void)removeConstraintFromView:(UIView *)view
                       attribute:(NSLayoutAttribute)attribute{
    [self removeConstraintFromView:view
                         attribute:attribute
                            toView:nil
                       toAttribute:NSLayoutAttributeNotAnAttribute];
}

- (void)removeConstraintFromView:(UIView *)view
                       attribute:(NSLayoutAttribute)attribute
                          toView:(UIView *)toView
                     toAttribute:(NSLayoutAttribute)toAttribute {
    NSAssert(view, @"视图不能为nil");
    UIView * constraintView = view;
    NSArray * constraintArray = [constraintView constraints];
    if (toView == nil) {
        switch (attribute) {
            case NSLayoutAttributeWidth:
            case NSLayoutAttributeHeight:
                for (NSLayoutConstraint * constraint in constraintArray) {
                    if (constraint.firstAttribute == attribute) {
                        [constraintView removeConstraint:constraint];
                        break;
                    }
                }
                constraintView = view.superview;
                constraintArray = [constraintView constraints];
                break;
            default:
                break;
        }
    }
    
    for (NSLayoutConstraint * constraint in constraintArray) {
        if (constraint.firstItem == self &&
            constraint.firstAttribute == attribute) {
            [constraintView removeConstraint:constraint];
            if (toAttribute != attribute &&
                toAttribute != NSLayoutAttributeNotAnAttribute &&
                toView != nil) {
                if (constraint.secondItem == toView &&
                    constraint.secondAttribute == toAttribute ) {
                    [toView removeConstraint:constraint];
                    break;
                }
            }
        }
    }
}

#pragma mark - Xib智能布局模块 -

- (void)whc_AutoXibLayout {
    [self whc_RunLayoutEngineWithOrientation:All];
}

- (void)whc_AutoXibHorizontalLayout {
   [self whc_RunLayoutEngineWithOrientation:Horizontal];
}

- (void)whc_RunLayoutEngineWithOrientation:(WHC_LayoutOrientationOptions)orientation {
    NSArray  * subViewArray = self.subviews;
    NSMutableArray  * rowViewArray = [NSMutableArray array];
    for (NSInteger i = 0; i < subViewArray.count; i++) {
        UIView * subView = subViewArray[i];
        if(rowViewArray.count == 0){
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
                if(isAtRow){
                    isAddSubView = YES;
                    [subRowViewArray addObject:subView];
                    break;
                }
            }
            if(!isAddSubView){
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
            UIView * nextColumnView = nil;
            UIView * frontColumnView = nil;
            frontRowView = nil;
            nextRowView = nil;
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
                      relativeView:frontRowView];
            }
            if (column == 0) {
                [view whc_LeftSpace:CGRectGetMinX(view.frame)];
            }else {
                frontColumnView = subRowViewArray[column - 1];
                [view whc_LeftSpace:CGRectGetMinX(view.frame) - CGRectGetMaxX(frontColumnView.frame)
                       relativeView:frontColumnView];
            }
            if ((orientation == All ||
                orientation == Vertical) &&
                ![view isKindOfClass:[UIImageView class]]) {
                if (nextRowView) {
                    [view whc_HeightEqualView:nextRowView
                                        ratio:CGRectGetHeight(view.frame) / CGRectGetHeight(nextRowView.frame)];
                }else {
                    [view whc_BottomSpace:CGRectGetHeight(view.superview.frame) - CGRectGetMaxY(view.frame)];
                }
            }else {
                [view whc_Height:CGRectGetHeight(view.frame)];
            }
            if (![view isKindOfClass:[UIImageView class]]) {
                if (nextColumnView) {
                    [view whc_WidthEqualView:nextColumnView
                                       ratio:CGRectGetWidth(view.frame) / CGRectGetWidth(nextColumnView.frame)];
                }else {
                    [view whc_RightSpace:CGRectGetWidth(view.superview.frame) - CGRectGetMaxX(view.frame)];
                }
            }else {
                [view whc_Width:CGRectGetWidth(view.frame)];
            }
            if ((view.subviews.count > 0 ||
                 [view isKindOfClass:[UITableViewCell class]] ||
                 [NSStringFromClass(view.class) isEqualToString:@"UIView"]) &&
                ([NSStringFromClass(view.class) isEqualToString:@"UITableViewCellContentView"])) {
                [view whc_RunLayoutEngineWithOrientation:orientation];
            }
        }
    }
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

@end

#pragma mark - UI自动布局容器 -

@implementation WHC_LayoutContainer

- (void)setWhc_Edge:(UIEdgeInsets)whc_Edge {
    objc_setAssociatedObject(self,
                             @selector(whc_Edge),
                             [NSValue valueWithUIEdgeInsets:whc_Edge],
                             OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)whc_Edge {
    return [objc_getAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}

- (void)setWhc_Space:(CGFloat)whc_Space {
    objc_setAssociatedObject(self,
                             @selector(whc_Space),
                             @(whc_Space),
                             OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)whc_Space {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setWhc_Orientation:(WHC_LayoutOrientationOptions)whc_Orientation {
    objc_setAssociatedObject(self,
                             @selector(whc_Orientation),
                             @(whc_Orientation),
                             OBJC_ASSOCIATION_RETAIN);
}

- (WHC_LayoutOrientationOptions)whc_Orientation {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setWhc_Column:(NSInteger)whc_Column {
    objc_setAssociatedObject(self,
                             @selector(whc_Column),
                             @(whc_Column),
                             OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger)whc_Column {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setWhc_ScreenWidth:(CGFloat)width {
    objc_setAssociatedObject(self,
                             @selector(whc_ScreenWidth),
                             @(width),
                             OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)whc_ScreenWidth {
    id widthId = objc_getAssociatedObject(self, _cmd);
    CGFloat width = 0;
    if (widthId) {
        width = [widthId floatValue];
        if (width == 0.0) {
            width = CGRectGetWidth([UIScreen mainScreen].bounds);
        }
    }else {
        width = CGRectGetWidth([UIScreen mainScreen].bounds);
    }
    return width;
}

- (void)whc_StartLayout {
    NSArray * subViews = self.subviews;
    NSInteger count = subViews.count;
    if (count == 0) {
        NSLog(@"whc 当前布局没有可用元素");
        return;
    }
    UIView * relativeView = nil;
    WHC_GOTO:
    switch (self.whc_Orientation) {
        case Horizontal: {
            UIView * oneView = subViews[0];
            UIView * secondView = count > 1 ? subViews[1] : nil;
            [oneView whc_LeftSpace:self.whc_Edge.left];
            [oneView whc_TopSpace:self.whc_Edge.top];
            [oneView whc_BottomSpace:self.whc_Edge.bottom];
            if (secondView) {
                [oneView whc_WidthEqualView:secondView
                                      ratio:oneView.whc_WidthWeight / secondView.whc_WidthWeight];
            }else {
                [oneView whc_RightSpace:self.whc_Edge.right];
            }
            relativeView = oneView;
            if ([relativeView isKindOfClass:[WHC_LayoutContainer class]]) {
                [((WHC_LayoutContainer *)relativeView) whc_StartLayout];
            }
            for (int i = 1; i < count; i++) {
                UIView * view = subViews[i];
                UIView * nextView = i < count - 1 ? subViews[i + 1] : nil;
                [view whc_LeftSpace:self.whc_Space relativeView:relativeView];
                [view whc_TopSpace:self.whc_Edge.top];
                [view whc_BottomSpace:self.whc_Edge.bottom];
                if (nextView) {
                    [view whc_WidthEqualView:nextView
                                       ratio:view.whc_WidthWeight / nextView.whc_WidthWeight];
                }else {
                    [view whc_RightSpace:self.whc_Edge.right];
                }
                relativeView = view;
                if ([relativeView isKindOfClass:[WHC_LayoutContainer class]]) {
                    [((WHC_LayoutContainer *)relativeView) whc_StartLayout];
                }
            }
            break;
        }
        case Vertical: {
            UIView * oneView = subViews[0];
            UIView * secondView = count > 1 ? subViews[1] : nil;
            [oneView whc_LeftSpace:self.whc_Edge.left];
            [oneView whc_TopSpace:self.whc_Edge.top];
            [oneView whc_RightSpace:self.whc_Edge.right];
            if (secondView) {
                [oneView whc_HeightEqualView:secondView
                                       ratio:oneView.whc_HeightWeight / secondView.whc_HeightWeight];
            }else {
                [oneView whc_BottomSpace:self.whc_Edge.bottom];
            }
            relativeView = oneView;
            if ([relativeView isKindOfClass:[WHC_LayoutContainer class]]) {
                [((WHC_LayoutContainer *)relativeView) whc_StartLayout];
            }
            for (int i = 1; i < count; i++) {
                UIView * view = subViews[i];
                UIView * nextView = i < count - 1 ? subViews[i + 1] : nil;
                [view whc_LeftSpace:self.whc_Edge.left];
                [view whc_TopSpace:self.whc_Space relativeView:relativeView];
                [view whc_RightSpace:self.whc_Edge.right];
                if (nextView) {
                    [view whc_HeightEqualView:nextView
                                        ratio:view.whc_HeightWeight / nextView.whc_HeightWeight];
                }else {
                    [view whc_BottomSpace:self.whc_Edge.bottom];
                }
                relativeView = view;
                if ([relativeView isKindOfClass:[WHC_LayoutContainer class]]) {
                    [((WHC_LayoutContainer *)relativeView) whc_StartLayout];
                }
            }
            break;
        }
        case All: {
            if (self.whc_Column < 2) {
                self.whc_Orientation = Vertical;
                goto WHC_GOTO;
            }else {
                NSInteger rowCount = count / self.whc_Column + (count % self.whc_Column == 0 ? 0 : 1);
                NSInteger index = 0;
                NSInteger lastRowVacantCount = rowCount * self.whc_Column - count;
                for (NSInteger i = 0; i < lastRowVacantCount; i++) {
                    UIView * view = [UIView new];
                    view.backgroundColor = [UIColor clearColor];
                    [self addSubview:view];
                }
                if (lastRowVacantCount > 0) {
                    subViews = nil;
                    subViews = self.subviews;
                    count = subViews.count;
                }
                UIView * frontRowView = nil;
                UIView * frontColumnView = nil;
                for (NSInteger row = 0; row < rowCount; row++) {
                    UIView * nextRowView = nil;
                    UIView * rowView = subViews[row * self.whc_Column];
                    NSInteger nextRow = (row + 1) * self.whc_Column;
                    if (nextRow < count) {
                        nextRowView = subViews[nextRow];
                    }
                    for (NSInteger column = 0; column < self.whc_Column; column++) {
                        index = row * self.whc_Column + column;
                        UIView * view = subViews[index];
                        UIView * nextColumnView = nil;
                        if (column < self.whc_Column - 1 && index < count) {
                            nextColumnView = subViews[index + 1];
                        }
                        if (row == 0) {
                            [view whc_TopSpace:self.whc_Edge.top];
                        }else {
                            [view whc_TopSpace:self.whc_Edge.top relativeView:frontRowView];
                        }
                        if (column == 0) {
                            [view whc_LeftSpace:self.whc_Edge.left];
                        }else {
                            [view whc_LeftSpace:self.whc_Edge.left relativeView:frontColumnView];
                        }
                        if (nextRowView) {
                            [view whc_HeightEqualView:nextRowView
                                                ratio:view.whc_HeightWeight / nextRowView.whc_HeightWeight];
                        }else {
                            [view whc_BottomSpace:self.whc_Edge.bottom];
                        }
                        if (nextColumnView) {
                            [view whc_WidthEqualView:nextColumnView
                                               ratio:view.whc_WidthWeight / nextColumnView.whc_WidthWeight];
                        }else {
                            [view whc_RightSpace:self.whc_Edge.right];
                        }
                        frontColumnView = view;
                        if ([frontColumnView isKindOfClass:[WHC_LayoutContainer class]]) {
                            [((WHC_LayoutContainer *)frontColumnView) whc_StartLayout];
                        }
                    }
                    frontRowView = rowView;
                }
            }
            break;
        }
        default:
            break;
    }
}

@end


