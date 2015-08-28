//
//  TTTCollectionViewCell.m
//  TicTacToe
//
//  Created by John Andrews on 8/25/15.
//  Copyright (c) 2015 John Andrews. All rights reserved.
//

#import "TTTCollectionViewCell.h"

@implementation TTTCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUpBoardForPlay];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        self.userInteractionEnabled = NO;
    }
}

- (void)prepareForReuse {
    self.userInteractionEnabled = YES;
    [self setUpBoardForPlay];
}

- (void)setUpBoardForPlay {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.markerLabel.text = nil;
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    self.layer.borderWidth = 2;
}

@end
