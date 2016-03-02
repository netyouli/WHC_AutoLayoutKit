//
//  DemoVC2Cell.m
//  WHC_AutoLayoutExample
//
//  Created by 吴海超 on 16/2/29.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*
 *  qq:712641411
 *  开发作者: 吴海超(WHC)
 *  iOS技术交流群:302157745
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutExample
 */

#import "DemoVC2Cell.h"
#import "UIView+WHC_AutoLayout.h"

@interface DemoVC2Cell (){
    UILabel *  _image;
    UILabel *  _title;
    UILabel *  _content;
    UILabel *  _other;
}

@end

@implementation DemoVC2Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _image = [UILabel new];
        _title = [UILabel new];
        _content = [UILabel new];
        
        _image.backgroundColor = [UIColor orangeColor];
        _title.backgroundColor = [UIColor grayColor];
        _content.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        
        [self.contentView addSubview:_image];
        [self.contentView addSubview:_title];
        [self.contentView addSubview:_content];
        
        _title.text = @"WHC";
        _title.font = [UIFont systemFontOfSize:20];
        _title.textColor = [UIColor redColor];
        
        [_title whc_FrameAutoWidth:WHCWidthAutoRectMake(10, 0, 10, 30)];
        
        [_image whc_LeftSpace:10];
        [_image whc_TopSpace:10 relativeView:_title];
        [_image whc_Size:CGSizeMake(40, 40)];
        
        [_content whc_TopSpace:10 relativeView:_title];
        [_content whc_LeftSpace:10 relativeView:_image];
        [_content whc_RightSpace:10];
        [_content whc_HeightAuto];
        
        self.whc_CellBottomOffset = 10;
        
    }
    return self;
}

- (void)setContent:(NSString *)content index:(NSInteger)index {
    _content.text = content;
    if (index < 5) {
        if (_other == nil) {
            _other = [UILabel new];
            _other.backgroundColor = [UIColor magentaColor];
            [self.contentView addSubview:_other];
            [_other whc_TopSpace:10 relativeView:_content];
            [_other whc_LeftSpace:10 relativeView:_image];
            [_other whc_RightSpace:10];
            [_other whc_HeightAuto];
        }
        _other.text = content;
        self.whc_CellBottomView = _other;
    }else {
        if (_other) {
            [_other removeFromSuperview];
            _other = nil;
        }
        self.whc_CellBottomView = _content;
    }
}

@end
