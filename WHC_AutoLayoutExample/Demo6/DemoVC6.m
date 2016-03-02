//
//  DemoVC6.m
//  WHC_AutoLayoutExample
//
//  Created by 吴海超 on 16/3/1.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*
 *  qq:712641411
 *  开发作者: 吴海超(WHC)
 *  iOS技术交流群:460122071
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutExample
 */

#import "DemoVC6.h"
#import "UIView+WHC_AutoLayout.h"

@interface DemoVC6 ()

@end

@implementation DemoVC6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =
    @"一行代码对Xib上所有控件进行智能布局";
    /**
     * 智能识别xib上所有UI控件之间约束关系
     * 来自动给xib上所有控件进行自动添加相
     * 应约束关系
     */
    
    /// 对xib上所有控件横向和垂直进行智能布局
    [self.view whc_AutoXibLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
