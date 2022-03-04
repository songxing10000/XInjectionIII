 

安装
```ruby
pod 'XInjectionIII', :git => 'https://github.com/songxing10000/XInjectionIII'
 ```

 vc使用

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
cell使用
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
view使用
```objc
#import "XSTestView.h"
#import <XInjectionIII/XInjectionIII.h>

@implementation XSTestView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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