//
//  XSTableViewCell.m
//  XInjectionIII_Example
//
//  Created by dfpo on 03/03/2022.
//  Copyright © 2022 songxing10000. All rights reserved.
//

#import "XSTableViewCell.h"


@implementation XSTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}
- (void)configUI {
    // 这里开始布局
    self.contentView.backgroundColor = [UIColor blueColor];
}
@end
