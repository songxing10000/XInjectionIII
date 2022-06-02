//
//  UIView+XSRefresh.m
//  XInjectionIII
//
//  Created by dfpo on 03/03/2022.
//

#import "UIView+XSRefresh.h"
#import <objc/runtime.h>
@implementation UIView (XSRefresh)
-(void)addRealTimeRefreshByAction:(nullable SEL)action {
    [self addRealTimeRefreshByAction:action controlsNotRemoved:nil];
}
-(void)addRealTimeRefreshByAction:(nullable SEL)action controlsNotRemoved:(nullable NSArray<UIView *> *)controlsNotRemoved {

#if TARGET_IPHONE_SIMULATOR
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injectionNotification:) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    [self class].action = action;
    if (controlsNotRemoved.count > 0) {
        self.controlsNotRemoved = controlsNotRemoved;
    }
#endif
    
}

#if TARGET_IPHONE_SIMULATOR
static SEL _action = nil;
+ (void)setAction:(SEL)action {
  if (_action != action) {
      _action = action;
  }
}
+(SEL)action {
    return _action;
}
//@property(nonatomic, strong) NSArray<UIView *>  *controlsNotRemoved;
- (void)setControlsNotRemoved:(NSArray<UIView *> *)controlsNotRemoved {
    objc_setAssociatedObject(self, @selector(controlsNotRemoved), controlsNotRemoved, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray<UIView *> *)controlsNotRemoved {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)injectionNotification:(NSNotification *)notification {
    
    NSArray *array = notification.object;
    
    for (id obj in array) {
        
        if ([self isKindOfClass:obj]) {
            
            if ([self isKindOfClass:[UITableViewCell class]]) {
                
                UITableViewCell *cell = (UITableViewCell *)self;
                
                [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj removeFromSuperview];
                }];
                
            }
            
            else if ([self isKindOfClass:[UICollectionViewCell class]]) {
                
                UICollectionViewCell *cell = (UICollectionViewCell *)self;
                
                [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj removeFromSuperview];
                }];
            }
            else if ([self isKindOfClass:[UITableViewHeaderFooterView class]]) {
                
                UITableViewHeaderFooterView *hfv = (UITableViewHeaderFooterView *)self;
                
                [hfv.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj removeFromSuperview];
                }];
            }
            
            
            else {
                [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if(![self.controlsNotRemoved containsObject:obj]) {
                        [obj removeFromSuperview];
                    } else {
                        [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [obj removeFromSuperview];
                        }];
                    }
                }];
                
            }
            [self performSelector:[self class].action];
            
        }
        
    }
    
}
#endif
 
@end

