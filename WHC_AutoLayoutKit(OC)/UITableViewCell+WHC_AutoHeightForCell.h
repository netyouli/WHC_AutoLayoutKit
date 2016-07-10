//
//  UITableViewCell+WHC_AutoHeightForCell.h
//  WHC_AutoAdpaterViewDemo
//
//  Created by 吴海超 on 16/2/17.
//  Copyright © 2016年 吴海超. All rights reserved.
//

#import <UIKit/UIKit.h>

/*************************************************************
 *                                                           *
 *  qq:712641411                                             *
 *  开发作者: 吴海超(WHC)                                      *
 *  iOS技术交流群:302157745                                    *
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit     *
 *                                                           *
 *************************************************************/

////////////////////////////列表视图//////////////////////////////

@interface UITableViewCell (WHC_AutoHeightForCell)
/// cell最底部视图
@property (nonatomic , strong) UIView * whc_CellBottomView;
/// cell最底部视图集合
@property (nonatomic , strong) NSArray * whc_CellBottomViews;
/// cell最底部视图与cell底部的间隙
@property (nonatomic , assign) CGFloat  whc_CellBottomOffset;
/// cell中包含的UITableView
@property (nonatomic , strong) UITableView * whc_CellTableView;

/// 自动计算cell高度
+ (CGFloat)whc_CellHeightForIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;
@end

@interface UITableView (WHC_CacheCellHeight)

/// 缓存cell高度字典
@property (nonatomic , strong) NSMutableDictionary * whc_CacheHeightDictionary;

- (void)screenWillChange:(NSNotification *)notification;

- (void)monitorScreenOrientation;

- (NSMutableDictionary *)whc_CacheHeightDictionary;
@end

////////////////////////////集合视图//////////////////////////////

@interface UICollectionViewCell (WHC_AutoHeightForCell)

/// cell最底部视图
@property (nonatomic , strong) UIView * whc_CellBottomView;
/// cell最底部视图集合
@property (nonatomic , strong) NSArray * whc_CellBottomViews;
/// cell最底部视图与cell底部的间隙
@property (nonatomic , assign) CGFloat  whc_CellBottomOffset;
/// cell中包含的UITableView
@property (nonatomic , strong) UITableView * whc_CellTableView;

/// 自动计算cell高度
+ (CGFloat)whc_CellHeightForIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView;

@end

@interface UICollectionView (WHC_CacheCellHeight)

/// 缓存cell高度字典
@property (nonatomic , strong) NSMutableDictionary * whc_CacheHeightDictionary;

- (void)monitorScreenOrientation;

@end
