//
//  UITableViewCell+WHC_AutoHeightForCell.m
//  WHC_AutoAdpaterViewDemo
//
//  Created by 吴海超 on 16/2/17.
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

#import "UITableViewCell+WHC_AutoHeightForCell.h"
#import "UIView+WHC_AutoLayout.h"
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

- (UITableView *)whc_CellTableView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWhc_CellTableView:(UITableView *)whc_CellTableView {
    objc_setAssociatedObject(self,
                             @selector(whc_CellTableView),
                             whc_CellTableView,
                             OBJC_ASSOCIATION_RETAIN);
}

+ (CGFloat)whc_CellHeightForIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    NSAssert(indexPath, @"indexPath = nil");
    NSAssert(tableView, @"tableView = nil");
    if (tableView.whc_CacheHeightDictionary == nil) {
        tableView.whc_CacheHeightDictionary = [NSMutableDictionary dictionary];
    }
    [tableView monitorScreenOrientation];
    NSString * cacheHeightKey = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    NSNumber * cacheHeightValue = [tableView.whc_CacheHeightDictionary objectForKey:cacheHeightKey];
    if (cacheHeightValue != nil) {
        return cacheHeightValue.floatValue;
    }
    UITableViewCell * cell = [tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    NSAssert(cell, @"cell = nil");
    if (cell.whc_CellTableView) {
        [cell.whc_CellTableView whc_Height:cell.whc_CellTableView.contentSize.height];
    }
    CGFloat tableViewWidth = CGRectGetWidth(tableView.frame);
    if (tableViewWidth == 0) return 0;
    CGRect cellFrame = cell.frame;
    cellFrame.size.width = CGRectGetWidth(tableView.frame);
    cell.frame = cellFrame;
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
        Method reloadDataRow = class_getInstanceMethod(self, @selector(reloadRowsAtIndexPaths:withRowAnimation:));
        Method whc_ReloadDataRow = class_getInstanceMethod(self, @selector(whc_ReloadDatasAtIndexPaths:withRowAnimation:));
        Method sectionReloadData = class_getInstanceMethod(self, @selector(reloadSections:withRowAnimation:));
        Method whc_SectionReloadData = class_getInstanceMethod(self, @selector(whc_ReloadSetion:withRowAnimation:));
        method_exchangeImplementations(sectionReloadData, whc_SectionReloadData);
        method_exchangeImplementations(reloadDataRow, whc_ReloadDataRow);
        method_exchangeImplementations(reloadData, whc_ReloadData);
    });
}

- (void)screenWillChange:(NSNotification *)notification {
    [self reloadData];
}

- (void)dealloc {
    if ([self isMonitorScreen]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)monitorScreenOrientation {
    if (![self isMonitorScreen]) {
        [self setDidMonitorScreen];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenWillChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
}

- (void)setDidMonitorScreen {
    objc_setAssociatedObject(self,
                             @selector(isMonitorScreen),
                             @(YES),
                             OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isMonitorScreen {
    id monitor = objc_getAssociatedObject(self, _cmd);
    return monitor == nil ? NO : [monitor boolValue];
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

- (void)whc_ReloadSetion:(NSIndexSet *)sections
        withRowAnimation:(UITableViewRowAnimation)animation {
    if (sections) {
        NSArray * cacheHeightKeyArray = [self.whc_CacheHeightDictionary allKeys];
        [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            NSString * sectionString = [NSString stringWithFormat:@"%ld-",idx];
            for (NSString * cacheHeightKey in cacheHeightKeyArray) {
                if ([cacheHeightKey rangeOfString:sectionString].location != NSNotFound) {
                    [self.whc_CacheHeightDictionary removeObjectForKey:cacheHeightKey];
                }
            }
        }];
    }
    [self whc_ReloadSetion:sections withRowAnimation:animation];
}

- (void)whc_ReloadDatasAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                   withRowAnimation:(UITableViewRowAnimation)animation {
    if (indexPaths) {
        for (NSIndexPath * indexPath in indexPaths) {
            NSString * cacheHeightKey = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
            [self.whc_CacheHeightDictionary removeObjectForKey:cacheHeightKey];
        }
    }
    [self whc_ReloadDatasAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)whc_ReloadData {
    if (self.whc_CacheHeightDictionary != nil) {
        [self.whc_CacheHeightDictionary removeAllObjects];
    }
    [self whc_ReloadData];
}

@end

////////////////////////////集合视图//////////////////////////////

@implementation UICollectionViewCell (WHC_AutoHeightForCell)

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

- (UITableView *)whc_CellTableView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWhc_CellTableView:(UITableView *)whc_CellTableView {
    objc_setAssociatedObject(self,
                             @selector(whc_CellTableView),
                             whc_CellTableView,
                             OBJC_ASSOCIATION_RETAIN);
}

+ (CGFloat)whc_CellHeightForIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView {
    NSAssert(indexPath, @"indexPath = nil");
    NSAssert(collectionView, @"tableView = nil");
    if (collectionView.whc_CacheHeightDictionary == nil) {
        collectionView.whc_CacheHeightDictionary = [NSMutableDictionary dictionary];
    }
    [collectionView monitorScreenOrientation];
    
    NSString * cacheHeightKey = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    NSNumber * cacheHeightValue = [collectionView.whc_CacheHeightDictionary objectForKey:cacheHeightKey];
    if (cacheHeightValue != nil) {
        return cacheHeightValue.floatValue;
    }
    UICollectionViewCell * cell = [collectionView.dataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
    NSAssert(cell, @"cell = nil");
    if (cell.whc_CellTableView) {
        [cell.whc_CellTableView whc_Height:cell.whc_CellTableView.contentSize.height];
    }
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
    [collectionView.whc_CacheHeightDictionary setObject:@(cacheHeight) forKey:cacheHeightKey];
    return cacheHeight;
}

@end

@implementation UICollectionView (WHC_CacheCellHeight)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
        Method whc_ReloadData = class_getInstanceMethod(self, @selector(whc_ReloadData));
        Method reloadItems = class_getInstanceMethod(self, @selector(reloadItemsAtIndexPaths:));
        Method whc_ReloadItems = class_getInstanceMethod(self, @selector(whc_ReloadItemsAtIndexPaths:));
        method_exchangeImplementations(reloadItems, whc_ReloadItems);
        method_exchangeImplementations(reloadData, whc_ReloadData);
        
    });
}

- (void)screenWillChange:(NSNotification *)notification {
    [self reloadData];
}

- (void)dealloc {
    if ([self isMonitorScreen]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)monitorScreenOrientation {
    if (![self isMonitorScreen]) {
        [self setDidMonitorScreen];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenWillChange:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    }
}

- (void)setDidMonitorScreen {
    objc_setAssociatedObject(self,
                             @selector(isMonitorScreen),
                             @(YES),
                             OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isMonitorScreen {
    id monitor = objc_getAssociatedObject(self, _cmd);
    return monitor == nil ? NO : [monitor boolValue];
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

- (void)whc_ReloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (indexPaths) {
        for (NSIndexPath * indexPath in indexPaths) {
            NSString * cacheHeightKey = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section,(long)indexPath.row];
            [self.whc_CacheHeightDictionary removeObjectForKey:cacheHeightKey];
        }
    }
    [self whc_ReloadItemsAtIndexPaths:indexPaths];
}

- (void)whc_ReloadData {
    if (self.whc_CacheHeightDictionary != nil) {
        [self.whc_CacheHeightDictionary removeAllObjects];
    }
    [self whc_ReloadData];
}

@end

