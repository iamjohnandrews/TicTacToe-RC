//
//  TTTViewController.m
//  TicTacToe
//
//  Created by John Andrews on 8/25/15.
//  Copyright (c) 2015 John Andrews. All rights reserved.
//

#import "TTTViewController.h"
#import "Player.h"
#import "TTTCollectionViewCell.h"

@interface TTTViewController ()
@property (nonatomic) BOOL isFirstPlayersTurn;
@property (nonatomic, strong) NSDictionary *gameBoardPlacesDict;
@end

@implementation TTTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirstPlayersTurn = YES;
    self.gameBoardPlacesDict = [NSDictionary dictionary];
}

#pragma mark DataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    TTTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tttcell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    return CGSizeMake(90, 90);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 20, 10, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TTTCollectionViewCell *selectedCell = (TTTCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (self.isFirstPlayersTurn) {
        selectedCell.markerLabel.text = @"X";
        selectedCell.tag = 1;
        self.isFirstPlayersTurn = NO;
    } else {
        selectedCell.markerLabel.text = @"O";
        selectedCell.tag = 2;
        self.isFirstPlayersTurn = YES;
    }
}

#pragma mark - Game Logic Methods

- (BOOL)isThereThreeAcrossForPlayer:(NSString *)player withPosition:(NSInteger)cell {
    BOOL isThereAWinner = NO;
    
    
    return isThereAWinner;
}


- (IBAction)resetGame:(UIButton *)sender {
    [self.tttCollectionViewBoard reloadData];
    self.gameBoardPlacesDict = [NSDictionary dictionary];
}
@end
