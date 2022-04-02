//
//  UIView+XSRefresh.m
//  XInjectionIII
//
//  Created by dfpo on 03/03/2022.
//

#import "UIView+XSRefresh.h"

@implementation UIView (XSRefresh)
-(void)addRealTimeRefreshByAction:(nullable SEL)action {
    [self addRealTimeRefreshByAction:action controlsNotRemoved:nil];
}
-(void)addRealTimeRefreshByAction:(nullable SEL)action controlsNotRemoved:(nullable NSArray<UIView *> *)controlsNotRemoved {

#if TARGET_IPHONE_SIMULATOR
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injectionNotification:) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    UIView.action = action;
    if (controlsNotRemoved.count > 0) {
        UIView.controlsNotRemoved = controlsNotRemoved;
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
/// 刷新时不从父控件上移除的控件
static NSArray<UIView *> *_controlsNotRemoved = nil;
+ (void)setControlsNotRemoved :(NSArray<UIView *> *)controlsNotRemoved {
  if (_controlsNotRemoved != controlsNotRemoved) {
      _controlsNotRemoved = controlsNotRemoved;
  }
}
- (void)injectionNotification:(NSNotification *)notification {
    
    NSArray *array = notification.object;
    
    for (id obj in array) {
        
        if ([self isKindOfClass:obj]) {
            
            if ([self isKindOfClass:[UITableViewCell class]]) {
                
                UITableViewCell *cell = (UITableViewCell *)self;
                
                [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
            }
            
            else if ([self isKindOfClass:[UICollectionViewCell class]]) {
                
                UICollectionViewCell *cell = (UICollectionViewCell *)self;
                
                [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
            }
            else if ([self isKindOfClass:[UITableViewHeaderFooterView class]]) {
                
                UITableViewHeaderFooterView *hfv = (UITableViewHeaderFooterView *)self;
                
                [hfv.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
            }
            
            
            else {
                [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if(![_controlsNotRemoved containsObject:obj]) {
                        [obj removeFromSuperview];
                    }
                }];
//                [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
            }
            [self performSelector:_action];
            
        }
        
    }
    
}
#endif
 
@end
