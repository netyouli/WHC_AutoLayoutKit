//
//  UIView+WHC_AutoLayout.h
//
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

#import <UIKit/UIKit.h>
#import "UITableViewCell+WHC_AutoHeightForCell.h"

/// 布局方向
typedef NS_OPTIONS(NSUInteger, WHC_LayoutOrientationOptions) {
    /// 垂直布局
    Vertical = 1 << 0,
    /// 横向布局
    Horizontal = 1 << 1,
    /// 垂直布局和横向布局
    All = 1 << 2
};

/// 布局类型
typedef NS_OPTIONS(NSUInteger, WHC_LayoutTypeOptions) {
    /// 默认类型
    DefaultType = 1 << 0,
    /// 左右类型
    LeftRightType = 1 << 1,
};

typedef UIView * (^RemoveConstraintAttribute)(NSLayoutAttribute Attribute);
typedef UIView * (^RemoveConstraintAttributeItem)(NSLayoutAttribute Attribute, UIView * item);
typedef UIView * (^RemoveConstraintAttributeItemToItem)(NSLayoutAttribute Attribute, UIView * item,UIView * toItem);

typedef UIView * (^PriorityLow)();
typedef UIView * (^PriorityHigh)();
typedef UIView * (^PriorityRequired)();
typedef UIView * (^PriorityFitting)();
typedef UIView * (^PriorityValue)(CGFloat value);

typedef UIView * (^LeftSpace)(CGFloat value);
typedef UIView * (^LeftSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^LeftSpaceEqualView)(UIView * view);
typedef UIView * (^LeftSpaceEqualViewOffset)(UIView * view, CGFloat offset);

typedef UIView * (^LeadingSpace)(CGFloat value);
typedef UIView * (^LeadingSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^LeadingSpaceEqualView)(UIView * view);
typedef UIView * (^LeadingSpaceEqualViewOffset)(UIView * view, CGFloat offset);

typedef UIView * (^TrailingSpace)(CGFloat value);
typedef UIView * (^TrailingSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^TrailingSpaceEqualView)(UIView * view);
typedef UIView * (^TrailingSpaceEqualViewOffset)(UIView * view, CGFloat offset);

typedef UIView * (^BaseLineSpace)(CGFloat value);
typedef UIView * (^BaseLineSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^BaseLineSpaceEqualView)(UIView * view);
typedef UIView * (^BaseLineSpaceEqualViewOffset)(UIView * view, CGFloat offset);

typedef UIView * (^RightSpace)(CGFloat value);
typedef UIView * (^RightSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^RightSpaceEqualView)(UIView * view);
typedef UIView * (^RightSpaceEqualViewOffset)(UIView * view, CGFloat offset);

typedef UIView * (^RightSpaceKeepWidthConstraint)(CGFloat value, BOOL isKeep);
typedef UIView * (^RightSpaceToViewKeepWidthConstraint)(CGFloat value , UIView * toView, BOOL isKeep);
typedef UIView * (^RightSpaceEqualViewKeepWidthConstraint)(UIView * view, BOOL isKeep);
typedef UIView * (^RightSpaceEqualViewOffsetKeepWidthConstraint)(UIView * view, CGFloat offset, BOOL isKeep);

typedef UIView * (^TopSpace)(CGFloat value);
typedef UIView * (^TopSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^TopSpaceEqualView)(UIView * view);
typedef UIView * (^TopSpaceEqualViewOffset)(UIView * view, CGFloat offset);

typedef UIView * (^BottomSpace)(CGFloat value);
typedef UIView * (^BottomSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^BottomSpaceEqualView)(UIView * view);
typedef UIView * (^BottomSpaceEqualViewOffset)(UIView * view, CGFloat offset);

typedef UIView * (^BottomSpaceKeepHeightConstraint)(CGFloat value, BOOL isKeep);
typedef UIView * (^BottomSpaceToViewKeepHeightConstraint)(CGFloat value , UIView * toView, BOOL isKeep);
typedef UIView * (^BottomSpaceEqualViewKeepHeightConstraint)(UIView * view, BOOL isKeep);
typedef UIView * (^BottomSpaceEqualViewOffsetKeepHeightConstraint)(UIView * view, CGFloat offset, BOOL isKeep);

typedef UIView * (^Width)(CGFloat value);
typedef UIView * (^WidthAuto)();
typedef UIView * (^WidthEqualView)(UIView * view);
typedef UIView * (^WidthEqualViewRatio)(UIView * view, CGFloat ratio);
typedef UIView * (^WidthHeightRatio)(CGFloat ratio);

typedef UIView * (^WidthKeepRightConstraint)(CGFloat value, BOOL isKeep);
typedef UIView * (^WidthAutoKeepRightConstraint)(BOOL isKeep);
typedef UIView * (^WidthEqualViewKeepRightConstraint)(UIView * view, BOOL isKeep);
typedef UIView * (^WidthEqualViewRatioKeepRightConstraint)(UIView * view, CGFloat ratio, BOOL isKeep);

typedef UIView * (^Height)(CGFloat value);
typedef UIView * (^HeightAuto)();
typedef UIView * (^HeightEqualView)(UIView * view);
typedef UIView * (^HeightEqualViewRatio)(UIView * view, CGFloat ratio);
typedef UIView * (^HeightWidthRatio)(CGFloat ratio);

typedef UIView * (^HeightKeepBottomConstraint)(CGFloat value, BOOL isKeep);
typedef UIView * (^HeightAutoKeepBottomConstraint)(BOOL isKeep);
typedef UIView * (^HeightEqualViewKeepBottomConstraint)(UIView * view, BOOL isKeep);
typedef UIView * (^HeightEqualViewRatioKeepBottomConstraint)(UIView * view, CGFloat ratio, BOOL isKeep);

typedef UIView * (^CenterX)(CGFloat value);
typedef UIView * (^CenterXToView)(CGFloat value, UIView * toView);

typedef UIView * (^CenterY)(CGFloat value);
typedef UIView * (^CenterYToView)(CGFloat value, UIView * toView);

typedef UIView * (^Center)(CGPoint center);
typedef UIView * (^CenterToView)(CGPoint center, UIView * toView);

typedef UIView * (^size)(CGSize size);

#pragma mark - UI自动布局 -

@interface UIView (WHC_AutoLayout)

#pragma mark - api version ~ 2.0 -

/// 移除约束(NSLayoutAttribute Attribute)
@property (nonatomic ,copy , readonly)RemoveConstraintAttribute whc_RemoveConstraint;
/// 移除约束(NSLayoutAttribute Attribute, UIView * item)
@property (nonatomic ,copy , readonly)RemoveConstraintAttributeItem whc_RemoveConstraintItem;
/// 移除约束(NSLayoutAttribute Attribute, UIView * item, UIView toItem)
@property (nonatomic ,copy , readonly)RemoveConstraintAttributeItemToItem whc_RemoveConstraintItemToItem;

/// 设置当前约束的低优先级
@property (nonatomic ,copy , readonly)PriorityLow whc_PriorityLow;
/// 设置当前约束的高优先级
@property (nonatomic ,copy , readonly)PriorityHigh whc_PriorityHigh;
/// 设置当前约束的默认优先级
@property (nonatomic ,copy , readonly)PriorityRequired whc_PriorityRequired;
/// 设置当前约束的合适优先级
@property (nonatomic ,copy , readonly)PriorityFitting whc_PriorityFitting;
/// 设置当前约束的优先级 (CGFloat value): 优先级大小(0-1000)
@property (nonatomic ,copy , readonly)PriorityValue whc_Priority;

/// 与父视图左边间距(CGFloat value)
@property (nonatomic ,copy , readonly)LeftSpace whc_LeftSpace;
/// 与相对视图toView左边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)LeftSpaceToView whc_LeftSpaceToView;
/// 与视图view左边间距相等(UIView * view)
@property (nonatomic ,copy , readonly)LeftSpaceEqualView whc_LeftSpaceEqualView;
/// 与视图view左边间距相等并偏移offset(UIView * view, CGFloat offset)
@property (nonatomic ,copy , readonly)LeftSpaceEqualViewOffset whc_LeftSpaceEqualViewOffset;

/// 与父视图左边间距(CGFloat value)
@property (nonatomic ,copy , readonly)LeadingSpace whc_LeadingSpace;
/// 与相对视图toView左边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)LeadingSpaceToView whc_LeadingSpaceToView;
/// 与视图view左边间距相等(UIView * view)
@property (nonatomic ,copy , readonly)LeadingSpaceEqualView whc_LeadingSpaceEqualView;
/// 与视图view左边间距相等并偏移offset (UIView * view, CGFloat offset)
@property (nonatomic ,copy , readonly)LeadingSpaceEqualViewOffset whc_LeadingSpaceEqualViewOffset;

/// 与父视图右边间距(CGFloat value)
@property (nonatomic ,copy , readonly)TrailingSpace whc_TrailingSpace;
/// 与相对视图toView右边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)TrailingSpaceToView whc_TrailingSpaceToView;
/// 与视图view右边间距相等(UIView * view)
@property (nonatomic ,copy , readonly)TrailingSpaceEqualView whc_TrailingSpaceEqualView;
/// 与视图view右边间距相等并偏移offset(UIView * view, CGFloat offset)
@property (nonatomic ,copy , readonly)TrailingSpaceEqualViewOffset whc_TrailingSpaceEqualViewOffset;

/// 与父视图底边间距Y(CGFloat value)
@property (nonatomic ,copy , readonly)BaseLineSpace whc_BaseLineSpace;
/// 与相对视图toView底边间距Y(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)BaseLineSpaceToView whc_BaseLineSpaceToView;
/// 与视图view底边间距Y相等(UIView * view)
@property (nonatomic ,copy , readonly)BaseLineSpaceEqualView whc_BaseLineSpaceEqualView;
/// 与视图view底边间距Y相等并偏移offset(UIView * view, CGFloat offset)
@property (nonatomic ,copy , readonly)BaseLineSpaceEqualViewOffset whc_BaseLineSpaceEqualViewOffset;
/// 与父视图右边间距(CGFloat value)
@property (nonatomic ,copy , readonly)RightSpace whc_RightSpace;
/// 与相对视图toView右边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)RightSpaceToView whc_RightSpaceToView;
/// 与相对视图toView右边间距相等(UIView toView)
@property (nonatomic ,copy , readonly)RightSpaceEqualView whc_RightSpaceEqualView;
/// 与相对视图toView右边间距相等并偏移offset(UIView toView, CGFloat offset)
@property (nonatomic ,copy , readonly)RightSpaceEqualViewOffset whc_RightSpaceEqualViewOffset;

/// 与父视图右边间距是否保留宽度约束(CGFloat value, BOOL isKeep)
@property (nonatomic ,copy , readonly)RightSpaceKeepWidthConstraint whc_RightSpaceKeepWidthConstraint;
/// 与相对视图toView右边间距是否保留宽度约束(CGFloat value,UIView * toView, BOOL isKeep)
@property (nonatomic ,copy , readonly)RightSpaceToViewKeepWidthConstraint whc_RightSpaceToViewKeepWidthConstraint;
/// 与相对视图toView右边间距相等是否保留宽度约束(UIView toView, BOOL isKeep)
@property (nonatomic ,copy , readonly)RightSpaceEqualViewKeepWidthConstraint whc_RightSpaceEqualViewKeepWidthConstraint;
/// 与相对视图toView右边间距相等并偏移offset是否保留宽度约束(UIView toView, CGFloat offset, BOOL isKeep)
@property (nonatomic ,copy , readonly)RightSpaceEqualViewOffsetKeepWidthConstraint whc_RightSpaceEqualViewOffsetKeepWidthConstraint;

/// 与父视图顶边间距(CGFloat value)
@property (nonatomic ,copy , readonly)TopSpace whc_TopSpace;
/// 与相对视图toView顶边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)TopSpaceToView whc_TopSpaceToView;
/// 与视图view顶边间距相等(UIView * view)
@property (nonatomic ,copy , readonly)TopSpaceEqualView whc_TopSpaceEqualView;
/// 与视图view顶边间距相等并偏移offset(UIView * view, CGFloat offset)
@property (nonatomic ,copy , readonly)TopSpaceEqualViewOffset whc_TopSpaceEqualViewOffset;

/// 与父视图底边间距(CGFloat value)
@property (nonatomic ,copy , readonly)BottomSpace whc_BottomSpace;
/// 与相对视图toView底边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)BottomSpaceToView whc_BottomSpaceToView;
/// 与相对视图toView底边间距相等(UIView * toView)
@property (nonatomic ,copy , readonly)BottomSpaceEqualView whc_BottomSpaceEqualView;
/// 与相对视图toView底边间距相等并偏移offset(UIView * toView, CGFloat offset)
@property (nonatomic ,copy , readonly)BottomSpaceEqualViewOffset whc_BottomSpaceEqualViewOffset;

/// 与父视图底边间距是否保留高度约束(CGFloat value,BOOL isKeep)
@property (nonatomic ,copy , readonly)BottomSpaceKeepHeightConstraint whc_BottomSpaceKeepHeightConstraint;
/// 与相对视图toView底边间距是否保留高度约束(CGFloat value,UIView * toView,BOOL isKeep)
@property (nonatomic ,copy , readonly)BottomSpaceToViewKeepHeightConstraint whc_BottomSpaceToViewKeepHeightConstraint;
/// 与相对视图toView底边间距相等是否保留高度约束(UIView * toView,BOOL isKeep)
@property (nonatomic ,copy , readonly)BottomSpaceEqualViewKeepHeightConstraint whc_BottomSpaceEqualViewKeepHeightConstraint;
/// 与相对视图toView底边间距相等并偏移offset是否保留高度约束(UIView * toView, CGFloat offset,BOOL isKeep)
@property (nonatomic ,copy , readonly)BottomSpaceEqualViewOffsetKeepHeightConstraint whc_BottomSpaceEqualViewOffsetKeepHeightConstraint;

/// 宽度(CGFloat value)
@property (nonatomic ,copy , readonly)Width whc_Width;
/// 宽度自动()
@property (nonatomic ,copy , readonly)WidthAuto whc_WidthAuto;
/// 宽度等于视图view(UIView * view)
@property (nonatomic ,copy , readonly)WidthEqualView whc_WidthEqualView;
/// 宽度等于视图view 参照比例Ratio(UIView * view ,CGFloat ratio)
@property (nonatomic ,copy , readonly)WidthEqualViewRatio whc_WidthEqualViewRatio;
/// 视图自身宽度与高度的比(CGFloat Ratio)
@property (nonatomic ,copy , readonly)WidthHeightRatio whc_WidthHeightRatio;

/// 宽度是否保留宽度约束(CGFloat value, BOOL isKeep)
@property (nonatomic ,copy , readonly)WidthKeepRightConstraint whc_WidthKeepRightConstraint;
/// 宽度自动是否保留宽度约束(BOOL isKeep)
@property (nonatomic ,copy , readonly)WidthAutoKeepRightConstraint whc_WidthAutoKeepRightConstraint;
/// 宽度等于视图view是否保留宽度约束(UIView * view, BOOL isKeep, BOOL isKeep)
@property (nonatomic ,copy , readonly)WidthEqualViewKeepRightConstraint whc_WidthEqualViewKeepRightConstraint;
/// 宽度等于视图view 参照比例Ratio是否保留宽度约束(UIView * view ,CGFloat ratio, BOOL isKeep)
@property (nonatomic ,copy , readonly)WidthEqualViewRatioKeepRightConstraint whc_WidthEqualViewRatioKeepRightConstraint;

/// 高度(CGFloat value)
@property (nonatomic ,copy , readonly)Height whc_Height;
/// 高度自动()
@property (nonatomic ,copy , readonly)HeightAuto whc_HeightAuto;
/// 高度等于视图view(UIView * view)
@property (nonatomic ,copy , readonly)HeightEqualView whc_HeightEqualView;
/// 高度等于视图view 参照比例Ratio(UIView * view ,CGFloat ratio)
@property (nonatomic ,copy , readonly)HeightEqualViewRatio whc_HeightEqualViewRatio;
/// 视图自身高度与宽度的比(CGFloat Ratio)
@property (nonatomic ,copy , readonly)HeightWidthRatio whc_HeightWidthRatio;

/// 高度是否保留高度约束(CGFloat value, BOOL isKeep)
@property (nonatomic ,copy , readonly)HeightKeepBottomConstraint whc_HeightKeepBottomConstraint;
/// 高度自动是否保留高度约束(BOOL isKeep)
@property (nonatomic ,copy , readonly)HeightAutoKeepBottomConstraint whc_HeightAutoKeepBottomConstraint;
/// 高度等于视图view是否保留高度约束(UIView * view, BOOL isKeep)
@property (nonatomic ,copy , readonly)HeightEqualViewKeepBottomConstraint whc_HeightEqualViewKeepBottomConstraint;
/// 高度等于视图view 参照比例Ratio是否保留高度约束(UIView * view ,CGFloat ratio, BOOL isKeep)
@property (nonatomic ,copy , readonly)HeightEqualViewRatioKeepBottomConstraint whc_HeightEqualViewRatioKeepBottomConstraint;

/// 中心X与父视图偏移(CGFloat value)
@property (nonatomic ,copy , readonly)CenterX whc_CenterX;
/// 中心X与视图view偏移(CGFloat value , UIView * toView)
@property (nonatomic ,copy , readonly)CenterXToView whc_CenterXToView;

/// 中心Y与父视图偏移(CGFloat value)
@property (nonatomic ,copy , readonly)CenterY whc_CenterY;
/// 中心Y与视图view偏移(CGFloat value , UIView * toView)
@property (nonatomic ,copy , readonly)CenterYToView whc_CenterYToView;

/// 中心与父视图偏移(CGFloat value)
@property (nonatomic ,copy , readonly)Center whc_Center;
/// 中心与视图view偏移(CGFloat value , UIView * toView)
@property (nonatomic ,copy , readonly)CenterToView whc_CenterToView;

/// size设置(Size size)
@property (nonatomic ,copy , readonly)size whc_Size;

#pragma mark - api version ~ 1.0 -

/**
 * 说明:移除约束
 * @param attribute 约束类型
 */
- (void)whc_RemoveConstraintAttribute:(NSLayoutAttribute)Attribute;

/**
 * 说明:移除约束
 * @param attribute 约束类型
 * @param item 关联第一个约束视图
 */
- (void)whc_RemoveConstraintAttribute:(NSLayoutAttribute)Attribute item:(UIView *)item;

/**
 * 说明:移除约束
 * @param attribute 约束类型
 * @param item 关联第一个约束视图
 * @param toItem 关联第二个约束视图
 */
- (void)whc_RemoveConstraintAttribute:(NSLayoutAttribute)Attribute item:(UIView *)item toItem:(UIView *)toItem;

/**
 * 说明:设置当前约束的低优先级
 */
- (void)whc_priorityLow;

/**
 * 说明:设置当前约束的高优先级
 */
- (void)whc_priorityHigh;

/**
 * 说明:设置当前约束的默认优先级
 */
- (void)whc_priorityRequired;

/**
 * 说明:设置当前约束的合适优先级
 */
- (void)whc_priorityFitting;

/**
 * 说明:设置当前约束的优先级
 * @param value: 优先级大小(0-1000)
 */
- (void)whc_priority:(CGFloat)value;

/**
 * 说明:设置左边距(默认相对父视图)
 * @param leftSpace: 左边距
 */

- (void)whc_LeftSpace:(CGFloat)leftSpace;

/**
 * 说明:设置左边距
 * @param leftSpace: 左边距
 * @param toView: 设置相对参考视图
 */
- (void)whc_LeftSpace:(CGFloat)leftSpace toView:(UIView *)toView;

/**
 * 说明：设置左边距与视图view左边距相等
 */
- (void)whc_LeftSpaceEqualView:(UIView *)view;

/**
 * 说明：设置左边距与视图view左边距相等并偏移offset
 */

- (void)whc_LeftSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 * 说明:设置右边距(默认相对父视图)
 * @param rightSpace: 右边距
 */

- (void)whc_RightSpace:(CGFloat)rightSpace;

/**
 * 说明:设置右边距
 * @param rightSpace: 右边距
 * @param toView: 设置相对参考视图
 */

- (void)whc_RightSpace:(CGFloat)rightSpace toView:(UIView *)toView;

/**
 * 说明：设置右边距与视图view左对齐边距相等
 */

- (void)whc_RightSpaceEqualView:(UIView *)view;

/**
 * 说明：设置右边距与视图view左对齐边距相等并偏移offset
 */
- (void)whc_RightSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 * 说明:设置右边距(默认相对父视图)
 * @param rightSpace: 右边距
 * @param isKeep: 是否保留宽度约束
 */

- (void)whc_RightSpace:(CGFloat)rightSpace keepWidthConstraint:(BOOL)isKeep;

/**
 * 说明:设置右边距
 * @param rightSpace: 右边距
 * @param toView: 设置相对参考视图
 * @param isKeep: 是否保留宽度约束
 */

- (void)whc_RightSpace:(CGFloat)rightSpace toView:(UIView *)toView keepWidthConstraint:(BOOL)isKeep;

/**
 * 说明：设置右边距与视图view左对齐边距相等
 * @param isKeep: 是否保留宽度约束
 */

- (void)whc_RightSpaceEqualView:(UIView *)view keepWidthConstraint:(BOOL)isKeep;

/**
 * 说明：设置右边距与视图view左对齐边距相等并偏移offset
 * @param isKeep: 是否保留宽度约束
 */

- (void)whc_RightSpaceEqualView:(UIView *)view offset:(CGFloat)offset keepWidthConstraint:(BOOL)isKeep;

/**
 * 说明: 设置左对齐(默认相对父视图)
 * @param leadingSpace 左边距
 */

- (void)whc_LeadingSpace:(CGFloat)leadingSpace;

/**
 * 说明：设置左对齐
 * @param leadingSpace 左边距
 * @param toView 相对视图
 */

- (void)whc_LeadingSpace:(CGFloat)leadingSpace
            toView:(UIView *)toView;

/**
 * 说明：设置左对齐边距与某视图左对齐边距相等
 */
- (void)whc_LeadingSpaceEqualView:(UIView *)view;

/**
 * 说明：设置左对齐边距与某视图左对齐边距相等并偏移offset
 */
- (void)whc_LeadingSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 * 说明: 设置右对齐(默认相对父视图)
 * @param trailingSpace 右边距
 */

- (void)whc_TrailingSpace:(CGFloat)trailingSpace;

/**
 * 说明：设置右对齐
 * @param trailingSpace 右边距
 * @param toView 相对视图
 */
- (void)whc_TrailingSpace:(CGFloat)trailingSpace
             toView:(UIView *)toView;


/**
 * 说明：设置右对齐边距与某视图右对齐边距相等
 */
- (void)whc_TrailingSpaceEqualView:(UIView *)view;

/**
 * 说明：设置右对齐边距与某视图右对齐边距相等并偏移offset
 */
- (void)whc_TrailingSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 * 说明:设置顶边距(默认相对父视图)
 * @param topSpace: 顶边距
 */

- (void)whc_TopSpace:(CGFloat)topSpace;

/**
 * 说明:设置顶边距
 * @param topSpace: 顶边距
 * @param toView: 设置相对参考视图
 */

- (void)whc_TopSpace:(CGFloat)topSpace toView:(UIView *)toView;


/**
 * 说明：设置顶边距与视图view顶边距相等
 */

- (void)whc_TopSpaceEqualView:(UIView *)view;

/**
 * 说明：设置顶边距与视图view顶边距相等并偏移offset
 */
- (void)whc_TopSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 * 说明:设置底边距(默认相对父视图)
 * @param bottomSpace: 底边距边距
 */

- (void)whc_BottomSpace:(CGFloat)bottomSpace;

/**
 * 说明:设置底边距
 * @param bottomSpace: 底边距边距
 * @param toView: 设置相对参考视图
 */

- (void)whc_BottomSpace:(CGFloat)bottomSpace toView:(UIView *)toView;


/**
 * 说明：设置底边距与视图view底边距相等
 */

- (void)whc_BottomSpaceEqualView:(UIView *)view;

/**
 * 说明：设置底边距与视图view底边距相等并偏移offset
 */

- (void)whc_BottomSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 * 说明:设置底边距(默认相对父视图)
 * @param bottomSpace: 底边距边距
 * @param isKeep: 是否保留高度约束
 */

- (void)whc_BottomSpace:(CGFloat)bottomSpace keepHeightConstraint:(BOOL)isKeep;

/**
 * 说明:设置底边距
 * @param bottomSpace: 底边距边距
 * @param toView: 设置相对参考视图
 * @param isKeep: 是否保留高度约束
 */

- (void)whc_BottomSpace:(CGFloat)bottomSpace toView:(UIView *)toView keepHeightConstraint:(BOOL)isKeep;

/**
 * 说明：设置底边距与视图view底边距相等
 * @param isKeep: 是否保留高度约束
 */

- (void)whc_BottomSpaceEqualView:(UIView *)view keepHeightConstraint:(BOOL)isKeep;

/**
 * 说明：设置底边距与视图view底边距相等并偏移offset
 * @param isKeep: 是否保留高度约束
 */

- (void)whc_BottomSpaceEqualView:(UIView *)view offset:(CGFloat)offset keepHeightConstraint:(BOOL)isKeep;

/**
 * 说明:设置宽度
 * @param width: 宽度
 */

- (void)whc_Width:(CGFloat)width;

/**
 * 说明:设置宽度与某个视图相等
 * @param view: 相等视图
 */

- (void)whc_WidthEqualView:(UIView *)view;

/**
 * 说明:设置宽度与视图view相等
 * @param ratio: 宽度比例
 * @param view: 相等视图
 */

- (void)whc_WidthEqualView:(UIView *)view ratio:(CGFloat)ratio;

/**
 * 说明:设置自动宽度
 */

- (void)whc_AutoWidth;

/**
 * 说明:设置宽度
 * @param width: 宽度
 * @param isKeep: 是否保留右边距约束
 */

- (void)whc_Width:(CGFloat)width keepRightConstraint:(BOOL)isKeep;

/**
 * 说明:设置宽度与某个视图相等
 * @param view: 相等视图
 * @param isKeep: 是否保留右边距约束
 */

- (void)whc_WidthEqualView:(UIView *)view keepRightConstraint:(BOOL)isKeep;

/**
 * 说明:设置宽度与视图view相等
 * @param ratio: 宽度比例
 * @param view: 相等视图
 * @param isKeep: 是否保留右边距约束
 */

- (void)whc_WidthEqualView:(UIView *)view ratio:(CGFloat)ratio keepRightConstraint:(BOOL)isKeep;

/**
 * 说明:设置自动宽度
 * @param isKeep: 是否保留右边距约束
 */

- (void)whc_WidthAutoKeepRightConstraint:(BOOL)isKeep;

/**
 * 说明: 设置视图自身宽度与高度的比
 * @param ratio 视图自身宽度与高度的比
 */

- (void)whc_WidthHeightRatio:(CGFloat)ratio;

/**
 * 说明:设置高度
 * @param height: 高度
 */

- (void)whc_Height:(CGFloat)height;

/**
 * 说明:设置高度与视图view相等
 * @param view: 相等视图
 */

- (void)whc_HeightEqualView:(UIView *)view;

/**
 * 说明:设置高度与视图view相等
 * @param ratio: 宽度比例
 * @param view: 相等视图
 */

- (void)whc_HeightEqualView:(UIView *)view ratio:(CGFloat)ratio;

/**
 * 说明:设置自动高度
 */
- (void)whc_AutoHeight;

/**
 * 说明:设置高度
 * @param height: 高度
 * @param isKeep: 是否保留底边距约束
 */

- (void)whc_Height:(CGFloat)height keepBottomConstraint:(BOOL)isKeep;

/**
 * 说明:设置高度与视图view相等
 * @param view: 相等视图
 * @param isKeep: 是否保留底边距约束
 */

- (void)whc_HeightEqualView:(UIView *)view keepBottomConstraint:(BOOL)isKeep;

/**
 * 说明:设置高度与视图view相等
 * @param ratio: 宽度比例
 * @param view: 相等视图
 * @param isKeep: 是否保留底边距约束
 */

- (void)whc_HeightEqualView:(UIView *)view ratio:(CGFloat)ratio keepBottomConstraint:(BOOL)isKeep;

/**
 * 说明:设置自动高度
 * @param isKeep: 是否保留底边距约束
 */
- (void)whc_HeightAutoKeepBottomConstraint:(BOOL)isKeep;

/**
 * 说明: 设置视图自身高度与宽度的比
 * @param ratio 视图自身高度与宽度的比
 */

- (void)whc_HeightWidthRatio:(CGFloat)ratio;

/**
 * 说明:设置中心x与父视图中心的偏移 centerX = 0 与父视图中心x重合
 * @param centerX: 中心x坐标偏移
 */

- (void)whc_CenterX:(CGFloat)centerX;

/**
 * 说明:设置中心x与相对视图中心的偏移 centerX = 0 与相对视图中心x重合
 * @param centerX: 中心x坐标偏移
 * @param toView: 设置相对参考视图
 */

- (void)whc_CenterX:(CGFloat)centerX toView:(UIView *)toView;

/**
 * 说明:设置中心y与父视图中心的偏移 centerY = 0 与父视图中心y重合
 * @param centerY: 中心y坐标偏移
 */

- (void)whc_CenterY:(CGFloat)centerY;

/**
 * 说明:设置中心y与相对视图中心的偏移 centerY = 0 与相对视图中心y重合
 * @param centerY: 中心y坐标偏移
 * @param toView: 设置相对参考视图
 */

- (void)whc_CenterY:(CGFloat)centerY toView:(UIView *)toView;

/**
 * 说明:设置Y坐标与底部偏移(默认相对父视图)
 * @param lineSpace: 底部偏移
 */

- (void)whc_BaseLineSpace:(CGFloat)lineSpace;

/**
 * 说明:设置Y坐标与底部偏移
 * @param lineSpace: 底部偏移
 * @param toView: 相对视图
 */

- (void)whc_BaseLineSpace:(CGFloat)lineSpace toView:(UIView *)toView;

/**
 * 说明:设置Y坐标相等
 * @param view: 相对视图
 */

- (void)whc_BaseLineSpaceEqualView:(UIView *)view;

/**
 * 说明:设置Y坐标相等并偏移offset
 * @param view: 相对视图
 * @param offset: 偏移量
 */

- (void)whc_BaseLineSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 * 说明:设置中心偏移(默认相对父视图)center = CGPointZero 与父视图中心重合
 * @param center: 中心偏移xy
 */

- (void)whc_Center:(CGPoint)center;

/**
 * 说明:设置中心偏移(默认相对父视图)center = CGPointZero 与父视图中心重合
 * @param center: 中心偏移xy
 * @param toView: 设置相对参考视图
 */

- (void)whc_Center:(CGPoint)center toView:(UIView *)toView;

/**
 * 说明:设置frame(默认相对父视图)
 * @param left 左边距
 * @param top 顶边距
 * @param width 宽度
 * @param height 高度
 */

- (void)whc_Frame:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height;

/**
 * 说明:设置frame (默认相对父视图)
 * @param left 左边距
 * @param top 顶边距
 * @param right 右边距
 * @param bottom 底边距
 */

- (void)whc_AutoSize:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom;

/**
 * 说明:设置frame
 * @param left 左边距
 * @param top 顶边距
 * @param width 宽度
 * @param height 高度
 * @param toView frame参考视图
 */

- (void)whc_Frame:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height toView:(UIView *)toView;

/**
 * 说明:设置frame (默认相对父视图)
 * @param left 左边距
 * @param top 顶边距
 * @param right 右边距
 * @param height 高度
 */

- (void)whc_AutoWidth:(CGFloat)left top:(CGFloat)top right:(CGFloat)right height:(CGFloat)height;

/**
 * 说明:设置frame (默认相对父视图)
 * @param left 左边距
 * @param top 顶边距
 * @param width 宽度
 * @param bottom 底边距
 */

- (void)whc_AutoHeight:(CGFloat)left top:(CGFloat)top width:(CGFloat)width bottom:(CGFloat)bottom;

/**
 * 说明:设置frame
 * @param left 左边距
 * @param top 顶边距
 * @param right 右边距
 * @param bottom 底边距
 * @param toView frame参考视图
 */

- (void)whc_AutoSize:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom toView:(UIView *)toView;

/**
 * 说明:设置frame
 * @param left 左边距
 * @param top 顶边距
 * @param right 右边距
 * @param height 高度
 * @param toView frame参考视图
 */

- (void)whc_AutoWidth:(CGFloat)left top:(CGFloat)top right:(CGFloat)right height:(CGFloat)height toView:(UIView *)toView;

/**
 * 说明:设置frame (默认相对父视图)
 * @param left 左边距
 * @param top 顶边距
 * @param width 宽度
 * @param bottom 底边距
 */

- (void)whc_AutoHeight:(CGFloat)left top:(CGFloat)top width:(CGFloat)width bottom:(CGFloat)bottom toView:(UIView *)toView;

/**
 * 说明:设置视图显示宽高
 * @param size: 视图显示区域宽高
 */

- (void)whc_Size:(CGSize)size;

#pragma mark - Xib智能布局模块 -

/**
 * 说明:对整个Xib(使用3.5寸xib)上UI控件垂直和横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoXibLayout;

/**
 * 说明:对整个Xib(使用3.5寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoXibLayoutType:(WHC_LayoutTypeOptions)type;

/**
 * 说明:对整个storyboard(使用4.7寸xib)上UI控件垂直和横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoSBLayout;

/**
 * 说明:对整个storyboard(使用4.7寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoSBLayoutType:(WHC_LayoutTypeOptions)type;

/**
 * 说明:对整个Xib(使用3.5寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoXibHorizontalLayout;

/**
 * 说明:对整个Xib(使用3.5寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoXibHorizontalLayoutType:(WHC_LayoutTypeOptions)type;

/**
 * 说明:对整个storyboard(使用4.7寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoSBHorizontalLayout;

/**
 * 说明:对整个storyboard(使用4.7寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoSBHorizontalLayoutType:(WHC_LayoutTypeOptions)type;

#pragma mark - 自动加边线模块 -

/**
 * 说明: 对视图底部加线
 * @param value: 线宽
 * @param color: 线的颜色
 */

- (UIView *)whc_AddBottomLine:(CGFloat)value lineColor:(UIColor *)color;

/**
 * 说明: 对视图底部加线
 * @param value: 线宽
 * @param color: 线的颜色
 * @param pading: 边距
 */

- (UIView *)whc_AddBottomLine:(CGFloat)value lineColor:(UIColor *)color pading:(CGFloat)pading;

/**
 * 说明: 对视图顶部加线
 * @param value: 线宽
 * @param color: 线的颜色
 */

- (UIView *)whc_AddTopLine:(CGFloat)value lineColor:(UIColor *)color;

/**
 * 说明: 对视图顶部加线
 * @param value: 线宽
 * @param color: 线的颜色
 * @param pading: 边距
 */

- (UIView *)whc_AddTopLine:(CGFloat)value lineColor:(UIColor *)color pading:(CGFloat)pading;

/**
 * 说明: 对视图左边加线
 * @param value: 线宽
 * @param color: 线的颜色
 */


- (UIView *)whc_AddLeftLine:(CGFloat)value lineColor:(UIColor *)color;

/**
 *  说明: 对视图左边加线
 *
 *  @param value   线宽
 *  @param color   线的颜色
 *  @param padding 边距
 *
 *  @return line
 */
- (UIView *)whc_AddLeftLine:(CGFloat)value lineColor:(UIColor *)color padding:(CGFloat)padding;

/**
 * 说明: 对视图右边加线
 * @param value: 线宽
 * @param color: 线的颜色
 */

- (UIView *)whc_AddRightLine:(CGFloat)value lineColor:(UIColor *)color;

/**
 * 说明: 对视图右边加线
 * @param value: 线宽
 * @param color: 线的颜色
 * @param pading: 边距
 */

- (UIView *)whc_AddRightLine:(CGFloat)value lineColor:(UIColor *)color padding:(CGFloat)padding;
@end
