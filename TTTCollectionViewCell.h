//
//  TTTCollectionViewCell.h
//  TicTacToe
//
//  Created by John Andrews on 8/25/15.
//  Copyright (c) 2015 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTTCollectionViewCell : UICollectionViewCell <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *markerLabel;

@end
