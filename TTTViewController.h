//
//  TTTViewController.h
//  TicTacToe
//
//  Created by John Andrews on 8/25/15.
//  Copyright (c) 2015 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTTViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *tttCollectionViewBoard;
@property (weak, nonatomic) IBOutlet UILabel *playerTurnLabel;

@property (weak, nonatomic) IBOutlet UILabel *playerOneScore;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoScore;

- (IBAction)resetGame:(UIButton *)sender;

@end

