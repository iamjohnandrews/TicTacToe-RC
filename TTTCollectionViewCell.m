//
//  TTTCollectionViewCell.m
//  TicTacToe
//
//  Created by John Andrews on 8/25/15.
//  Copyright (c) 2015 John Andrews. All rights reserved.
//

#import "TTTCollectionViewCell.h"

@implementation TTTCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *background = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView = background;
        self.backgroundView.backgroundColor = [UIColor yellowColor];
        
        UIView *selectedBackground = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView = selectedBackground;
        self.selectedBackgroundView.backgroundColor = [UIColor blueColor];
        self.contentView.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setMarkerLabel:(UILabel *)markerLabel {
    
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self setNeedsDisplay];
}

- (void)setUpUI {
    self.userInteractionEnabled = YES;
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    self.layer.borderWidth = 2;
    self.markerLabel.text = @"ass";
    self.markerLabel.textColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *cellTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    cellTapRecognizer.delegate = self;
    cellTapRecognizer.numberOfTapsRequired = 1;
    [self.contentView addGestureRecognizer:cellTapRecognizer];
}

- (void)cellTapped:(UIGestureRecognizer *)tapRecognizer {
    NSLog(@"POST cell tapped self.highlighted =%d, self.selected =%d", self.highlighted, self.selected);
}

@end
