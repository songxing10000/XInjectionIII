//
//  InjectionIIIHelper.m
//  qwzw
//
//  Created by dfpo on 2020/12/14.
//

#ifdef TARGET_IPHONE_SIMULATOR

#import "InjectionIIIHelper.h"
#import <objc/runtime.h>
#import <UIKit/UIApplication.h>

@implementation InjectionIIIHelper

+ (void)load {
    //注册项目启动监听
    __block id observer =
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        //更改bundlePath
        [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
        
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
        observer = nil;
    }];
}
@end

#endif
