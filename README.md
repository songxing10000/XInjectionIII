原始工具：https://github.com/johnno1962/InjectionIII

美柚大佬的文章：https://juejin.cn/post/6850037272415813645 


---
### 效果
![](testdemo.gif)
---
### 安装
```ruby
pod 'XInjectionIII', :git => 'https://github.com/songxing10000/XInjectionIII'
 ```
---
### 前提
启动`InjectionIII`,打开项目所在文件夹。

---
### OC使用：
 
页面
 ```objc
 #import "SXViewController.h"
#import <XInjectionIII/XInjectionIII.h>

@interface SXViewController ()

@end

@implementation SXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    [self addRealTimeRefresh];
    // 这里变化测试
    self.title = @"新建fd址";
}
 
@end
```
cell 
```objc
#import "XSTableViewCell.h"
#import <XInjectionIII/XInjectionIII.h>

@implementation XSTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addRealTimeRefreshByAction:@selector(configUI)];
        [self configUI];
    }
    return self;
}
- (void)configUI {
    // 这里开始布局
}
@end
```
view 
```objc
#import "XSTestView.h"
#import <XInjectionIII/XInjectionIII.h>

@implementation XSTestView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addRealTimeRefreshByAction:@selector(configUI) controlsNotRemoved:@[self.containerView]];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    // 这里开始布局
}

@end
```
修改代码后，可设置自动刷新或者按`command`加`s`手动保存刷新

---
### Swift也一样的
```swift
// vc文件中
import UIKit
import XInjectionIII
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRealTimeRefresh()
        title = "?ffff?000dsf"
        
        view.addSubview(XTestView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        view.addSubview(XTestCell(frame: CGRect(x: 200, y: 200, width: 100, height: 100)))
    }
}
/// 在XTestView.swift文件中
class XTestView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addRealTimeRefresh(byAction: #selector(configUI))
    }
    @objc func configUI() {
        backgroundColor = .yellow
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/// XTestCell.swift文件中
class XTestCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    
        addRealTimeRefresh(byAction: #selector(configUI))
    }
    @objc func configUI() {
        contentView.backgroundColor = .blue
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```


---
### 本地`pod`库
需要调整下位置，保证`xcworkspace`所在文件夹，有源码文件夹。
