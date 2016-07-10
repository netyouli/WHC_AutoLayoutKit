# WHC_AutoLayoutKit

##### 咨询QQ: 712641411
##### 开发作者: 吴海超
##### WHC_AutoLayoutKit 致力打造使用最简单功能最强大的自动布局开源库
##### WHC_AutoLayoutKit 同时有OC版和Swift版
##### OC版和Swift版自动布局库api接口使用代码里都有详细使用说明

#### ObjectiveC版自动布局库使用范例
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view = [UIView new];
    [self.view addSubview: view];

    view.whc_LeftSpace(10)
        .whc_TopSpace(10)
        .whc_RightSpaceToView(10,view1)
        .whc_Height(100);
}
```

#### Swift版自动布局使用范例
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    let view = UIView()
    self.view.addSubview(view)

    view.whc_Left(20)
        .whc_Right(0)
        .whc_Height(40)
        .whc_Top(64)
}
```
#### ObjectiveC版一行代码计算cell高度使用范例
```objective-c
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [DemoVC2Cell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}
```

#### Swift版一行代码计算cell高度使用范例
```swift
func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewCell.whc_CellHeightForIndexPath(indexPath, tableView: tableView)
}
```

#### ObjectiveC版StackView使用范例
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    WHC_StackView * stackView = [WHC_StackView new];
    [self.view addSubview: stackView];

    /// 一行代码添加约束
    stackView.whc_LeftSpace(10)
             .whc_TopSpace(10)
             .whc_RightSpace(10)
             .whc_Height(100);

    /// 配置StackView
    stackView.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10); // 内边距
    stackView.whc_Orientation = Vertical;                  // 自动垂直布局
    stackView.whc_HSpace = 10;                             // 子视图横向间隙
    stackView.whc_VSpace = 10;                             // 子视图垂直间隙
    
    /// 向StackView中添加子视图
    UIView * view1 = [UIView new];
    UIView * view2 = [UIView new];
    UIView * view3 = [UIView new];
    UIView * view4 = [UIView new];

    [stackView addSubview:view1];
    [stackView addSubview:view2];
    [stackView addSubview:view3];
    [stackView addSubview:view4];

    /// 开始进行布局
    [stackView whc_StartLayout];
}


#### Swift版StackView使用范例

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    let stackView = WHC_StackView()
    self.view.addSubview(stackView)

    /// 一行代码添加约束
    stackView.whc_Left(10)
             .whc_Top(10)
             .whc_Right(10)
             .whc_Height(100)

    /// 配置StackView
    stackView.whc_Edge = UIEdgeInsetsMake(10, 10, 10, 10)  // 内边距
    stackView.whc_Orientation = .Horizontal                // 自动横向布局
    stackView.whc_Column = 4                               // 一行4列
    stackView.whc_HSpace = 10                              // 子视图横向间隙
    stackView.whc_VSpace = 10                              // 子视图垂直间隙

    /// 向StackView中添加子视图
    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()
    let view4 = UIView()

    stackView.addSubview(view1)
    stackView.addSubview(view2)
    stackView.addSubview(view3)
    stackView.addSubview(view4)

    /// 开始进行布局
    stackView.whc_StartLayout()
}
```

#### 部分WHC_AutoLayoutKit demo展示
![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/f.gif)![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/a.gif)![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/swiftb.gif)![image](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/c.png)![image](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/d.png)

