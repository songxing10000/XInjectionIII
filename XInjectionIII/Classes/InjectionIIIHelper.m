//
//  InjectionIIIHelper.m
//  qwzw
//
//  Created by dfpo on 2020/12/14.
//

#import "InjectionIIIHelper.h"
#import <objc/runtime.h>
#import <UIKit/UIApplication.h>

#ifdef TARGET_IPHONE_SIMULATOR

BOOL method_swizzle(Class klass, SEL origSel, SEL altSel)
{
    if (!klass) {
        return NO;
    }
    Method __block origMethod, __block altMethod;
    
    void (^find_methods)(void) = ^{
        unsigned methodCount = 0;
        Method *methodList = class_copyMethodList(klass, &methodCount);
        
        origMethod = altMethod = NULL;
        
        if (methodList) {
            for (unsigned i = 0; i < methodCount; ++i)
            {
                if (method_getName(methodList[i]) == origSel) {
                    origMethod = methodList[i];
                }
                if (method_getName(methodList[i]) == altSel) {
                    altMethod = methodList[i];
                }
            }
        }
        free(methodList);
    };
    
    find_methods();
    
    if (!origMethod)
    {
        origMethod = class_getInstanceMethod(klass, origSel);
        
        if (!origMethod) {
            return NO;
        }
        if (!class_addMethod(klass, method_getName(origMethod), method_getImplementation(origMethod), method_getTypeEncoding(origMethod))) {
            return NO;
        }
    }
    
    if (!altMethod)
    {
        altMethod = class_getInstanceMethod(klass, altSel);
        
        if (!altMethod) {
            return NO;
        }
        if (!class_addMethod(klass, method_getName(altMethod), method_getImplementation(altMethod), method_getTypeEncoding(altMethod))) {
            return NO;
        }
    }
    
    find_methods();
    
    if (!origMethod || !altMethod) {
        return NO;
    }
    method_exchangeImplementations(origMethod, altMethod);
    
    return YES;
}

@implementation NSObject (OKRuntime)
+ (BOOL)ok_swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod {
    return method_swizzle(self.class, originalMethod, newMethod);
}

@end



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
#pragma mark - 防止实时刷新有时字典 nil key崩溃
@implementation NSMutableDictionary (OKSafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class ok_swizzleMethod:@selector(setObject:forKey:)
                     withMethod:@selector(ok_setObject:forKey:)];
        [class ok_swizzleMethod:@selector(setObject:forKeyedSubscript:)
                     withMethod:@selector(ok_setObject:forKeyedSubscript:)];
    });
}

- (void)ok_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey || !anObject) {
        return;
    }
    [self ok_setObject:anObject forKey:aKey];
}

- (void)ok_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key || !obj) {
        return;
    }
    [self ok_setObject:obj forKeyedSubscript:key];
}
@end
#endif
