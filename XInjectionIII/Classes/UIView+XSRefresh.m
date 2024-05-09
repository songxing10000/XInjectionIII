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
#if TARGET_IPHONE_SIMULATOR
    [self addRealTimeRefreshByAction:action controlsNotRemoved:nil];
#endif
}
-(void)addRealTimeRefreshByAction:(nullable SEL)action controlsNotRemoved:(nullable NSArray<UIView *> *)controlsNotRemoved {
#if TARGET_IPHONE_SIMULATOR
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injectionNotification:) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    self.action = action;
    if (controlsNotRemoved.count > 0) {
        xs_controlsNotRemoved = controlsNotRemoved;
    }
#endif
}
- (void)xRemoveAllSubviews {
    for (UIView *subview in self.subviews) {
        [subview xRemoveAllSubviews];
        [subview removeFromSuperview];
    }
}
#if TARGET_IPHONE_SIMULATOR
- (void)setAction:(SEL)action {
    objc_setAssociatedObject(self, "k_ref_action", NSStringFromSelector(action), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (SEL)action {
    return NSSelectorFromString(objc_getAssociatedObject(self, "k_ref_action"));
}
/// 刷新时不从父控件上移除的控件
static NSArray<UIView *> *xs_controlsNotRemoved = nil;

- (void)injectionNotification:(NSNotification *)notification {
    
    NSArray *array = notification.object;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
                    if(![xs_controlsNotRemoved containsObject:obj]) {
                        [obj removeFromSuperview];
                    } else {
                        [obj.subviews  enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [obj removeFromSuperview];
                        }];
                    }
                }];
            }
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector: self.action];
#pragma clang diagnostic pop
            
             
        }
    }];
}
#endif

@end

/*
 将SEL转换为NSString
 - (void)setAction:(SEL)action {
     objc_setAssociatedObject(self, "k_ref_action", NSStringFromSelector(action), OBJC_ASSOCIATION_COPY_NONATOMIC);
 }
 - (SEL)action {
     return NSSelectorFromString(objc_getAssociatedObject(self, "k_ref_action"));
 }

 将SEL转换为NSValue

 - (void)setAction:(SEL)action {
     NSValue *selValue = [NSValue valueWithBytes:&action objCType:@encode(SEL)];
     objc_setAssociatedObject(self, "k_ref_action", selValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 }
 - (SEL)action {
     NSValue *av = objc_getAssociatedObject(self, "k_ref_action");
     SEL as;
     [av getValue:&as];
     return as;
 }
 
 */
