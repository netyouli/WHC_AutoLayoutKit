//
//  WHC_StackView.m
//  WHC_AutoLayoutExample
//
//  Created by 吴海超 on 16/3/14.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*************************************************************
 *                                                           *
 *  qq:712641411                                             *
 *  开发作者: 吴海超(WHC)                                      *
 *  iOS技术交流群:302157745                                    *
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit     *
 *                                                           *
 *************************************************************/

#import "WHC_StackView.h"
#import <objc/runtime.h>

@implementation UIView (WHC_StackViewCategory)

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

@end

@interface WHC_VacntView : UIView

@end

@implementation WHC_VacntView

@end

@interface WHC_StackView () {
    BOOL      _autoHeight;
    CGFloat   _elementWidth;
    CGFloat   _elementHeight;
    NSInteger _lastRowVacantCount;
}

@end

@implementation WHC_StackView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setWhc_WidthWeight:(CGFloat)whc_WidthWeight {
    objc_setAssociatedObject(self,
                             @selector(whc_WidthWeight),
                             @(whc_WidthWeight),
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

- (NSInteger)whc_SubViewCount {
    if (self.whc_Orientation == All) {
        return self.subviews.count - _lastRowVacantCount;
    }
    return self.subviews.count;
}

- (NSInteger)whc_Column {
    return MAX(_whc_Column, 1);
}

- (void)whc_AutoHeight {
    [self whc_HeightAuto];
    _autoHeight = YES;
}

- (void)whc_StartLayout {
    if (_autoHeight && self.whc_HeightWidthRatio > 0) {
        [self layoutIfNeeded];
        CGFloat stackViewWidth = CGRectGetWidth(self.frame);
        _elementWidth = (stackViewWidth - self.whc_Space * (MAX(1, self.whc_Column) - 1) - self.whc_Edge.left - self.whc_Edge.right) / self.whc_Column;
        _elementHeight = _elementWidth * self.whc_HeightWidthRatio;
    }
    [self runStackLayoutEngine];
    NSInteger subViewCount = self.subviews.count;
    if (_autoHeight) {
        if (self.whc_HeightWidthRatio > 0) {
            if (subViewCount == 0) {
                [self whc_Height:0];
            }else {
                NSInteger rowCount = (subViewCount / self.whc_Column + (subViewCount % self.whc_Column == 0 ? 0 : 1));
                CGFloat stackViewHeight = _elementHeight * rowCount + self.whc_Edge.top + self.whc_Edge.bottom + (rowCount - 1) * self.whc_Space;
                [self whc_Height:stackViewHeight];
            }
        }
    }
}

- (void)runStackLayoutEngine {
    NSArray * subViews = self.subviews;
    NSInteger count = subViews.count;
    if (count == 0) {
        return;
    }
    UIView * toView = nil;
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
            toView = oneView;
            if ([toView isKindOfClass:[WHC_StackView class]]) {
                [((WHC_StackView *)toView) whc_StartLayout];
            }
            for (int i = 1; i < count; i++) {
                UIView * view = subViews[i];
                UIView * nextView = i < count - 1 ? subViews[i + 1] : nil;
                [view whc_LeftSpace:self.whc_Space toView:toView];
                [view whc_TopSpace:self.whc_Edge.top];
                [view whc_BottomSpace:self.whc_Edge.bottom];
                if (nextView) {
                    [view whc_WidthEqualView:nextView
                                       ratio:view.whc_WidthWeight / nextView.whc_WidthWeight];
                }else {
                    [view whc_RightSpace:self.whc_Edge.right];
                }
                toView = view;
                if ([toView isKindOfClass:[WHC_StackView class]]) {
                    [((WHC_StackView *)toView) whc_StartLayout];
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
                if (_autoHeight && [oneView isKindOfClass:[UILabel class]]) {
                    [oneView whc_HeightAuto];
                }else {
                    [oneView whc_HeightEqualView:secondView
                                           ratio:oneView.whc_HeightWeight / secondView.whc_HeightWeight];
                }
            }else {
                [oneView whc_BottomSpace:self.whc_Edge.bottom];
            }
            toView = oneView;
            if ([toView isKindOfClass:[WHC_StackView class]]) {
                [((WHC_StackView *)toView) whc_StartLayout];
            }
            for (int i = 1; i < count; i++) {
                UIView * view = subViews[i];
                UIView * nextView = i < count - 1 ? subViews[i + 1] : nil;
                [view whc_LeftSpace:self.whc_Edge.left];
                [view whc_TopSpace:self.whc_Space toView:toView];
                [view whc_RightSpace:self.whc_Edge.right];
                if (nextView) {
                    if (_autoHeight && [view isKindOfClass:[UILabel class]]) {
                        [view whc_HeightAuto];
                    }else {
                        [view whc_HeightEqualView:nextView
                                            ratio:view.whc_HeightWeight / nextView.whc_HeightWeight];
                    }
                }else {
                    [view whc_BottomSpace:self.whc_Edge.bottom];
                }
                toView = view;
                if ([toView isKindOfClass:[WHC_StackView class]]) {
                    [((WHC_StackView *)toView) whc_StartLayout];
                }
            }
            break;
        }
        case All: {
            for (UIView * view in self.subviews) {
                if ([view isKindOfClass:[WHC_VacntView class]]) {
                    [view removeFromSuperview];
                }
            }
            subViews = self.subviews;
            count = subViews.count;
            if (self.whc_Column < 2) {
                self.whc_Orientation = Vertical;
                goto WHC_GOTO;
            }else {
                NSInteger rowCount = count / self.whc_Column + (count % self.whc_Column == 0 ? 0 : 1);
                NSInteger index = 0;
                _lastRowVacantCount = rowCount * self.whc_Column - count;
                for (NSInteger i = 0; i < _lastRowVacantCount; i++) {
                    WHC_VacntView * view = [WHC_VacntView new];
                    view.backgroundColor = self.backgroundColor;
                    [self addSubview:view];
                }
                if (_lastRowVacantCount > 0) {
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
                            [view whc_TopSpace:self.whc_Space toView:frontRowView];
                        }
                        if (column == 0) {
                            [view whc_LeftSpace:self.whc_Edge.left];
                        }else {
                            [view whc_LeftSpace:self.whc_Space toView:frontColumnView];
                        }
                        if (nextRowView) {
                            if (_autoHeight && [view isKindOfClass:[UIImageView class]]) {
                                [view whc_Height:_elementHeight];
                            }else {
                                [view whc_HeightEqualView:nextRowView
                                                    ratio:view.whc_HeightWeight / nextRowView.whc_HeightWeight];
                            }
                        }else {
                            if ([view isKindOfClass:[UIImageView class]] && _autoHeight) {
                                [view whc_Height:_elementHeight];
                            }else {
                                [view whc_BottomSpace:self.whc_Edge.bottom];
                            }
                        }
                        if (nextColumnView) {
                            [view whc_WidthEqualView:nextColumnView
                                               ratio:view.whc_WidthWeight / nextColumnView.whc_WidthWeight];
                        }else {
                            [view whc_RightSpace:self.whc_Edge.right];
                        }
                        frontColumnView = view;
                        if ([frontColumnView isKindOfClass:[WHC_StackView class]]) {
                            [((WHC_StackView *)frontColumnView) whc_StartLayout];
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
