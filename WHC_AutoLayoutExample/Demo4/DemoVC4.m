//
//  DemoVC4.m
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

#import "DemoVC4.h"
#import "UIView+WHC_AutoLayout.h"


@interface DemoVC4 (){
    WHC_LayoutContainer * container1, *container2;
}

@end

@implementation DemoVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"StockView 垂直自动布局";
    // 创建容器视图12
    container1 = [WHC_LayoutContainer new];
    container2 = [WHC_LayoutContainer new];
    
    container1.backgroundColor = [UIColor orangeColor];
    container2.backgroundColor = [UIColor magentaColor];
    
    [self.view addSubview:container2];
    [self.view addSubview:container1];
    
    // 容器视图1布局
    [container1 whc_FrameAutoWidth:WHCWidthAutoRectMake(0, 64, 0, 150)];
    [container1 whc_HeightEqualView:container2];
    
    // 容器视图1配置
    container1.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10);
    container1.whc_Orientation = Vertical;// 自动垂直布局
    container1.whc_Space = 10;
    
    UILabel * lable1 = [UILabel new];
    UILabel * lable2 = [UILabel new];
    UILabel * lable3 = [UILabel new];
    UILabel * lable4 = [UILabel new];
    
    lable1.backgroundColor = [UIColor grayColor];
    lable2.backgroundColor = [UIColor magentaColor];
    lable3.backgroundColor = [UIColor redColor];
    lable4.backgroundColor = [UIColor yellowColor];
    
    // 添加到容器视图
    [container1 addSubview:lable1];
    [container1 addSubview:lable2];
    [container1 addSubview:lable3];
    [container1 addSubview:lable4];
    
    // 容器视图2布局
    [container2 whc_LeftSpace:0];
    [container2 whc_TopSpace:10 relativeView:container1];
    [container2 whc_RightSpace:0];
    [container2 whc_BottomSpace:10];
    
    // 容器视图2配置
    container2.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10);
    container2.whc_Orientation = Vertical;// 自动垂直布局;
    container2.whc_Space = 10;
    
    // 创建容器视图2的子容器视图（容器嵌套使用）
    WHC_LayoutContainer * subContainer21 = [WHC_LayoutContainer new];
    WHC_LayoutContainer * subContainer22 = [WHC_LayoutContainer new];
    
    subContainer21.backgroundColor = [UIColor orangeColor];
    subContainer22.backgroundColor = [UIColor orangeColor];
    
    // 添加容器2视图子容器
    [container2 addSubview:subContainer21];
    [container2 addSubview:subContainer22];
    
    // 容器2视图子容器21配置
    subContainer21.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10);
    subContainer21.whc_Orientation = Vertical;// 自动垂直布局;
    subContainer21.whc_Space = 10;
    
    UIView * sublable211 = [UIView new];
    UIView * sublable212 = [UIView new];
    UIView * sublable213 = [UIView new];
    UIView * sublable214 = [UIView new];
    
    sublable211.backgroundColor = [UIColor grayColor];
    sublable212.backgroundColor = [UIColor grayColor];
    sublable213.backgroundColor = [UIColor grayColor];
    sublable214.backgroundColor = [UIColor grayColor];
    
    // 子元素高度占比权重
    sublable211.whc_HeightWeight = 2;
    sublable212.whc_HeightWeight = 3;
    
    // 添加子元素到容器视图
    [subContainer21 addSubview:sublable211];
    [subContainer21 addSubview:sublable212];
    [subContainer21 addSubview:sublable213];
    [subContainer21 addSubview:sublable214];
    
    // 容器2视图子容器22配置
    subContainer22.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10);
    subContainer22.whc_Orientation = Vertical;// 自动垂直布局;
    subContainer22.whc_Space = 10;
    
    UIView * sublable221 = [UIView new];
    UIView * sublable222 = [UIView new];
    UIView * sublable223 = [UIView new];
    UIView * sublable224 = [UIView new];
    
    sublable221.backgroundColor = [UIColor grayColor];
    sublable222.backgroundColor = [UIColor grayColor];
    sublable223.backgroundColor = [UIColor grayColor];
    sublable224.backgroundColor = [UIColor grayColor];
    
    [subContainer22 addSubview:sublable221];
    [subContainer22 addSubview:sublable222];
    [subContainer22 addSubview:sublable223];
    [subContainer22 addSubview:sublable224];
    
    // 开始对容器进行自动布局
    [container1 whc_StartLayout];
    [container2 whc_StartLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
