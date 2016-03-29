//
//  WHC_StackView.h
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

#import <UIKit/UIKit.h>
#import "UIView+WHC_AutoLayout.h"

#pragma mark - UI自动布局StackView容器 -

@interface UIView (WHC_StackViewCategory)
/**
 * 说明: 控件横向和垂直布局宽度或者高度权重比例
 */
@property (nonatomic , assign)CGFloat whc_WidthWeight;

@property (nonatomic , assign)CGFloat whc_HeightWeight;
@end

@interface WHC_StackView : UIView



/// 混合布局(同时垂直和横向)每行多少列
@property (nonatomic , assign) NSInteger whc_Column;
/// 容器内边距
@property (nonatomic , assign) UIEdgeInsets whc_Edge;
/// 容器内子控件之间的空隙
@property (nonatomic , assign) CGFloat whc_Space;

/// 子元素高宽比(该属性仅仅在自动高度的时候才有效)
@property (nonatomic , assign) CGFloat whc_HeightWidthRatio;

/// 容器里子元素实际数量
@property (nonatomic , assign , readonly) NSInteger whc_SubViewCount;

/// 容器自动布局方向
@property (nonatomic , assign) WHC_LayoutOrientationOptions whc_Orientation;

/**
 * 说明: 自动高度
 */

- (void)whc_AutoHeight;

/**
 * 说明：开始进行自动布局
 */
- (void)whc_StartLayout;
@end
