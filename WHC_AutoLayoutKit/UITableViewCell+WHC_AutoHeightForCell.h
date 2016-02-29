//
//  UITableViewCell+WHC_AutoHeightForCell.h
//  WHC_AutoAdpaterViewDemo
//
//  Created by 吴海超 on 16/2/17.
//  Copyright © 2016年 吴海超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (WHC_AutoHeightForCell)

@property (nonatomic , strong) UIView * whc_CellBottomView;
@property (nonatomic , strong) NSArray * whc_CellBottomViews;
@property (nonatomic , assign) CGFloat  whc_CellBottomOffset;


+ (CGFloat)whc_CellHeightForIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

@end

@interface UITableView (WHC_CacheCellHeight)

@property (nonatomic , strong) NSMutableDictionary * whc_CacheHeightDictionary;
@property (nonatomic , strong) NSNumber * whc_CellWidth;

@end
