//
//  UIView+XSRefresh.h
//  XInjectionIII
//
//  Created by dfpo on 03/03/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XSRefresh)
- (void)xRemoveAllSubviews;
- (UIViewController *)xViewController;
@end

NS_ASSUME_NONNULL_END
