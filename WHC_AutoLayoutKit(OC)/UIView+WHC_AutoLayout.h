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

typedef UIView * (^ResetConstraintAttribute)();
typedef UIView * (^ClearConstraintAttribute)();
typedef UIView * (^RemoveConstraintAttribute)(NSLayoutAttribute attributes, ...);
typedef UIView * (^RemoveConstraintFromViewAttribute)(UIView * view, NSLayoutAttribute attributes, ...);

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

typedef UIView * (^TopSpace)(CGFloat value);
typedef UIView * (^TopSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^TopSpaceEqualView)(UIView * view);
typedef UIView * (^TopSpaceEqualViewOffset)(UIView * view, CGFloat offset);

typedef UIView * (^BottomSpace)(CGFloat value);
typedef UIView * (^BottomSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^BottomSpaceEqualView)(UIView * view);
typedef UIView * (^BottomSpaceEqualViewOffset)(UIView * view, CGFloat offset);

typedef UIView * (^Width)(CGFloat value);
typedef UIView * (^WidthAuto)();
typedef UIView * (^WidthEqualView)(UIView * view);
typedef UIView * (^WidthEqualViewRatio)(UIView * view, CGFloat ratio);
typedef UIView * (^WidthHeightRatio)(CGFloat ratio);

typedef UIView * (^Height)(CGFloat value);
typedef UIView * (^HeightAuto)();
typedef UIView * (^HeightEqualView)(UIView * view);
typedef UIView * (^HeightEqualViewRatio)(UIView * view, CGFloat ratio);
typedef UIView * (^HeightWidthRatio)(CGFloat ratio);

typedef UIView * (^CenterX)(CGFloat value);
typedef UIView * (^CenterXToView)(CGFloat value, UIView * toView);

typedef UIView * (^CenterY)(CGFloat value);
typedef UIView * (^CenterYToView)(CGFloat value, UIView * toView);

typedef UIView * (^Center)(CGFloat x, CGFloat y);
typedef UIView * (^CenterToView)(CGPoint center, UIView * toView);

typedef UIView * (^size)(CGFloat width, CGFloat height);
typedef UIView * (^SizeEqual)(UIView * view);

typedef UIView * (^FrameEqual)(UIView * view);

#pragma mark - UI自动布局 -

@interface UIView (WHC_AutoLayout)

#pragma mark - api version ~ 2.0 -

/// 重置缓存约束
@property (nonatomic ,copy , readonly)ResetConstraintAttribute whc_ResetConstraint;
/// 清除所有约束
@property (nonatomic ,copy , readonly)ClearConstraintAttribute whc_ClearLayoutAttr;
/// 移除约束(NSLayoutAttribute attributes, ...)
@property (nonatomic ,copy , readonly)RemoveConstraintAttribute whc_RemoveLayoutAttrs;
/// 移除约束从指定视图上(UIView * view, NSLayoutAttribute attributes, ...)
@property (nonatomic ,copy , readonly)RemoveConstraintFromViewAttribute whc_RemoveFromLayoutAttrs;

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
@property (nonatomic ,copy , readonly)BaseLineSpace whc_FirstBaseLine;
/// 与相对视图toView底边间距Y(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)BaseLineSpaceToView whc_FirstBaseLineToView;
/// 与视图view底边间距Y相等(UIView * view)
@property (nonatomic ,copy , readonly)BaseLineSpaceEqualView whc_FirstBaseLineEqualView;
/// 与视图view底边间距Y相等并偏移offset(UIView * view, CGFloat offset)
@property (nonatomic ,copy , readonly)BaseLineSpaceEqualViewOffset whc_FirstBaseLineEqualViewOffset;

/// 与父视图底边间距Y(CGFloat value)
@property (nonatomic ,copy , readonly)BaseLineSpace whc_LastBaseLine;
/// 与相对视图toView底边间距Y(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)BaseLineSpaceToView whc_LastBaseLineToView;
/// 与视图view底边间距Y相等(UIView * view)
@property (nonatomic ,copy , readonly)BaseLineSpaceEqualView whc_LastBaseLineEqualView;
/// 与视图view底边间距Y相等并偏移offset(UIView * view, CGFloat offset)
@property (nonatomic ,copy , readonly)BaseLineSpaceEqualViewOffset whc_LastBaseLineEqualViewOffset;
/// 与父视图右边间距(CGFloat value)
@property (nonatomic ,copy , readonly)RightSpace whc_RightSpace;
/// 与相对视图toView右边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)RightSpaceToView whc_RightSpaceToView;
/// 与相对视图toView右边间距相等(UIView toView)
@property (nonatomic ,copy , readonly)RightSpaceEqualView whc_RightSpaceEqualView;
/// 与相对视图toView右边间距相等并偏移offset(UIView toView, CGFloat offset)
@property (nonatomic ,copy , readonly)RightSpaceEqualViewOffset whc_RightSpaceEqualViewOffset;

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

/// size设置(CGFloat width, CGFloat height)
@property (nonatomic ,copy , readonly)size whc_Size;
/// size设置(UIView * view)
@property (nonatomic ,copy , readonly)SizeEqual whc_SizeEqualView;

/// frame设置(UIView * view)
@property (nonatomic ,copy , readonly)FrameEqual whc_FrameEqualView;
#pragma mark - api version ~ 1.0 -


/**
 重置缓存的约束,该方法在当前视图对象移除从父视图上可能需要调用清除与父视图之前旧约束缓存对象
 
 @return 返回当前视图
 */
- (UIView *)whc_ResetConstraints;

/**
 清除所有布局属性
 
 @return 返回当前视图
 */
- (UIView *)whc_ClearLayoutAttrs;

/**
 移除一个或者一组约束
 
 @param attribute 约束类型（可变参数）
 @return 返回当前视图
 */
- (UIView *)whc_RemoveLayoutAttr:(NSLayoutAttribute)attributes, ...;


/**
 移除一个或者一组约束从指定的视图上

 @param view 指定视图
 @param attributes 约束类型（可变参数）
 @return 返回当前视图
 */
- (UIView *)whc_RemoveFrom:(UIView *)view layoutAttrs:(NSLayoutAttribute)attributes, ...;

/**
 设置当前约束的低优先级

 @return 返回当前视图
 */
- (UIView *)whc_priorityLow;

/**
 设置当前约束的高优先级

 @return 返回当前视图
 */
- (UIView *)whc_priorityHigh;

/**
 设置当前约束的默认优先级

 @return 返回当前视图
 */
- (UIView *)whc_priorityRequired;

/**
 设置当前约束的合适优先级

 @return 返回当前视图
 */
- (UIView *)whc_priorityFitting;

/**
 设置当前约束的优先级

 @param value 优先级大小(0-1000)
 @return 返回当前视图
 */
- (UIView *)whc_priority:(CGFloat)value;

/**
 设置左边距(默认相对父视图)

 @param leftSpace 左边距
 @return 返回当前视图
 */
- (UIView *)whc_LeftSpace:(CGFloat)leftSpace;


/**
 设置左边距

 @param leftSpace 左边距
 @param toView 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_LeftSpace:(CGFloat)leftSpace toView:(UIView *)toView;

/**
 设置左边距与视图view左边距相等

 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_LeftSpaceEqualView:(UIView *)view;

/**
 设置左边距与视图view左边距相等并偏移offset

 @param view 相对视图
 @param offset 偏移量
 @return 返回当前视图
 */
- (UIView *)whc_LeftSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 设置右边距(默认相对父视图)

 @param rightSpace 右边距
 @return 返回当前视图
 */
- (UIView *)whc_RightSpace:(CGFloat)rightSpace;

/**
 设置右边距

 @param rightSpace 右边距
 @param toView 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_RightSpace:(CGFloat)rightSpace toView:(UIView *)toView;

/**
 设置右边距与视图view左对齐边距相等

 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_RightSpaceEqualView:(UIView *)view;

/**
 设置右边距与视图view左对齐边距相等并偏移offset

 @param view 相对视图
 @param offset 偏移量
 @return 返回当前视图
 */
- (UIView *)whc_RightSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 设置左对齐(默认相对父视图)

 @param leadingSpace 左边距
 @return 返回当前视图
 */
- (UIView *)whc_LeadingSpace:(CGFloat)leadingSpace;

/**
 设置左对齐
 
 @param leadingSpace 左边距
 @param toView 相对视图
 @return 返回当前视图
 */

- (UIView *)whc_LeadingSpace:(CGFloat)leadingSpace toView:(UIView *)toView;

/**
 设置左对齐边距与某视图左对齐边距相等

 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_LeadingSpaceEqualView:(UIView *)view;

/**
 设置左对齐边距与某视图左对齐边距相等并偏移offset

 @param view 相对视图
 @param offset 偏移量
 @return 返回当前视图
 */
- (UIView *)whc_LeadingSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 设置右对齐(默认相对父视图)

 @param trailingSpace 右边距
 @return 返回当前视图
 */
- (UIView *)whc_TrailingSpace:(CGFloat)trailingSpace;

/**
 设置右对齐

 @param trailingSpace 右边距
 @param toView 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_TrailingSpace:(CGFloat)trailingSpace toView:(UIView *)toView;

/**
 设置右对齐边距与某视图右对齐边距相等

 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_TrailingSpaceEqualView:(UIView *)view;

/**
 设置右对齐边距与某视图右对齐边距相等并偏移offset

 @param view 相对视图
 @param offset 偏移量
 @return 返回当前视图
 */
- (UIView *)whc_TrailingSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 设置顶边距(默认相对父视图)

 @param topSpace 顶边距
 @return 返回当前视图
 */
- (UIView *)whc_TopSpace:(CGFloat)topSpace;

/**
 设置顶边距

 @param topSpace 顶边距
 @param toView 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_TopSpace:(CGFloat)topSpace toView:(UIView *)toView;

/**
 设置顶边距与视图view顶边距相等

 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_TopSpaceEqualView:(UIView *)view;

/**
 设置顶边距与视图view顶边距相等并偏移offset

 @param view 相对视图
 @param offset 偏移量
 @return 返回当前视图
 */
- (UIView *)whc_TopSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 设置底边距(默认相对父视图)

 @param bottomSpace 底边距
 @return 返回当前视图
 */
- (UIView *)whc_BottomSpace:(CGFloat)bottomSpace;

/**
 设置底边距

 @param bottomSpace 底边距
 @param toView 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_BottomSpace:(CGFloat)bottomSpace toView:(UIView *)toView;

/**
 设置底边距与视图view底边距相等

 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_BottomSpaceEqualView:(UIView *)view;

/**
 设置底边距与视图view底边距相等并偏移offset

 @param view 相对视图
 @param offset 偏移量
 @return 返回当前视图
 */
- (UIView *)whc_BottomSpaceEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 设置宽度

 @param width 宽度
 @return 返回当前视图
 */
- (UIView *)whc_Width:(CGFloat)width;

/**
 设置宽度与某个视图相等

 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_WidthEqualView:(UIView *)view;

/**
 设置宽度与视图view相等

 @param view 相对视图
 @param ratio 比例
 @return 返回当前视图
 */
- (UIView *)whc_WidthEqualView:(UIView *)view ratio:(CGFloat)ratio;

/**
 设置自动宽度

 @return 返回当前视图
 */
- (UIView *)whc_AutoWidth;

/**
 设置视图自身宽度与高度的比

 @param ratio 比例
 @return 返回当前视图
 */
- (UIView *)whc_WidthHeightRatio:(CGFloat)ratio;

/**
 设置高度

 @param height 高度
 @return 返回当前视图
 */
- (UIView *)whc_Height:(CGFloat)height;

/**
 设置高度与视图view相等

 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_HeightEqualView:(UIView *)view;

/**
 设置高度与视图view相等

 @param view 相对视图
 @param ratio 比例
 @return 返回当前视图
 */
- (UIView *)whc_HeightEqualView:(UIView *)view ratio:(CGFloat)ratio;

/**
 设置自动高度

 @return 返回当前视图
 */
- (UIView *)whc_AutoHeight;

/**
 设置视图自身高度与宽度的比

 @param ratio 比例
 @return 返回当前视图
 */
- (UIView *)whc_HeightWidthRatio:(CGFloat)ratio;

/**
 设置中心x与父视图中心的偏移 centerX = 0 与父视图中心x重合

 @param centerX 中心x坐标偏移
 @return 返回当前视图
 */
- (UIView *)whc_CenterX:(CGFloat)centerX;

/**
 设置中心x与相对视图中心的偏移 centerX = 0 与相对视图中心x重合

 @param centerX 中心x坐标偏移
 @param toView 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_CenterX:(CGFloat)centerX toView:(UIView *)toView;

/**
 设置中心y与父视图中心的偏移 centerY = 0 与父视图中心y重合

 @param centerY 中心y坐标偏移
 @return 返回当前视图
 */
- (UIView *)whc_CenterY:(CGFloat)centerY;

/**
 设置中心y与相对视图中心的偏移 centerY = 0 与相对视图中心y重合

 @param centerY 中心y坐标偏移
 @param toView 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_CenterY:(CGFloat)centerY toView:(UIView *)toView;

/**
 设置顶部基线偏移(默认相对父视图)

 @param space 间隙
 @return 返回当前视图
 */
- (UIView *)whc_FirstBaseLine:(CGFloat)space;

/**
 设置顶部基线与对象视图底部基线偏移

 @param space 间隙
 @param toView 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_FirstBaseLine:(CGFloat)space toView:(UIView *)toView;

/**
 设置顶部基线与相对视图顶部基线相等

 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_FirstBaseLineEqualView:(UIView *)view;

/**
 设置顶部基线与相对视图顶部基线相等并偏移offset

 @param view 相对视图
 @param offset 偏移量
 @return 返回当前视图
 */
- (UIView *)whc_FirstBaseLineEqualView:(UIView *)view offset:(CGFloat)offset;

/**
 设置底部基线偏移(默认相对父视图)

 @param space 间隙
 @return 返回当前视图
 */
- (UIView *)whc_LastBaseLine:(CGFloat)space;

/**
 设置底部基线与对象视图顶部基线偏移

 @param space 间隙
 @param toView 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_LastBaseLine:(CGFloat)space toView:(UIView *)toView;

/**
 设置底部基线与相对视图底部基线相等

 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_LastBaseLineEqualView:(UIView *)view;

/**
 设置底部基线与相对视图底部基线相等并偏移offset

 @param view 相对视图
 @param offset 偏移量
 @return 返回当前视图
 */
- (UIView *)whc_LastBaseLineEqualView:(UIView *)view offset:(CGFloat)offset;


/**
 设置中心偏移(默认相对父视图)center = CGPointZero 与父视图中心重合

 @param center 中心偏移xy
 @return 返回当前视图
 */
- (UIView *)whc_Center:(CGPoint)center;

/**
 设置中心偏移(默认相对父视图)center = CGPointZero 与父视图中心重合

 @param center 中心偏移xy
 @param toView 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_Center:(CGPoint)center toView:(UIView *)toView;

/**
 设置frame(默认相对父视图)

 @param left 左边距
 @param top 顶边距
 @param width 宽度
 @param height 高度
 @return 返回当前视图
 */
- (UIView *)whc_Frame:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height;

/**
 设置frame (默认相对父视图)
 
 @param left 左边距
 @param top 顶边距
 @param right 右边距
 @param bottom 底边距
 @return 返回当前视图
 */

- (UIView *)whc_AutoSize:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom;

/**
 设置frame
 
 @param left 左边距
 @param top 顶边距
 @param width 宽度
 @param height 高度
 @param toView 相对视图
 @return 返回当前视图
 */

- (UIView *)whc_Frame:(CGFloat)left top:(CGFloat)top width:(CGFloat)width height:(CGFloat)height toView:(UIView *)toView;

/**
 设置frame (默认相对父视图)
 
 @param left 左边距
 @param top 顶边距
 @param right 右边距
 @param height 高度
 @return 返回当前视图
 */

- (UIView *)whc_AutoWidth:(CGFloat)left top:(CGFloat)top right:(CGFloat)right height:(CGFloat)height;

/**
 设置frame (默认相对父视图)
 
 @param left 左边距
 @param top 顶边距
 @param width 宽度
 @param bottom 底边距
 @return 返回当前视图
 */

- (UIView *)whc_AutoHeight:(CGFloat)left top:(CGFloat)top width:(CGFloat)width bottom:(CGFloat)bottom;

/**
 设置frame
 
 @param left 左边距
 @param top 顶边距
 @param right 右边距
 @param bottom 底边距
 @param toView 相对视图
 @return 返回当前视图
 */

- (UIView *)whc_AutoSize:(CGFloat)left top:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom toView:(UIView *)toView;

/**
 设置frame
 
 @param left 左边距
 @param top 顶边距
 @param right 右边距
 @param height 高度
 @param toView 相对视图
 @return 返回当前视图
 */

- (UIView *)whc_AutoWidth:(CGFloat)left top:(CGFloat)top right:(CGFloat)right height:(CGFloat)height toView:(UIView *)toView;

/**
 设置frame (默认相对父视图)
 
 @param left 左边距
 @param top 顶边距
 @param width 宽度
 @param bottom 底边距
 @return 返回当前视图
 */

- (UIView *)whc_AutoHeight:(CGFloat)left top:(CGFloat)top width:(CGFloat)width bottom:(CGFloat)bottom toView:(UIView *)toView;

/**
 设置视图显示宽高
 
 @param size 视图宽高
 @return 返回当前视图
 */

- (UIView *)whc_Size:(CGSize)size;

/**
 设置视图size等于view
 
 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_SizeEqualView:(UIView *)view;

/**
 设置视图frame等于view
 @param view 相对视图
 @return 返回当前视图
 */
- (UIView *)whc_FrameEqualView:(UIView *)view;

#pragma mark - Xib智能布局模块 -

/**
 对整个Xib(使用3.5寸xib)上UI控件垂直和横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoXibLayout;

/**
 对整个Xib(使用3.5寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoXibLayoutType:(WHC_LayoutTypeOptions)type;

/**
 对整个storyboard(使用4.7寸xib)上UI控件垂直和横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoSBLayout;

/**
 对整个storyboard(使用4.7寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoSBLayoutType:(WHC_LayoutTypeOptions)type;

/**
 对整个Xib(使用3.5寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoXibHorizontalLayout;

/**
 对整个Xib(使用3.5寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoXibHorizontalLayoutType:(WHC_LayoutTypeOptions)type;

/**
 对整个storyboard(使用4.7寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoSBHorizontalLayout;

/**
 对整个storyboard(使用4.7寸xib)上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoSBHorizontalLayoutType:(WHC_LayoutTypeOptions)type;

#pragma mark - 自动加边线模块 -

/**
 对视图底部加线
 
 @param value 线宽
 @param color 线的颜色
 @return 返回线视图
 */

- (UIView *)whc_AddBottomLine:(CGFloat)value lineColor:(UIColor *)color;

/**
 对视图底部加线
 
 @param value 线宽
 @param color 线的颜色
 @param pading 内边距
 @return 返回线视图
 */

- (UIView *)whc_AddBottomLine:(CGFloat)value lineColor:(UIColor *)color pading:(CGFloat)pading;

/**
 对视图顶部加线
 
 @param value 线宽
 @param color 线的颜色
 @return 返回线视图
 */

- (UIView *)whc_AddTopLine:(CGFloat)value lineColor:(UIColor *)color;

/**
 对视图顶部加线
 
 @param value 线宽
 @param color 线的颜色
 @param pading 内边距
 @return 返回线视图
 */

- (UIView *)whc_AddTopLine:(CGFloat)value lineColor:(UIColor *)color pading:(CGFloat)pading;

/**
 对视图左边加线
 
 @param value 线宽
 @param color 线的颜色
 @return 返回线视图
 */


- (UIView *)whc_AddLeftLine:(CGFloat)value lineColor:(UIColor *)color;

/**
 对视图左边加线

 @param value   线宽
 @param color   线的颜色
 @param padding 边距
 @return 返回线视图
 */
- (UIView *)whc_AddLeftLine:(CGFloat)value lineColor:(UIColor *)color padding:(CGFloat)padding;

/**
 对视图右边加线
 
 @param value 线宽
 @param color 线的颜色
 @return 返回线视图
 */

- (UIView *)whc_AddRightLine:(CGFloat)value lineColor:(UIColor *)color;

/**
 对视图右边加线
 
 @param value 线宽
 @param color 线的颜色
 @param pading 边距
 @return 返回线视图
 */

- (UIView *)whc_AddRightLine:(CGFloat)value lineColor:(UIColor *)color padding:(CGFloat)padding;
@end
