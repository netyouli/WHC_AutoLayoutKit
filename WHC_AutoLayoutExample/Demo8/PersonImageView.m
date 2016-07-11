//
//  PersonImageView.m
//  WHC_AutoLayoutExample
//
//  Created by 吴海超 on 16/3/10.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*
 *  qq:712641411
 *  开发作者: 吴海超(WHC)
 *  iOS技术交流群:490149447
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit
 */

#import "PersonImageView.h"
#import "UIView+WHC_AutoLayout.h"

@interface PersonImageView ()
@property (nonatomic , strong)IBOutlet UIImageView * backgroundImageView;
@property (nonatomic , strong)IBOutlet UILabel * titleLable;
@property (nonatomic , strong)IBOutlet UIView * personView;
@end

@implementation PersonImageView

- (void)awakeFromNib {
    _backgroundImageView.whc_RightSpace(0);
    _personView.whc_TrailingSpace(20);
    _titleLable.whc_TrailingSpaceToView(15,_personView);

}



@end
