//
//  SXViewController.m
//  XInjectionIII
//
//  Created by songxing10000 on 03/03/2022.
//  Copyright (c) 2022 songxing10000. All rights reserved.
//

#import "SXViewController.h"
#import <XInjectionIII/UIViewController+XSRefresh.h>

@interface SXViewController ()

@end

@implementation SXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    [self addRealTimeRefresh];
    self.title = @"新建收货地址";
}
 
@end
