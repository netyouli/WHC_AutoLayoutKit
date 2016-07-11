//
//  WHC_StackView.h
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

#import <UIKit/UIKit.h>
#import "UIView+WHC_AutoLayout.h"

@interface UIButton (WHC_StackView)

@end

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
/// 容器内子控件横向间隙
@property (nonatomic , assign) CGFloat whc_HSpace;
/// 容器内子控件垂直间隙
@property (nonatomic , assign) CGFloat whc_VSpace;

/// 子元素高宽比(该属性仅仅在自动高度的时候才有效)
@property (nonatomic , assign) CGFloat whc_HeightWidthRatio;

/// 容器里子元素实际数量
@property (nonatomic , assign , readonly) NSInteger whc_SubViewCount;

/// 容器自动布局方向
@property (nonatomic , assign) WHC_LayoutOrientationOptions whc_Orientation;

/************重载父类属性**************/
/// 自动高度
@property (nonatomic ,copy , readonly)HeightAuto whc_heightAuto;

/// 自动宽度
@property (nonatomic ,copy , readonly)WidthAuto whc_widthAuto;

/************重载父类方法**************/
/**
 * 说明: 自动宽度
 */

- (void)whc_WidthAuto;

/**
 * 说明: 自动高度
 */

- (void)whc_HeightAuto;

/**
 * 说明：开始进行自动布局
 */
- (void)whc_StartLayout;
@end
