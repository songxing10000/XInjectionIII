//
//  SXViewController.m
//  XInjectionIII
//
//  Created by songxing10000 on 03/03/2022.
//  Copyright (c) 2022 songxing10000. All rights reserved.
//

#import "SXViewController.h"
#import <XInjectionIII/XInjectionIII.h>
#import "XSTableViewCell.h"
#import "XSTestView.h"

@interface SXViewController ()

@end

@implementation SXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    [self addRealTimeRefresh];
    self.title = @"地2址";
    
    
    [self.view addSubview: [[XSTestView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)]];
    [self.view addSubview: [[XSTableViewCell new]initWithFrame:CGRectMake(100, 900, 100, 100)]];
}
 
@end
