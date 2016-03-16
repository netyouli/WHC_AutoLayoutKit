//
//  DemoVC1.m
//  WHC_AutoLayoutExample
//
//  Created by 吴海超 on 16/2/29.
//  Copyright © 2016年 吴海超. All rights reserved.
//

/*
 *  qq:712641411
 *  开发作者: 吴海超(WHC)
 *  iOS技术交流群:302157745
 *  gitHub:https://github.com/netyouli/WHC_AutoLayoutKit
 */

#import "DemoVC1.h"
#import "UIView+WHC_AutoLayout.h"

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
    lable.backgroundColor = [UIColor orangeColor];
    lable.text = @"dkdlskdlakdlakgjkdjgkajkgjdljidslidgjaldkgakjnvjndsjlagjdjlnsjdkjlsjakdalkdajakfjsalgjaljgasd";
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [self.view addSubview:lable];
    
    [view1 whc_LeftSpace:10];
    [view1 whc_TopSpace:74];
    [view1 whc_WidthEqualView:view2];
    [view1 whc_Height:150];
    
    [view2 whc_LeftSpace:10 toView:view1];
    [view2 whc_TopSpace:74];
    [view2 whc_RightSpace:10];
    [view2 whc_HeightEqualView:view1];
    
    [view3 whc_Y:10 toView:view1];
    [view3 whc_RightSpace:10];
    [view3 whc_HeightEqualView:view2];
    [view3 whc_LeftSpace:10 toView:view1];
    
    [lable whc_LeftSpace:10];
    [lable whc_RightSpace:10 toView:view3];
    [lable whc_TopSpace:10 toView:view1];
    [lable whc_HeightAuto];
    
    lable1 = [UILabel new];
    lable2 = [UILabel new];
    lable3 = [UILabel new];
    
    lable1.backgroundColor = [UIColor grayColor];
    lable2.backgroundColor = [UIColor grayColor];
    lable3.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:lable1];
    [self.view addSubview:lable2];
    [self.view addSubview:lable3];
    
    
    [lable1 whc_LeadingSpace:10];
    [lable1 whc_TopSpace:10 toView:view3];
    [lable1 whc_WidthEqualView:lable2];
    [lable1 whc_Height:100];
    
    [lable2 whc_LeadingSpace:10 toView:lable1];
    [lable2 whc_TopSpaceEqualView:lable1];
    [lable2 whc_WidthEqualView:lable3];
    [lable2 whc_HeightEqualView:lable1];
    
    [lable3 whc_LeadingSpace:10 toView:lable2];
    [lable3 whc_TopSpaceEqualView:lable2];
    [lable3 whc_RightSpace:10];
    [lable3 whc_HeightEqualView:lable2];
    
    [lable removeFromSuperview];
 
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view addSubview:lable];
    [lable whc_LeftSpace:10];
    [lable whc_RightSpace:10 toView:view3];
    [lable whc_TopSpace:10 toView:view1];
    [lable whc_HeightAuto];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
