//
//  UITableViewCell+WHC_AutoHeightForCell.m
//  WHC_AutoAdpaterViewDemo
//
//  Created by 吴海超 on 16/2/17.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*
 *  qq:712641411
 *  开发作者: 吴海超(WHC)
 *  iOS技术交流群:302157745
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit
 */

#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import <objc/runtime.h>

@implementation UITableViewCell (WHC_AutoHeightForCell)

- (void)setWhc_CellBottomOffset:(CGFloat)whc_CellBottomOffset {
    objc_setAssociatedObject(self,
                             @selector(whc_CellBottomOffset),
                             @(whc_CellBottomOffset),
                             OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)whc_CellBottomOffset {
    id bottomOffset = objc_getAssociatedObject(self, _cmd);
    return bottomOffset != nil ? [bottomOffset floatValue] : 0;
}

- (void)setWhc_CellBottomViews:(NSArray *)whc_CellBottomViews {
    NSAssert(whc_CellBottomViews, @"cell 底部视图数组不能为nil");
    objc_setAssociatedObject(self,
                             @selector(whc_CellBottomViews),
                             whc_CellBottomViews,
                             OBJC_ASSOCIATION_COPY);
}

- (NSArray *)whc_CellBottomViews {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWhc_CellBottomView:(UIView *)whc_CellBottomView {
    NSAssert(whc_CellBottomView, @"cell 底部视图不能为nil");
    objc_setAssociatedObject(self,
                             @selector(whc_CellBottomView),
                             whc_CellBottomView,
                             OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)whc_CellBottomView {
    return objc_getAssociatedObject(self, _cmd);
}

+ (CGFloat)whc_CellHeightForIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    NSAssert(indexPath, @"indexPath = nil");
    NSAssert(tableView, @"tableView = nil");
    if (tableView.whc_CacheHeightDictionary == nil) {
        tableView.whc_CacheHeightDictionary = [NSMutableDictionary dictionary];
    }
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    if (screenWidth != tableView.whc_CellWidth.floatValue) {
        [tableView.whc_CacheHeightDictionary removeAllObjects];
        tableView.whc_CellWidth = @(screenWidth);
    }
    NSString * cacheHeightKey = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    NSNumber * cacheHeightValue = [tableView.whc_CacheHeightDictionary objectForKey:cacheHeightKey];
    if (cacheHeightValue != nil) {
        return cacheHeightValue.floatValue;
    }
    UITableViewCell * cell = [tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    NSAssert(cell, @"cell = nil");
    cell.frame = CGRectMake(0, 0, screenWidth, CGRectGetHeight(cell.frame));
    cell.contentView.frame = CGRectMake(0, 0, screenWidth, CGRectGetHeight(cell.contentView.frame));
    [cell layoutIfNeeded];
    UIView * bottomView = nil;
    if (cell.whc_CellBottomView != nil) {
        bottomView = cell.whc_CellBottomView;
    }else if(cell.whc_CellBottomViews != nil && cell.whc_CellBottomViews.count > 0) {
        bottomView = cell.whc_CellBottomViews[0];
        for (int i = 1; i < cell.whc_CellBottomViews.count; i++) {
            UIView * view = cell.whc_CellBottomViews[i];
            if (CGRectGetMaxY(bottomView.frame) < CGRectGetMaxY(view.frame)) {
                bottomView = view;
            }
        }
    }else {
        NSArray * cellSubViews = cell.contentView.subviews;
        if (cellSubViews.count > 0) {
            bottomView = cellSubViews[0];
            for (int i = 1; i < cellSubViews.count; i++) {
                UIView * view = cellSubViews[i];
                if (CGRectGetMaxY(bottomView.frame) < CGRectGetMaxY(view.frame)) {
                    bottomView = view;
                }
            }
        }else {
            bottomView = cell.contentView;
        }
    }
    CGFloat cacheHeight = CGRectGetMaxY(bottomView.frame) + cell.whc_CellBottomOffset;
    [tableView.whc_CacheHeightDictionary setObject:@(cacheHeight) forKey:cacheHeightKey];
    return cacheHeight;
}

@end

@implementation UITableView (WHC_CacheCellHeight)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
        Method whc_ReloadData = class_getInstanceMethod(self, @selector(whc_ReloadData));
        method_exchangeImplementations(reloadData, whc_ReloadData);
    });
}

- (void)setWhc_CellWidth:(NSNumber *)whc_CellWidth {
    objc_setAssociatedObject(self,
                             @selector(whc_CellWidth),
                             whc_CellWidth,
                             OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)whc_CellWidth {
    id width = objc_getAssociatedObject(self, _cmd);
    return width == nil ? @(0) : width;
}

- (void)setWhc_CacheHeightDictionary:(NSMutableDictionary *)whc_CacheHeightDictionary {
    objc_setAssociatedObject(self,
                             @selector(whc_CacheHeightDictionary),
                             whc_CacheHeightDictionary,
                             OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableDictionary *)whc_CacheHeightDictionary {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)whc_ReloadData {
    if (self.whc_CacheHeightDictionary != nil) {
        [self.whc_CacheHeightDictionary removeAllObjects];
    }
    [self whc_ReloadData];
}

@end
