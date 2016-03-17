//
//  UIView+WHC_AutoLayout.h
//  WHC_AutoAdpaterViewDemo
//
//  Created by 吴海超 on 16/1/16.
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

/**
 * WHCRect 类似 CGRect 用来构建一个View显示区域,但是与CGRect有点不同的是没有width和height属性而是right和bottom
 */

struct WHCRect {
    /// 左边距类似x
    CGFloat left;
    /// 顶边距类似y
    CGFloat top;
    /// 宽度(固定不可收缩)
    CGFloat width;
    /// 高度(固定不可收缩)
    CGFloat height;
};

struct WHCAutoRect {
    /// 左边距类似x
    CGFloat left;
    /// 顶边距类似y
    CGFloat top;
    /// 右边距(可自动收缩)
    CGFloat right;
    /// 底边距(可自动收缩)
    CGFloat bottom;
};

struct WHCWidthAutoRect {
    /// 左边距类似x
    CGFloat left;
    /// 顶边距类似y
    CGFloat top;
    /// 右边距(可自动收缩)
    CGFloat right;
    /// 高度(固定不可收缩)
    CGFloat height;
};

struct WHCHeightAutoRect {
    /// 左边距类似x
    CGFloat left;
    /// 顶边距类似y
    CGFloat top;
    /// 宽度(固定不可收缩)
    CGFloat width;
    /// 底边距(可自动收缩)
    CGFloat bottom;
};

typedef struct WHCRect WHCRect;

typedef struct WHCAutoRect WHCAutoRect;

typedef struct WHCWidthAutoRect WHCWidthAutoRect;

typedef struct WHCHeightAutoRect WHCHeightAutoRect;

/**
 * 构建view显示区域(横竖屏宽高固定)
 */
WHCRect WHCRectMake(CGFloat left ,
                    CGFloat top ,
                    CGFloat width,
                    CGFloat height);

/**
 * 构建view显示区域(横竖屏宽高可自动收缩)
 */
WHCAutoRect WHCAutoRectMake(CGFloat left ,
                            CGFloat top ,
                            CGFloat right,
                            CGFloat bottom);

/**
 * 构建view显示区域(横竖屏仅仅宽度自动收缩)
 */

WHCWidthAutoRect WHCWidthAutoRectMake(CGFloat left ,
                                      CGFloat top ,
                                      CGFloat right,
                                      CGFloat height);

/**
 * 构建view显示区域(横竖屏仅仅高度自动收缩)
 */

WHCHeightAutoRect WHCHeightAutoRectMake(CGFloat left ,
                                        CGFloat top ,
                                        CGFloat width,
                                        CGFloat bottom);

typedef UIView * (^LeftSpace)(CGFloat value);
typedef UIView * (^LeftSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^LeftSpaceEqualView)(UIView * view);

typedef UIView * (^LeadingSpace)(CGFloat value);
typedef UIView * (^LeadingSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^LeadingSpaceEqualView)(UIView * view);

typedef UIView * (^TrailingSpace)(CGFloat value);
typedef UIView * (^TrailingSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^TrailingSpaceEqualView)(UIView * view);

typedef UIView * (^BaseLineSpace)(CGFloat value);
typedef UIView * (^BaseLineSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^BaseLineSpaceEqualView)(UIView * view);

typedef UIView * (^RightSpace)(CGFloat value);
typedef UIView * (^RightSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^RightSpaceEqualView)(UIView * view);

typedef UIView * (^TopSpace)(CGFloat value);
typedef UIView * (^TopSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^TopSpaceEqualView)(UIView * view);

typedef UIView * (^BottomSpace)(CGFloat value);
typedef UIView * (^BottomSpaceToView)(CGFloat value , UIView * toView);
typedef UIView * (^BottomSpaceEqualView)(UIView * view);

typedef UIView * (^Width)(CGFloat value);
typedef UIView * (^WidthAuto)();
typedef UIView * (^WidthEqualView)(UIView * view);
typedef UIView * (^WidthEqualViewRatio)(UIView * view, CGFloat ratio);

typedef UIView * (^Height)(CGFloat value);
typedef UIView * (^HeightAuto)();
typedef UIView * (^HeightEqualView)(UIView * view);
typedef UIView * (^HeightEqualViewRatio)(UIView * view, CGFloat ratio);

typedef UIView * (^CenterX)(CGFloat value);
typedef UIView * (^CenterXToView)(CGFloat value, UIView * toView);

typedef UIView * (^CenterY)(CGFloat value);
typedef UIView * (^CenterYToView)(CGFloat value, UIView * toView);

typedef UIView * (^Center)(CGPoint center);
typedef UIView * (^CenterToView)(CGPoint center, UIView * toView);

typedef UIView * (^Frame)(WHCRect frame);
typedef UIView * (^FrameToView)(WHCRect frame , UIView * toView);

typedef UIView * (^FrameAutoWidth)(WHCWidthAutoRect frame);
typedef UIView * (^FrameAutoWidthToView)(WHCWidthAutoRect frame ,UIView * toView);

typedef UIView * (^FrameAutoHeight)(WHCHeightAutoRect frame);
typedef UIView * (^FrameAutoHeightToView)(WHCHeightAutoRect frame,UIView * toView);

typedef UIView * (^FrameAuto)(WHCAutoRect frame);
typedef UIView * (^FrameAutoToView)(WHCAutoRect frame, UIView * toView);

typedef UIView * (^size)(CGSize size);

#pragma mark - UI自动布局 -

@interface UIView (WHC_AutoLayout)

#pragma mark - api version ~ 2.0 -

/// 与父视图左边间距(CGFloat value)
@property (nonatomic ,copy , readonly)LeftSpace whc_LeftSpace;
/// 与相对视图toView左边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)LeftSpaceToView whc_LeftSpaceToView;
/// 与视图view左边间距相等(UIView * view)
@property (nonatomic ,copy , readonly)LeftSpaceEqualView whc_LeftSpaceEqualView;

/// 与父视图左边间距(CGFloat value)
@property (nonatomic ,copy , readonly)LeadingSpace whc_LeadingSpace;
/// 与相对视图toView左边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)LeadingSpaceToView whc_LeadingSpaceToView;
/// 与视图view左边间距相等(UIView * view)
@property (nonatomic ,copy , readonly)LeadingSpaceEqualView whc_LeadingSpaceEqualView;

/// 与父视图右边间距(CGFloat value)
@property (nonatomic ,copy , readonly)TrailingSpace whc_TrailingSpace;
/// 与相对视图toView右边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)TrailingSpaceToView whc_TrailingSpaceToView;
/// 与视图view右边间距相等(UIView * view)
@property (nonatomic ,copy , readonly)TrailingSpaceEqualView whc_TrailingSpaceEqualView;

/// 与父视图底边间距Y(CGFloat value)
@property (nonatomic ,copy , readonly)BaseLineSpace whc_BaseLineSpace;
/// 与相对视图toView底边间距Y(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)BaseLineSpaceToView whc_BaseLineSpaceToView;
/// 与视图view底边间距Y相等(UIView * view)
@property (nonatomic ,copy , readonly)BaseLineSpaceEqualView whc_BaseLineSpaceEqualView;

/// 与父视图右边间距(CGFloat value)
@property (nonatomic ,copy , readonly)RightSpace whc_RightSpace;
/// 与相对视图toView右边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)RightSpaceToView whc_RightSpaceToView;

/// 与父视图顶边间距(CGFloat value)
@property (nonatomic ,copy , readonly)TopSpace whc_TopSpace;
/// 与相对视图toView顶边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)TopSpaceToView whc_TopSpaceToView;
/// 与视图view顶边间距相等(UIView * view)
@property (nonatomic ,copy , readonly)TopSpaceEqualView whc_TopSpaceEqualView;

/// 与父视图底边间距(CGFloat value)
@property (nonatomic ,copy , readonly)BottomSpace whc_BottomSpace;
/// 与相对视图toView底边间距(CGFloat value,UIView * toView)
@property (nonatomic ,copy , readonly)BottomSpaceToView whc_BottomSpaceToView;

/// 宽度(CGFloat value)
@property (nonatomic ,copy , readonly)Width whc_Width;
/// 宽度自动()
@property (nonatomic ,copy , readonly)WidthAuto whc_widthAuto;
/// 宽度等于视图view(UIView * view)
@property (nonatomic ,copy , readonly)WidthEqualView whc_WidthEqualView;
/// 宽度等于视图view 参照比例Ratio(UIView * view ,CGFloat ratio)
@property (nonatomic ,copy , readonly)WidthEqualViewRatio whc_WidthEqualViewRatio;

/// 高度(CGFloat value)
@property (nonatomic ,copy , readonly)Height whc_Height;
/// 高度自动()
@property (nonatomic ,copy , readonly)HeightAuto whc_heightAuto;
/// 高度等于视图view(UIView * view)
@property (nonatomic ,copy , readonly)HeightEqualView whc_HeightEqualView;
/// 高度等于视图view 参照比例Ratio(UIView * view ,CGFloat ratio)
@property (nonatomic ,copy , readonly)HeightEqualViewRatio whc_HeightEqualViewRatio;

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

/// 普通frame设置(WHC_Rect frame)
@property (nonatomic ,copy , readonly)Frame whc_Frame;
/// 普通frame设置相对toView(WHC_Rect frame , UIView * toView)
@property (nonatomic ,copy , readonly)FrameToView whc_FrameToView;

/// frame设置自动宽度(WHCWidthAutoRect frame)
@property (nonatomic ,copy , readonly)FrameAutoWidth whc_FrameAutoWidth;
/// frame设置自动宽度相对toView(WHCWidthAutoRect frame, UIView * toView)
@property (nonatomic ,copy , readonly)FrameAutoWidthToView whc_FrameAutoWidthToView;

/// frame设置自动高度(WHCHeightAutoRect frame)
@property (nonatomic ,copy , readonly)FrameAutoHeight whc_FrameAutoHeight;
/// frame设置自动高度相对toView(WHCHeightAutoRect frame, UIView * toView)
@property (nonatomic ,copy , readonly)FrameAutoHeightToView whc_FrameAutoHeightToView;

/// frame设置自动高宽度(WHCAutoRect frame)
@property (nonatomic ,copy , readonly)FrameAuto whc_FrameAuto;
/// frame设置自动高宽度相对toView(WHCAutoRect frame, UIView * toView)
@property (nonatomic ,copy , readonly)FrameAutoToView whc_FrameAutoToView;

/// size设置(Size size)
@property (nonatomic ,copy , readonly)size whc_Size;

#pragma mark - api version ~ 1.0 -

/**
 * 说明: 自动调整UiScrollview的ContentSize
 */
- (void)whc_AutoContentSize;

/**
 * 说明:设置x坐标(默认相对父视图)
 * @param x: 左边距
 */

- (void)whc_X:(CGFloat)x;

/**
 * 说明: 设置x坐标
 * @param x: 左边距
 * @param toView: 设置相对参考视图
 */

- (void)whc_X:(CGFloat)x toView:(UIView *)toView;

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
 * 说明：设置左对齐边距与某视图左对齐边距相等
 */
- (void)whc_LeftSpaceEqualView:(UIView *)view;

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
 * 说明:设置y坐标(默认相对父视图)
 * @param y: 顶边距
 */

- (void)whc_Y:(CGFloat)y;

/**
 * 说明:设置y坐标
 * @param y: 顶边距
 * @param toView: 设置相对参考视图
 */

- (void)whc_Y:(CGFloat)y toView:(UIView *)toView;

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
 * 说明：设置顶边距与某视图顶边距相等
 */

- (void)whc_TopSpaceEqualView:(UIView *)view;

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
 * 说明:设置宽度与某个视图相等
 * @param ratio: 宽度比例
 * @param view: 相等视图
 */

- (void)whc_WidthEqualView:(UIView *)view ratio:(CGFloat)ratio;

/**
 * 说明:自动拉伸宽度根据字符内容(只针对UILabel)
 */
- (void)whc_WidthAuto;

/**
 * 说明:设置高度
 * @param height: 高度
 */

- (void)whc_Height:(CGFloat)height;

/**
 * 说明:设置高度与某个视图相等
 * @param view: 相等视图
 */

- (void)whc_HeightEqualView:(UIView *)view;

/**
 * 说明:设置高度与某个视图相等
 * @param ratio: 宽度比例
 * @param view: 相等视图
 */

- (void)whc_HeightEqualView:(UIView *)view ratio:(CGFloat)ratio;

/**
 * 说明:自动拉伸高度根据字符内容(只针对UILabel)
 */
- (void)whc_HeightAuto;

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
 * 说明:设置xy(左顶边距,默认相对父视图)
 * @param xy: 左边距和顶边距
 */

- (void)whc_XY:(CGPoint)xy;

/**
 * 说明:设置xy(左顶边距,默认相对父视图)
 * @param xy: 左边距和顶边距
 * @param toView: 设置相对参考视图
 */

- (void)whc_XY:(CGPoint)xy toView:(UIView *)toView;

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
 * 说明:设置视图显示区域(默认相对父视图,宽度高度固定)
 * @param frame: 视图显示区域
 */

- (void)whc_Frame:(WHCRect)frame;

/**
 * 说明:设置视图显示区域(默认相对父视图,横竖屏宽高可自动收缩)
 * @param frame: 视图显示区域
 */

- (void)whc_FrameAuto:(WHCAutoRect)frame;

/**
 * 说明:设置视图显示区域(宽度高度固定)
 * @param frame: 视图显示区域
 */

- (void)whc_Frame:(WHCRect)frame toView:(UIView *)toView;

/**
 * 说明:设置视图显示区域(默认相对父视图,横竖屏仅仅宽度自动收缩)
 * @param frame: 视图显示区域
 * @param toView: 设置相对参考视图
 */

- (void)whc_FrameAutoWidth:(WHCWidthAutoRect)frame;

/**
 * 说明:设置视图显示区域(默认相对父视图,横竖屏仅仅高度自动收缩)
 * @param frame: 视图显示区域
 */

- (void)whc_FrameAutoHeight:(WHCHeightAutoRect)frame;

/**
 * 说明:设置视图显示区域(横竖屏宽高可自动收缩)
 * @param frame: 视图显示区域
 * @param toView: 设置相对参考视图
 */

- (void)whc_FrameAuto:(WHCAutoRect)frame toView:(UIView *)toView;

/**
 * 说明:设置视图显示区域(横竖屏宽高可自动收缩)
 * @param frame: 视图显示区域
 * @param toView: 设置相对参考视图
 */

- (void)whc_FrameAutoWidth:(WHCWidthAutoRect)frame toView:(UIView *)toView;

/**
 * 说明:设置视图显示区域(横竖屏高度可自动收缩)
 * @param frame: 视图显示区域
 * @param toView: 设置相对参考视图
 */

- (void)whc_FrameAutoHeight:(WHCHeightAutoRect)frame toView:(UIView *)toView;

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

- (void)whc_BottomLine:(CGFloat)value lineColor:(UIColor *)color;

/**
 * 说明: 对视图顶部加线
 * @param value: 线宽
 * @param color: 线的颜色
 */

- (void)whc_TopLine:(CGFloat)value lineColor:(UIColor *)color;

/**
 * 说明: 对视图左边加线
 * @param value: 线宽
 * @param color: 线的颜色
 */

- (void)whc_LeftLine:(CGFloat)value lineColor:(UIColor *)color;

/**
 * 说明: 对视图右边加线
 * @param value: 线宽
 * @param color: 线的颜色
 */

- (void)whc_RightLine:(CGFloat)value lineColor:(UIColor *)color;
@end
