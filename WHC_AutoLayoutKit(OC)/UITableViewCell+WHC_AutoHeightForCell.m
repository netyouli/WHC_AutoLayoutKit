//
//  UITableViewCell+WHC_AutoHeightForCell.m
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
    objc_setAssociatedObject(self,
                             @selector(whc_CellBottomViews),
                             whc_CellBottomViews,
                             OBJC_ASSOCIATION_COPY);
}

- (NSArray *)whc_CellBottomViews {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWhc_CellBottomView:(UIView *)whc_CellBottomView {
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
    if (tableView.whc_CacheHeightDictionary == nil) {
        tableView.whc_CacheHeightDictionary = [NSMutableDictionary dictionary];
    }
    [tableView monitorScreenOrientation];
    NSString * cacheHeightKey = @(indexPath.section).stringValue;
    NSMutableArray * sectionCacheHeightArray = tableView.whc_CacheHeightDictionary[cacheHeightKey];
    if (sectionCacheHeightArray != nil) {
        if (sectionCacheHeightArray.count > indexPath.row) {
            return [sectionCacheHeightArray[indexPath.row] floatValue];
        }
    }else {
        sectionCacheHeightArray = [NSMutableArray array];
        [tableView.whc_CacheHeightDictionary setObject:sectionCacheHeightArray forKey:cacheHeightKey];
    }
    UITableViewCell * cell = [tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    if (cell.whc_CellTableView) {
        [cell.whc_CellTableView whc_Height:cell.whc_CellTableView.contentSize.height];
    }
    [tableView layoutIfNeeded];
    CGFloat tableViewWidth = CGRectGetWidth(tableView.frame);
    if (tableViewWidth == 0) return 0;
    CGRect cellFrame = cell.frame;
    cellFrame.size.width = tableViewWidth;
    cell.frame = cellFrame;
    CGRect contentFrame = cell.contentView.frame;
    contentFrame.size.width = tableViewWidth;
    cell.contentView.frame = contentFrame;
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
    [sectionCacheHeightArray addObject:@(cacheHeight)];
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
        Method whc_ReloadDataRow = class_getInstanceMethod(self, @selector(whc_reloadRowsAtIndexPaths:withRowAnimation:));
        Method sectionReloadData = class_getInstanceMethod(self, @selector(reloadSections:withRowAnimation:));
        Method whc_SectionReloadData = class_getInstanceMethod(self, @selector(whc_ReloadSetion:withRowAnimation:));
        Method deleteCell = class_getInstanceMethod(self, @selector(deleteItemsAtIndexPaths:));
        Method whc_deleteCell = class_getInstanceMethod(self, @selector(whc_deleteItemsAtIndexPaths:));
        Method deleteSection = class_getInstanceMethod(self, @selector(deleteSections:));
        Method whc_deleteSection = class_getInstanceMethod(self, @selector(whc_deleteSections:));
        method_exchangeImplementations(sectionReloadData, whc_SectionReloadData);
        method_exchangeImplementations(reloadDataRow, whc_ReloadDataRow);
        method_exchangeImplementations(reloadData, whc_ReloadData);
        method_exchangeImplementations(deleteCell, whc_deleteCell);
        method_exchangeImplementations(deleteSection, whc_deleteSection);
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

- (void)handleCacheHeightDictionary {
    NSArray<NSString *> * allKey = self.whc_CacheHeightDictionary.allKeys.copy;
    __block NSString * frontKey = nil;
    __block NSInteger  index = 0;
    [allKey enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        if (frontKey == nil) {
            frontKey = key;
        }else {
            if (key.integerValue - frontKey.integerValue > 1) {
                if (index == 0) {
                    index = frontKey.integerValue;
                }
                [self.whc_CacheHeightDictionary setObject:self.whc_CacheHeightDictionary[key] forKey:@(allKey[index].integerValue + 1).stringValue];
                [self.whc_CacheHeightDictionary removeObjectForKey:key];
                index = idx;
            }
            frontKey = key;
        }
    }];
}

- (void)whc_deleteSections:(NSIndexSet *)sections {
    if (sections) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            [self.whc_CacheHeightDictionary removeObjectForKey:@(idx).stringValue];
        }];
    }
    [self handleCacheHeightDictionary];
    [self whc_deleteSections:sections];
}

- (void)whc_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (indexPaths) {
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString * cacheHeightKey = @(indexPath.section).stringValue;
            NSMutableArray * sectionCacheHeightArray = self.whc_CacheHeightDictionary[cacheHeightKey];
            if (sectionCacheHeightArray != nil && sectionCacheHeightArray.count > indexPath.row) {
                [sectionCacheHeightArray removeObjectAtIndex:indexPath.row];
            }
        }];
    }
    [self whc_deleteItemsAtIndexPaths:indexPaths];
}

- (void)whc_ReloadSetion:(NSIndexSet *)sections
        withRowAnimation:(UITableViewRowAnimation)animation {
    if (sections) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            [self.whc_CacheHeightDictionary removeObjectForKey:@(idx).stringValue];
        }];
        [self handleCacheHeightDictionary];
    }
    [self whc_ReloadSetion:sections withRowAnimation:animation];
}

- (void)whc_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    if (indexPaths) {
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString * cacheHeightKey = @(indexPath.section).stringValue;
            NSMutableArray * sectionCacheHeightArray = self.whc_CacheHeightDictionary[cacheHeightKey];
            if (sectionCacheHeightArray != nil && sectionCacheHeightArray.count > indexPath.row) {
                [sectionCacheHeightArray removeObjectAtIndex:indexPath.row];
            }
        }];
    }
    [self whc_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
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

