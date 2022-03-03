//
//  UIView+XSRefresh.m
//  XInjectionIII
//
//  Created by dfpo on 03/03/2022.
//

#import "UIView+XSRefresh.h"

@implementation UIView (XSRefresh)
static SEL _action = nil;
+ (void)setAction:(SEL)action {
  if (_action != action) {
      _action = action;
  }
}
-(void)addRealTimeRefreshByAction:(nullable SEL)action {

#if TARGET_IPHONE_SIMULATOR
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injectionNotification:) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    UIView.action = action;
#endif
    
}

#if TARGET_IPHONE_SIMULATOR

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
            
            else {
                
                [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
            }
            [self performSelector:_action];
            
        }
        
    }
    
}
#endif
 
@end
