//
//  UIViewController+XSRefresh.m
//  FastUI
//
//  Created by dfpo on 2021/4/8.
//

#import "UIViewController+XSRefresh.h"
#import <TargetConditionals.h>  // 包含TARGET_IPHONE_SIMULATOR定义
#import "UIView+XSRefresh.h"
#import <objc/runtime.h>


@implementation UIViewController (XSRefresh)
-(void)addRealTimeRefresh {
#if TARGET_IPHONE_SIMULATOR
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injectionNotification:) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
#endif
} 
#if TARGET_IPHONE_SIMULATOR
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleViewDidLoad];
    });
}


+ (void)swizzleViewDidLoad {
    Class class = [UIViewController class];
    
    SEL originalSelector = @selector(viewDidLoad);
    SEL swizzledSelector = @selector(xs_viewDidLoad);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // 检查方法是否存在
    if (!originalMethod || !swizzledMethod) {
        NSLog(@"[XSRefresh] Method swizzling failed: method not found");
        return;
    }
    
    // 尝试添加方法，如果已存在则返回NO
    BOOL didAddMethod = class_addMethod(class,
                                       originalSelector,
                                       method_getImplementation(swizzledMethod),
                                       method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        // 成功添加了方法，替换swizzled方法的实现
        class_replaceMethod(class,
                           swizzledSelector,
                           method_getImplementation(originalMethod),
                           method_getTypeEncoding(originalMethod));
    } else {
        // 方法已存在，直接交换实现
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)xs_viewDidLoad {
    // 调用原始的viewDidLoad方法
    [self xs_viewDidLoad];
  
    // 执行注入相关的逻辑
    [self handleInjectionRefresh];
}
- (void)handleInjectionRefresh {
    // 检查是否已经添加过观察者，避免重复添加
    if (!objc_getAssociatedObject(self, @selector(handleInjectionRefresh))) {
        // 移除原来的view
        [self.view xRemoveAllSubviews];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                  selector:@selector(injectionNotification:)
                                                      name:@"INJECTION_BUNDLE_NOTIFICATION"
                                                    object:nil];
        
        // 标记已添加观察者
        objc_setAssociatedObject(self, @selector(handleInjectionRefresh), @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (void)injectionNotification:(NSNotification *)notification {
    NSArray *array = notification.object;
    for (id obj in array) {
        if ([self isKindOfClass:obj]) {
            [self loadView];
            [self viewDidLoad];
            [self viewWillLayoutSubviews];
            [self viewWillAppear:NO];
        }
    }
}
#endif

@end
