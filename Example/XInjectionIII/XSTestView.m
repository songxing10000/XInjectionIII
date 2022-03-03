//
//  XSTestView.m
//  XInjectionIII_Example
//
//  Created by dfpo on 03/03/2022.
//  Copyright © 2022 songxing10000. All rights reserved.
//

#import "XSTestView.h"
#import <XInjectionIII/UIView+XSRefresh.h>

@implementation XSTestView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addRealTimeRefreshByAction:@selector(configUI)];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    // 这里开始布局
}

@end
