//
//  DemoVC1.m
//  WHC_AutoLayoutExample
//
//  Created by 吴海超 on 16/2/29.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*********************************************************
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit *
 *  本人其他优秀开源库：https://github.com/netyouli          *
 *********************************************************/

#import "DemoVC1.h"
#import "UIView+WHC_AutoLayout.h"
#import "WHC_StackView.h"

@interface DemoVC1 () {
    UIView  * view1, * view2, * view3;
    UILabel * lable;
    UILabel * lable1,*lable2,*lable3;
    CGFloat width , height;
}
@end

@implementation DemoVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"普通高度宽度自动布局";
    self.view.backgroundColor = [UIColor whiteColor];
    
    view1 = [UIView new];
    view2 = [UIView new];
    view3 = [UIView new];
    lable = [UILabel new];
    
    view1.backgroundColor = [UIColor orangeColor];
    view2.backgroundColor = [UIColor grayColor];
    view3.backgroundColor = [UIColor redColor];
    lable.backgroundColor = [UIColor magentaColor];
    lable.text = @"dkdlskdlakdlakgjkdjgkajkgjdljidslidgjaldkgakjnvjndsjlagjdjlnsjdkjlsjakdalkdajakfjsalgjaljgasd";
    
    UIButton * btn = [UIButton new];
    [btn setTitle:@"收起" forState:UIControlStateNormal];
    [btn setTitle:@"展开" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [view2 addSubview:lable];
    
    btn.whc_BaseLineSpace(10).whc_LeftSpace(0).whc_RightSpace(0).whc_Height(40);
    
    /// 一行代码添加约束
    view1.whc_LeftSpace(10)
         .whc_TopSpace(74)
         .whc_WidthEqualView(view2)
         .whc_Height(150);
    view2.whc_LeftSpaceToView(10,view1)
         .whc_TopSpace(74)
         .whc_RightSpace(10)
         .whc_HeightAuto();
 
}


- (void)clickButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        lable.whc_heightAutoKeepBottomConstraint(YES);
    }else {
        lable.whc_HeightKeepBottomConstraint(20,YES);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /// 一行代码添加约束
    lable.whc_LeftSpace(10)
        .whc_RightSpace(10)
        .whc_TopSpace(10)
        .whc_BottomSpace(20)
        .whc_HeightKeepBottomConstraint(40,YES);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
