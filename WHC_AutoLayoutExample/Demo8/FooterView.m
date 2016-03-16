//
//  FooterView.m
//  WHC_AutoLayoutExample
//
//  Created by 吴海超 on 16/3/15.
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

#import "FooterView.h"

@interface FooterView ()
@property (nonatomic ,strong) IBOutlet UIActivityIndicatorView * indicatorView;
@end

@implementation FooterView

- (void)awakeFromNib {
    [_indicatorView startAnimating];
}

@end
