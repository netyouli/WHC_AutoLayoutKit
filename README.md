# WHC_AutoLayoutKit
<div align=center><img src="https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/WHC_AutoLayoutLogo.png"/></div></br>
==============
![Build Status](https://api.travis-ci.org/netyouli/WHC_AutoLayoutKit.svg?branch=master)
[![Pod Version](http://img.shields.io/cocoapods/v/WHC_AutoLayoutKit.svg?style=flat)](http://cocoadocs.org/docsets/WHC_AutoLayoutKit/)
[![Pod Platform](http://img.shields.io/cocoapods/p/WHC_AutoLayoutKit.svg?style=flat)](http://cocoadocs.org/docsets/WHC_AutoLayoutKit/)
[![Pod License](http://img.shields.io/cocoapods/l/WHC_AutoLayoutKit.svg?style=flat)](https://opensource.org/licenses/MIT)
-  IOS platforms currently in use the fastest the simplest development to build the UI layout automatically open source library, strong dynamic layout constraint handling capacity
-  Service to update constraints, convenient and quick dynamic UI layout.
-  打造iOS平台极速开发构建动态UI的自动布局库,智能约束冲突识别机制，Api命名清晰易懂，支持Swift和OC。

[使用原理详解](https://gold.xitu.io/post/585e087f61ff4b005812eed7)</br>

简介
==============
-  布局Api采用链式调用(快捷方便)
-  提供【Objective-C】【Swift2.3】【Swift3.0】三种语言版本库
-  包含一行代码计算UITableViewCell高度模块
-  包含WHC_StackView模块(目的替代系统UIStackView)
-  自动识别冲突约束并更新新约束
-  支持修改约束优先级
-  支持删除约束
-  咨询QQ: 712641411
-  开发作者: 吴海超

要求
==============
* iOS 6.0 or later
* Xcode 8.0 or later

集成
==============
* 使用CocoaPods:
  -  【Objective-C】: pod 'WHC_AutoLayoutKit'
  -  【Swift3.0】: pod 'WHC_AutoLayoutKit_Swift3'
  -  【Swift2.3】: pod 'WHC_AutoLayoutKit_Swift2_3'
  
* 手工集成:
  -  【Objective-C】: 导入文件夹WHC_AutoLayoutKit(OC)
  -  【Swift3.0】: 导入文件夹WHC_AutoLayoutKit(Swift3.0)
  -  【Swift2.3】: 导入文件夹WHC_AutoLayoutKit(Swift2.3)

使用
==============
### Objective-C版
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view = [UIView new];
    [self.view addSubview: view];

    view.whc_LeftSpace(10)
        .whc_TopSpace(10)
        .whc_RightSpaceToView(10,view1)
        .whc_Height(100)
        .whc_PriorityLow() /// height低优先级
}
```

### Swift版
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    let view = UIView()
    self.view.addSubview(view)

    view.whc_Left(20)
        .whc_Right(0)
        .whc_Height(40)
        .whc_Top(64)
        .whc_PriorityLow() /// top低优先级
}
```
### ObjectiveC版一行代码计算cell高度
```objective-c
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}
```

### Swift版一行代码计算cell高度
```swift
func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewCell.whc_CellHeightForIndexPath(indexPath, tableView: tableView)
}
```

### ObjectiveC版WHC_StackView使用
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
    for (int i = 0; i < 4; i++) {
        UIView * view = [UIView new];
        [stackView addSubview:view];        
    }
    /// 开始进行布局
    [stackView whc_StartLayout];
}
```

### Swift版WHC_StackView使用范例

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
    stackView.whc_Orientation = .All                       // 自动横向垂直布局
    stackView.whc_HSpace = 10                              // 子视图横向间隙
    stackView.whc_VSpace = 10                              // 子视图垂直间隙

    /// 向StackView中添加子视图
    for _ in 0 ..< 4 {
        let view = UIView()    
        stackView.addSubview(view)        
    }
    /// 开始进行布局
    stackView.whc_StartLayout()
}
```

### 部分WHC_AutoLayoutKit demo展示

<img src = "https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/c.png" width = "375"><img src = "https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/g.png" width = "375">
![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/f.gif)![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/a.gif)![](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/swiftb.gif)![image](https://github.com/netyouli/WHC_AutoLayoutKit/blob/master/Gif/d.png)


## <a id="期待"></a>期待

- 如果您在使用过程中有任何问题，欢迎issue me! 很乐意为您解答任何相关问题!
- 与其给我点star，不如向我狠狠地抛来一个BUG！
- 如果您想要更多的接口来自定义或者建议/意见，欢迎issue me！我会全力满足大家！

## Licenses
All source code is licensed under the MIT License.

