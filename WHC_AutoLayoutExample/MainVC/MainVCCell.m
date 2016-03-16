//
//  MainVCCell.m
//  WHC_AutoAdpaterViewDemo
//
//  Created by 吴海超 on 16/2/22.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*
 *  qq:712641411
 *  开发作者: 吴海超(WHC)
 *  iOS技术交流群:302157745
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit
 */

#import "MainVCCell.h"
#import "UIView+WHC_AutoLayout.h"

@interface MainVCCell () {
    UILabel * _title , * _content;
}

@end

@implementation MainVCCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _title = [UILabel new];
        _content = [UILabel new];
        [self.contentView addSubview:_title];
        [self.contentView addSubview:_content];
        _title.textColor = [UIColor redColor];
        _title.font = [UIFont boldSystemFontOfSize:20];
        [_title whc_FrameAutoWidth:WHCWidthAutoRectMake(10, 10, 10, 30)];
        [_content whc_LeftSpace:10];
        [_content whc_TopSpace:10 toView:_title];
        [_content whc_RightSpace:10];
        [_content whc_HeightAuto];
        self.whc_CellBottomOffset = 10;
        self.whc_CellBottomView = _content;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(NSString *)content title:(NSString *)title {
    _title.text = title;
    _content.text = content;
}

@end
