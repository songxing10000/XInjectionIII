//
//  UIView+XSRefresh.h
//  XInjectionIII
//
//  Created by dfpo on 03/03/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XSRefresh)
-(void)addRealTimeRefreshByAction:(nullable SEL)action;
-(void)addRealTimeRefreshByAction:(nullable SEL)action controlsNotRemoved:(nullable NSArray<UIView *> *)controlsNotRemoved;

- (void)xRemoveAllSubviews;
@end

NS_ASSUME_NONNULL_END
