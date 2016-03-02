# WHC_AutoLayoutKit

##### 联系QQ: 712641411
##### 开发作者: 吴海超
##### iOS技术交流群: 302157745

##### WHC_AutoLayoutKit VERSION ~ 2.0
##### WHC_AutoLayoutKit 致力打造使用最简单功能最强大的自动布局开源库
##### WHC_AutoLayoutKit 借鉴android的相对布局和线性布局

## VERSION ~ 2.0 添加如下功能:
##### 1.一行代码对xib或者storyboard上的所有UI控件智能识别约束关系，并自动添加好相应约束条件
##### 2.masonary拥有的功能WHC_AutoLayoutKit都有,同时包含一行代码计算Cell高度使用比masonary更方便快捷

### 1.一行代码对xib或者storyboard上的所有UI控件自动布局例子
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"一行代码对Xib上所有控件进行智能布局";
    /**
    * 智能识别xib上所有UI控件之间约束关系
    * 来自动给xib上所有控件进行自动添加相
    * 应约束关系
    */
    /// 对xib上所有控件横向和垂直进行智能布局
    [self.view whc_AutoXibLayout];
}

```
![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/d.gif)

### 2.一行代码对xib或者storyboard上的所有UI控件自动横向布局例子

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"一行代码智能对Xib上所有控件智能横向布局";
    /**
    * 智能识别xib上所有UI控件之间约束关系
    * 来自动给xib上所有控件进行自动添加相
    * 应约束关系
    */
    /// 对xib上所有控件横向和垂直进行智能布局
    [self.view whc_AutoXibHorizontalLayout];
}

```
![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/e.gif)

### 3.一行代码约束四个方向使用例子
```objective-c
/// 自动拉伸宽度与父视图右边间隙为10px, 高度为30px
[_whcView whc_FrameAutoWidth:WHCWidthAutoRectMake(10, 0, 10, 30)];

/// 自动拉伸高度与父视图底部间隙为10px 宽度为100px
[_whcView whc_FrameAutoHeight:WHCHeightAutoRectMake(10, 0, 100, 10)];

/// 自动拉伸宽度和高度与父视图右边底部间隙分别为10px
[_whcView whc_FrameAuto:WHCAutoRectMake(10, 0, 10, 10)];

/// 普通对视图添加约束方式
[view1 whc_LeftSpace:10];
[view1 whc_TopSpace:74];
[view1 whc_WidthEqualView:view2];
[view1 whc_Height:150];

[view2 whc_LeftSpace:10 relativeView:view1];
[view2 whc_TopSpace:74];
[view2 whc_RightSpace:10];
[view2 whc_HeightEqualView:view1];
```
### 4.一行代码计算UITableViewCell高度例子

```objective-c
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /// 仅需调用该方法即可自动计算cell高度
    return [DemoVC2Cell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}

```
![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/a.gif)

### 5.StockView容器视图自动横向布局例子(可设置子视图宽度拉伸权重比)
```objective-c
// 创建容器视图
container = [WHC_LayoutContainer new];
// 对容器视图1进行约束布局
[container whc_FrameAutoWidth:WHCWidthAutoRectMake(0, 64, 0, 150)];
// 对容器视图1配置
// 容器子视图上下左右间隙
container.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10);
// 自动横向布局设置
container.whc_Orientation = Horizontal;
// 容器子视图之间间隙
container.whc_Space = 10; 
// 开始对容器进行自动布局

// 添加子元素视图
[container addSubview:lable1];
[container addSubview:lable2];
[container addSubview:lable3];
[container addSubview:lable4];

// 设置容器子视图宽度拉伸权重
label1.whc_WidthWeight = 2

// 容器开始布局
[container whc_StartLayout];
```
![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/c.gif)

### 6.StockView容器视图自动垂直布局例子(可设置子视图高度拉伸权重比) 与横向自动布局容器一样只是方向参数为Vertical
###   StockView容器视图自动横向垂直混合布局例子(可设置子视图宽高拉伸权重比)
```objective-c
// 创建容器视图
container = [WHC_LayoutContainer new];
// 对容器视图1进行约束布局
[container whc_FrameAutoWidth:WHCWidthAutoRectMake(0, 64, 0, 150)];
// 对容器视图1配置
// 容器子视图上下左右间隙
container.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10);
// 自动横向垂直混合布局设置
container.whc_Orientation = All;
// 容器子视图之间间隙
container.whc_Space = 10; 
// 开始对容器进行自动布局

// 添加子元素视图
[container addSubview:lable1];
[container addSubview:lable2];
[container addSubview:lable3];
[container addSubview:lable4];
[container addSubview:lable5];

// 设置容器子视图宽度拉伸权重
label1.whc_WidthWeight = 2;
label2.whc_HeightWeight = 2;

// 容器开始布局
[container whc_StartLayout];
```
![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/b.gif)