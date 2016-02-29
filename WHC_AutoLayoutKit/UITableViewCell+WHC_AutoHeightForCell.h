//
//  UITableViewCell+WHC_AutoHeightForCell.h
//  WHC_AutoAdpaterViewDemo
//
//  Created by 吴海超 on 16/2/17.
//  Copyright © 2016年 吴海超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (WHC_AutoHeightForCell)
/// cell最底部视图
@property (nonatomic , strong) UIView * whc_CellBottomView;
/// cell最底部视图集合
@property (nonatomic , strong) NSArray * whc_CellBottomViews;
/// cell最底部视图与cell底部的间隙
@property (nonatomic , assign) CGFloat  whc_CellBottomOffset;

/// 自动计算cell高度
+ (CGFloat)whc_CellHeightForIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

@end

@interface UITableView (WHC_CacheCellHeight)

/// 缓存cell高度字典
@property (nonatomic , strong) NSMutableDictionary * whc_CacheHeightDictionary;
/// cell宽度
@property (nonatomic , strong) NSNumber * whc_CellWidth;

@end
