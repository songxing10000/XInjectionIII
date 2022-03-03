//
//  UIViewController+XSRefresh.m
//  FastUI
//
//  Created by dfpo on 2021/4/8.
//

#import "UIViewController+XSRefresh.h"
  


@implementation UIViewController (XSRefresh)
 
-(void)addRealTimeRefresh {
#if TARGET_IPHONE_SIMULATOR
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injectionNotification:) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
#endif
}
#if TARGET_IPHONE_SIMULATOR
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
