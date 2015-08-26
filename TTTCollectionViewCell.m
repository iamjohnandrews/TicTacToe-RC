//
//  TTTCollectionViewCell.m
//  TicTacToe
//
//  Created by John Andrews on 8/25/15.
//  Copyright (c) 2015 John Andrews. All rights reserved.
//

#import "TTTCollectionViewCell.h"

@implementation TTTCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];// how do I call method in init?
        NSLog(@"wtf");
    }
    return self;
}

- (void)setUpUI {
    self.userInteractionEnabled = YES;
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    self.layer.borderWidth = 2;
    self.markerLabel.text = @"ass";
}
@end
