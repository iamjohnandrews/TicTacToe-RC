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

@end

@implementation TTTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tttCollectionViewBoard.backgroundColor = [UIColor redColor];
}

#pragma mark DataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.tttCollectionViewBoard registerClass:[TTTCollectionViewCell class]
                    forCellWithReuseIdentifier:@"tttcell"];

    TTTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tttcell" forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    return CGSizeMake(100, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 20, 10, 20);
}


#pragma mark - Delegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Game Logic Methods




@end
