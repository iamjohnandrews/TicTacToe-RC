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
@property (nonatomic, strong) NSString *winner;
@property (nonatomic, strong) NSMutableArray *gameBoardPlacesX;
@property (nonatomic, strong) NSMutableArray *gameBoardPlacesO;
@end

@implementation TTTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNewGame];
}

- (void)startNewGame {
    self.isFirstPlayersTurn = YES;
    self.gameBoardPlacesO = [NSMutableArray array];
    self.gameBoardPlacesX = [NSMutableArray array];
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
    NSNumber *gameBoardPosition = [NSNumber numberWithInteger:indexPath.item];

    if (self.isFirstPlayersTurn) {
        selectedCell.markerLabel.text = @"X";
        self.isFirstPlayersTurn = NO;
        [self.gameBoardPlacesX addObject:gameBoardPosition];
    } else {
        selectedCell.markerLabel.text = @"O";
        self.isFirstPlayersTurn = YES;
        [self.gameBoardPlacesO addObject:gameBoardPosition];
    }

    [self isThereAWinner];
}

#pragma mark - Accessors

- (void)setWinner:(NSString *)winner {
    if (winner) {
        NSLog(@"player %@ WON", winner);
    }
    _winner = winner;
}

- (IBAction)resetGame:(UIButton *)sender {
    [self.tttCollectionViewBoard reloadData];
    [self startNewGame];
}

#pragma mark - Game Logic Methods

- (void)isThereAWinner {
    
    if ([self isThreeInRowDiagonal:self.gameBoardPlacesX]) {
        self.winner = @"X";
    } else if ([self isThreeInRowHorizontal:self.gameBoardPlacesX]) {
        self.winner = @"X";
    } else if ([self isThreeInRowVertical:self.gameBoardPlacesX]) {
        self.winner = @"X";
    }

    if ([self isThreeInRowDiagonal:self.gameBoardPlacesO]) {
        self.winner = @"O";
    } else if ([self isThreeInRowHorizontal:self.gameBoardPlacesO]) {
        self.winner = @"O";
    } else if ([self isThreeInRowVertical:self.gameBoardPlacesO]) {
        self.winner = @"O";
    }
}

-(BOOL)isThreeInRowHorizontal:(NSArray *)playerMoves {
    BOOL doHaveAWinner = YES;
    for (int move = 0; move < 3; move++) {
        if (![playerMoves containsObject:[NSNumber numberWithInt:move]]) {
            doHaveAWinner = NO;
        }
    }
    if (doHaveAWinner) {
        return doHaveAWinner;
    } else {
        doHaveAWinner = YES;
    }
    for (int move = 3; move < 6; move++) {
        if (![playerMoves containsObject:[NSNumber numberWithInt:move]]) {
            doHaveAWinner = NO;
        }
    }
    if (doHaveAWinner) {
        return doHaveAWinner;
    } else {
        doHaveAWinner = YES;
    }
    for (int move = 6; move < 9; move++) {
        if (![playerMoves containsObject:[NSNumber numberWithInt:move]]) {
            doHaveAWinner = NO;
        }
    }
    return doHaveAWinner;
}

-(BOOL)isThreeInRowDiagonal:(NSArray *)playerMoves {
    BOOL doHaveAWinner = YES;
    for (int move = 2; move < 7; move+=2) {
        if (![playerMoves containsObject:[NSNumber numberWithInt:move]]) {
            doHaveAWinner = NO;
        }
    }
    if (doHaveAWinner) {
        return doHaveAWinner;
    } else {
        doHaveAWinner = YES;
    }
    for (int move = 0; move < 9; move+=4) {
        if (![playerMoves containsObject:[NSNumber numberWithInt:move]]) {
            doHaveAWinner = NO;
        }
    }

    return doHaveAWinner;
}

-(BOOL)isThreeInRowVertical:(NSArray *)playerMoves {
    BOOL doHaveAWinner = YES;
    for (int move = 0; move < 7; move+=3) {
        if (![playerMoves containsObject:[NSNumber numberWithInt:move]]) {
            doHaveAWinner = NO;
        }
    }
    if (doHaveAWinner) {
        return doHaveAWinner;
    } else {
        doHaveAWinner = YES;
    }
    for (int move = 1; move < 8; move+=3) {
        if (![playerMoves containsObject:[NSNumber numberWithInt:move]]) {
            doHaveAWinner = NO;
        }
    }
    if (doHaveAWinner) {
        return doHaveAWinner;
    } else {
        doHaveAWinner = YES;
    }
    for (int move = 2; move < 9; move+=3) {
        if (![playerMoves containsObject:[NSNumber numberWithInt:move]]) {
            doHaveAWinner = NO;
        }
    }
    return doHaveAWinner;
}

@end
