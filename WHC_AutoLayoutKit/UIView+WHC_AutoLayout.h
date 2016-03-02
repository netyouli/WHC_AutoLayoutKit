//
//  UIView+WHC_AutoLayout.h
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

#import <UIKit/UIKit.h>
#import "UITableViewCell+WHC_AutoHeightForCell.h"


typedef NS_OPTIONS(NSUInteger, WHC_LayoutOrientationOptions) {
    /// 垂直布局
    Vertical = 1 << 0,
    /// 横向布局
    Horizontal = 1 << 1,
    /// 垂直布局和横向布局
    All = 1 << 2
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

#pragma mark - UI自动布局 -

@interface UIView (WHC_AutoLayout)

/**
 * 说明: 控件横向和垂直布局宽度或者高度权重比例
 */
@property (nonatomic , assign)CGFloat whc_WidthWeight;
@property (nonatomic , assign)CGFloat whc_HeightWeight;

/**
 * 说明:设置x坐标(默认相对父视图)
 * @param x: 左边距
 */

- (void)whc_X:(CGFloat)x;

/**
 * 说明: 设置x坐标
 * @param x: 左边距
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_X:(CGFloat)x relativeView:(UIView *)relativeView;

/**
 * 说明:设置左边距(默认相对父视图)
 * @param leftSpace: 左边距
 */

- (void)whc_LeftSpace:(CGFloat)leftSpace;

/**
 * 说明:设置左边距
 * @param leftSpace: 左边距
 * @param relativeView: 设置相对参考视图
 */
- (void)whc_LeftSpace:(CGFloat)leftSpace relativeView:(UIView *)relativeView;

/**
 * 说明:设置右边距(默认相对父视图)
 * @param rightSpace: 右边距
 */

- (void)whc_RightSpace:(CGFloat)rightSpace;

/**
 * 说明:设置右边距
 * @param rightSpace: 右边距
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_RightSpace:(CGFloat)rightSpace relativeView:(UIView *)relativeView;

/**
 * 说明:设置y坐标(默认相对父视图)
 * @param y: 顶边距
 */

- (void)whc_Y:(CGFloat)y;

/**
 * 说明:设置y坐标
 * @param y: 顶边距
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_Y:(CGFloat)y relativeView:(UIView *)relativeView;

/**
 * 说明:设置顶边距(默认相对父视图)
 * @param topSpace: 顶边距
 */

- (void)whc_TopSpace:(CGFloat)topSpace;

/**
 * 说明:设置顶边距
 * @param topSpace: 顶边距
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_TopSpace:(CGFloat)topSpace relativeView:(UIView *)relativeView;

/**
 * 说明:设置底边距(默认相对父视图)
 * @param bottomSpace: 底边距边距
 */

- (void)whc_BottomSpace:(CGFloat)bottomSpace;

/**
 * 说明:设置底边距
 * @param bottomSpace: 底边距边距
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_BottomSpace:(CGFloat)bottomSpace relativeView:(UIView *)relativeView;

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
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_CenterX:(CGFloat)centerX relativeView:(UIView *)relativeView;

/**
 * 说明:设置中心y与父视图中心的偏移 centerY = 0 与父视图中心y重合
 * @param centerY: 中心y坐标偏移
 */

- (void)whc_CenterY:(CGFloat)centerY;

/**
 * 说明:设置中心y与相对视图中心的偏移 centerY = 0 与相对视图中心y重合
 * @param centerY: 中心y坐标偏移
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_CenterY:(CGFloat)centerY relativeView:(UIView *)relativeView;

/**
 * 说明:设置文字基线与底部偏移(默认相对父视图)
 * @param lineSpace: 底部偏移
 */

- (void)whc_BaseLineSpace:(CGFloat)lineSpace;

/**
 * 说明:设置文字基线与底部偏移
 * @param lineSpace: 底部偏移
 * @param relativeView: 相对视图
 */

- (void)whc_BaseLineSpace:(CGFloat)lineSpace relativeView:(UIView *)relativeView;
/**
 * 说明:设置xy(左顶边距,默认相对父视图)
 * @param xy: 左边距和顶边距
 */

- (void)whc_XY:(CGPoint)xy;

/**
 * 说明:设置xy(左顶边距,默认相对父视图)
 * @param xy: 左边距和顶边距
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_XY:(CGPoint)xy relativeView:(UIView *)relativeView;

/**
 * 说明:设置中心偏移(默认相对父视图)center = CGPointZero 与父视图中心重合
 * @param center: 中心偏移xy
 */

- (void)whc_Center:(CGPoint)center;

/**
 * 说明:设置中心偏移(默认相对父视图)center = CGPointZero 与父视图中心重合
 * @param center: 中心偏移xy
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_Center:(CGPoint)center relativeView:(UIView *)relativeView;

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

- (void)whc_Frame:(WHCRect)frame relativeView:(UIView *)relativeView;

/**
 * 说明:设置视图显示区域(默认相对父视图,横竖屏仅仅宽度自动收缩)
 * @param frame: 视图显示区域
 * @param relativeView: 设置相对参考视图
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
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_FrameAuto:(WHCAutoRect)frame relativeView:(UIView *)relativeView;

/**
 * 说明:设置视图显示区域(横竖屏宽高可自动收缩)
 * @param frame: 视图显示区域
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_FrameAutoWidth:(WHCWidthAutoRect)frame relativeView:(UIView *)relativeView;

/**
 * 说明:设置视图显示区域(横竖屏高度可自动收缩)
 * @param frame: 视图显示区域
 * @param relativeView: 设置相对参考视图
 */

- (void)whc_FrameAutoHeight:(WHCHeightAutoRect)frame relativeView:(UIView *)relativeView;

/**
 * 说明:设置视图显示宽高
 * @param size: 视图显示区域宽高
 */

- (void)whc_Size:(CGSize)size;

#pragma mark - Xib智能布局模块 -

/**
 * 说明:对整个Xib上UI控件垂直和横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */

- (void)whc_AutoXibLayout;

/**
 * 说明:对整个Xib上UI控件横向智能添加约束进行布局(从此告别xib上拖拽添加约束方式)
 */
- (void)whc_AutoXibHorizontalLayout;

@end

#pragma mark - UI自动布局容器 -
/// 容器布局(可设置垂直和横向以及横向和垂直混合布局方式)
@interface WHC_LayoutContainer : UIView

/// 混合布局(同时垂直和横向)每行多少列
@property (nonatomic , assign) NSInteger whc_Column;
/// 容器内边距
@property (nonatomic , assign) UIEdgeInsets whc_Edge;
/// 容器内子控件之间的空隙
@property (nonatomic , assign) CGFloat whc_Space;
/// 容器自动布局方向
@property (nonatomic , assign) WHC_LayoutOrientationOptions whc_Orientation;

/**
 * 说明：开始进行自动布局
 */
- (void)whc_StartLayout;
@end