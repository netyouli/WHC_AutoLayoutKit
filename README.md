# WHC_AutoLayoutKit

##### 咨询QQ: 712641411
##### 开发作者: 吴海超

##### WHC_AutoLayoutKit 致力打造使用最简单功能最强大的自动布局开源库
##### WHC_AutoLayoutKit 借鉴android的相对布局和线性布局
##### pod集成： pod 'WHC_AutoLayoutKit', '~> 2.1.0'

## VERSION ~ 2.2.0 (最低能支持iOS6)添加如下功能:
##### 1.一行代码对xib或者storyboard上的所有UI控件智能识别约束关系，并自动添加好相应约束条件
##### 2.masonary拥有的功能WHC_AutoLayoutKit都有,同时包含一行代码计算Cell高度使用比masonary更方便快捷
##### 3.拥有UIStackView(WHC_StackView)功能使用更简单直接
##### 4.新增api 2.0 兼容masonary用户使用习惯一行代码进行布局
##### 5.一行代码对视图进行约束适配
##### view.whc_LeftSpace(10).whc_TopSpace(10).whc_RightSpaceToView(10,view1).whc_Height(100);
##### 6.更新左边间隙10改为20
##### view.whc_LeftSpace(20);
### 1.WHC_AutoLayoutKit实战高仿滚动流畅微信朋友圈列表demo8

![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/f.gif)

### 2.一行代码约束四个方向使用例子
```objective-c
/// 自动拉伸宽度与父视图右边间隙为10px, 高度为30px
_whcView.whc_LeftSpace(10).whc_TopSpace(0).whc_RightSpace(10).whc_Bottom(30);
/// 自动拉伸高度与父视图底部间隙为10px 宽度为100px
_whcView.whc_LeftSpace(10).whc_TopSpace(0).whc_RightSpace(100).whc_Bottom(10);
/// 自动拉伸宽度和高度与父视图右边底部间隙分别为10px
_whcView.whc_LeftSpace(10).whc_TopSpace(0).whc_RightSpace(10).whc_Bottom(10);
/// 普通对视图添加约束方式
view1.whc_LeftSpace(10).whc_TopSpace(10).whc_WidthEqualView(view2).whc_Height(150);

// 修改约束
view1.whc_LeftSpace(20);
```
### 3.一行代码计算UITableViewCell高度例子

```objective-c
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /// 仅需调用该方法即可自动计算cell高度
    return [DemoVC2Cell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}

```
![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/a.gif)

### 4.WHC_StackView容器视图自动横向布局例子(可设置子视图宽度拉伸权重比)
```objective-c
// 创建容器视图
stackView = [WHC_StackView new];
// 对容器视图1进行约束布局
stackView.whc_LeftSpace(0).whc_TopSpace(64).whc_RightSpace(0).whc_Height(150);
// 对容器视图1配置
// 容器子视图上下左右间隙
stackView.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10);
// 自动横向布局设置
stackView.whc_Orientation = Horizontal;
// 容器子视图之间间隙
stackView.whc_Space = 10; 
// 开始对容器进行自动布局

// 添加子元素视图
[stackView addSubview:lable1];
[stackView addSubview:lable2];
[stackView addSubview:lable3];
[stackView addSubview:lable4];

// 设置容器子视图宽度拉伸权重
label1.whc_WidthWeight = 2

// 容器开始布局
[stackView whc_StartLayout];
```
![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/c.gif)

### 5.WHC_StackView容器视图自动垂直布局例子(可设置子视图高度拉伸权重比) 与横向自动布局容器一样只是方向参数为Vertical
###   WHC_StackView容器视图自动横向垂直混合布局例子(可设置子视图宽高拉伸权重比)
```objective-c
// 创建容器视图
stackView = [WHC_StackView new];
// 对容器视图1进行约束布局
stackView.whc_LeftSpace(0).whc_TopSpace(64).whc_RightSpace(0).whc_Height(150);
// 对容器视图1配置
// 容器子视图上下左右间隙
stackView.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10);
// 自动横向垂直混合布局设置
stackView.whc_Orientation = All;
// 容器子视图之间间隙
stackView.whc_Space = 10; 
// 开始对容器进行自动布局

// 添加子元素视图
[stackView addSubview:lable1];
[stackView addSubview:lable2];
[stackView addSubview:lable3];
[stackView addSubview:lable4];
[stackView addSubview:lable5];

// 设置容器子视图宽度拉伸权重
label1.whc_WidthWeight = 2;
label2.whc_HeightWeight = 2;

// 容器开始布局
[stackView whc_StartLayout];
```
![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/b.gif)
