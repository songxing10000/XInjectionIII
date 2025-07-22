//
//  SXViewController.m
//  XInjectionIII
//
//  Created by songxing10000 on 03/03/2022.
//  Copyright (c) 2022 songxing10000. All rights reserved.
//

#import "SXViewController.h"
#import "XSTableViewCell.h"
#import "XSTestView.h"

@interface SXViewController ()

@end

@implementation SXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	 
    self.title = @"地2址";
    
    
    UIView *testView = [XSTestView new];
    [self.view addSubview:testView];
    testView.frame = CGRectMake(100, 100, 100, 100);
    XSTableViewCell *cell = [[XSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ff"];
    [self.view addSubview: cell];
    cell.frame = CGRectMake(100, 500, 100, 100);
}
 
@end
