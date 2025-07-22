//
//  UIView+XSRefresh.m
//  XInjectionIII
//
//  Created by dfpo on 03/03/2022.
//
#import <TargetConditionals.h>  // 包含TARGET_IPHONE_SIMULATOR定义
#import "UIView+XSRefresh.h"
#import <objc/runtime.h>
@implementation UIView (XSRefresh)
- (UIViewController *)xViewController {
#if TARGET_IPHONE_SIMULATOR
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
#endif
}
- (void)xRemoveAllSubviews {
#if TARGET_IPHONE_SIMULATOR
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[CALayer class]] ||
            [subview isKindOfClass:[UITabBar class]] ||
            [subview isKindOfClass:[UINavigationBar class]] ||
            [subview isKindOfClass:[UINavigationController class]] ||
            [subview isKindOfClass:NSClassFromString(@"UITransitionView")] ||
            [subview isKindOfClass:NSClassFromString(@"UINavigationTransitionView")] ||
            [NSStringFromClass([subview class]) hasPrefix:@"_"] ||
            [subview isKindOfClass:NSClassFromString(@"UILayoutContainerView")] ||
            [subview isKindOfClass:NSClassFromString(@"TUIPredictionViewStackView")]){
            // 跳过
        }
        else {
            
            [subview xRemoveAllSubviews];
            [subview removeFromSuperview];
        }
    }
#endif
}
#if TARGET_IPHONE_SIMULATOR
+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInitWithFrame];
    });
}
//
+ (void)swizzleInitWithFrame {
    Class class = [UIView class];
    
    SEL originalSelector = @selector(initWithFrame:);
    SEL swizzledSelector = @selector(xs_initWithFrame:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // 检查方法是否存在
    if (!originalMethod || !swizzledMethod) {
        NSLog(@"[XSRefresh] Method swizzling failed: initWithFrame method not found");
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

- (instancetype)xs_initWithFrame:(CGRect)frame {
    // 调用原始的initWithFrame方法
    UIView *view = [self xs_initWithFrame:frame];
    
    if (view) {
        // 在这里可以添加初始化后的处理逻辑
        [view setupInjectionObserver];
    }
    
    return view;
}

- (void)setupInjectionObserver {
    // 检查是否已经设置过观察者，避免重复设置
    NSNumber *hasObserver = objc_getAssociatedObject(self, @selector(setupInjectionObserver));
    if (![hasObserver boolValue]) {
        
        // 标记已设置观察者
        objc_setAssociatedObject(self, @selector(setupInjectionObserver), @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        // 这里可以添加需要在view初始化后执行的逻辑
        // 比如自动添加injection监听等
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injectionNotification:) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    }
}
- (void)injectionNotification:(NSNotification *)notification {
    if ([NSStringFromClass([self class]) hasPrefix:@"_"] ||
        [self isKindOfClass:[UITabBar class]] ||
        [self isKindOfClass:[UILabel class]] ||
        [self isKindOfClass:[UINavigationBar class]] ||
        [self isKindOfClass:[UIWindow class]] ||
        [self isKindOfClass:[UIImage class]] ||
        [self isKindOfClass:[UIImageView class]] ||
        [self isKindOfClass:[UITableView class]] ||
        [self isMemberOfClass:[UIView class]] ||
        [self isKindOfClass:[UIActivityIndicatorView class]] ||

        
        
        [self isKindOfClass:[UIVisualEffectView class]] ||
        [self isKindOfClass:[UISearchBar class]] ||
        
 
 
        [self isKindOfClass: NSClassFromString(@"UISearchBarTextField")] ||

         [self isKindOfClass: NSClassFromString(@"UISearchBarBackground")] ||

        [self isKindOfClass: NSClassFromString(@"UITableViewCellContentView")] ||

        [self isKindOfClass: NSClassFromString(@"UITableViewCellContentView")] ||

        [self isKindOfClass: NSClassFromString(@"UITabBarSwappableImageView")] ||
 
        [self isKindOfClass: NSClassFromString(@"UITabBarButton")] ||
        [self isKindOfClass: NSClassFromString(@"UIDropShadowView")] ||
        [self isKindOfClass: NSClassFromString(@"UIDimmingView")] ||

 
         [self isKindOfClass: NSClassFromString(@"UILayoutContainerView")] ||
 
 
        [self isKindOfClass: NSClassFromString(@"UIDynamicSystemColor")] ||
        [self isKindOfClass:NSClassFromString(@"UITransitionView")] ||
        
        [self isKindOfClass:NSClassFromString(@"UIViewControllerWrapperView")] ||
        [self isKindOfClass: NSClassFromString(@"UINavigationTransitionView")]
        ) {
        
        return;
    }
    NSLog(@"self 是 %@", NSStringFromClass([self class]));
    NSArray *array = notification.object;
    for (id obj in array) {
         // TODO:这里是不是应该用 obj xViewController
        UIViewController *vc = [self xViewController];
        if (vc) {
            // 移除原来的view
            [vc.view xRemoveAllSubviews];
            [vc loadView];
            [vc viewDidLoad];
            [vc viewWillLayoutSubviews];
            [vc viewWillAppear:NO];
        }
        
    }
}
 
#endif
@end
 
