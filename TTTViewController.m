//
//  TTTViewController.m
//  TicTacToe
//
//  Created by John Andrews on 8/25/15.
//  Copyright (c) 2015 John Andrews. All rights reserved.
//

#import "TTTViewController.h"
#import "TTTCollectionViewCell.h"

NSString * const playerOneScoreKey = @"playerOneVictoryCount";
NSString * const playerTwoScoreKey = @"playerTwoVictoryCount";

@interface TTTViewController () <UIAlertViewDelegate>
@property (nonatomic) BOOL isFirstPlayersTurn;
@property (nonatomic, strong) NSString *winner;
@property (nonatomic, strong) NSMutableArray *gameBoardPlacesX;
@property (nonatomic, strong) NSMutableArray *gameBoardPlacesO;
@property (nonatomic, strong) NSNumber *playerOneVictories;
@property (nonatomic, strong) NSNumber *playerTwoVictories;

@end

@implementation TTTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNewGame];
    [self getPlayersScores];
}

- (void)startNewGame {
    self.isFirstPlayersTurn = YES;
    self.gameBoardPlacesO = [NSMutableArray array];
    self.gameBoardPlacesX = [NSMutableArray array];
}

- (void)savePlayerScores {
    [[NSUserDefaults standardUserDefaults]setObject:self.playerOneVictories forKey:playerOneScoreKey];
    [[NSUserDefaults standardUserDefaults]setObject:self.playerTwoVictories forKey:playerTwoScoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)getPlayersScores {
    self.playerOneVictories = [[NSUserDefaults standardUserDefaults] objectForKey:playerOneScoreKey];
    self.playerTwoVictories = [[NSUserDefaults standardUserDefaults] objectForKey:playerTwoScoreKey];
    
    if (self.playerOneVictories) {
        self.playerOneScore.text = [NSString stringWithFormat:@"%@", self.playerOneVictories];
    } else {
        self.playerOneScore.text = @"0";
    }
    
    if (self.playerTwoVictories) {
        self.playerTwoScore.text = [NSString stringWithFormat:@"%@", self.playerTwoVictories];
    } else {
        self.playerTwoScore.text = @"0";
    }
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

- (void)setIsFirstPlayersTurn:(BOOL)isFirstPlayersTurn {

    if (isFirstPlayersTurn) {
        self.playerTurnLabel.text = @"Player 1 Turn";
    } else {
        self.playerTurnLabel.text = @"Player 2 Turn";
    }
    _isFirstPlayersTurn = isFirstPlayersTurn;
}

- (void)setWinner:(NSString *)winner {
    NSString *winningPlayer;
    if (winner) {
        if (self.isFirstPlayersTurn) {
            winningPlayer = @"Player 2";
            self.playerTwoVictories = [NSNumber numberWithInt:[self.playerTwoVictories intValue] + 1];
            self.playerTwoScore.text = [NSString stringWithFormat:@"%@", self.playerTwoVictories];
        } else {
            winningPlayer = @"Player 1";
            self.playerOneVictories = [NSNumber numberWithInt:[self.playerOneVictories intValue] + 1];
            self.playerOneScore.text = [NSString stringWithFormat:@"%@", self.playerOneVictories];
        }
        NSLog(@"player %@ WON", winner);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"WINNER"
                                                       message:[NSString stringWithFormat:@"Congratulations to %@", winningPlayer]
                                                      delegate:self
                                             cancelButtonTitle:@"Play Again"
                                             otherButtonTitles:nil];
        [alert show];
        [self savePlayerScores];
    }
    _winner = winner;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.tttCollectionViewBoard reloadData];
    [self startNewGame];
}

- (IBAction)resetGame:(UIButton *)sender {
    [self.tttCollectionViewBoard reloadData];
    [self startNewGame];
}

#pragma mark - Game Logic Methods

- (void)isThereAWinner {
    if (self.gameBoardPlacesX.count + self.gameBoardPlacesO.count < 5) {
        return;
    }
    
    if ([self isThreeInRowDiagonal:self.gameBoardPlacesX] ||
        [self isThreeInRowHorizontal:self.gameBoardPlacesX] ||
        [self isThreeInRowVertical:self.gameBoardPlacesX]) {
        self.winner = @"X";
    }

    if ([self isThreeInRowDiagonal:self.gameBoardPlacesO] ||
        [self isThreeInRowHorizontal:self.gameBoardPlacesO] ||
        [self isThreeInRowVertical:self.gameBoardPlacesO]) {
        self.winner = @"O";
    }
}

- (BOOL)isThreeInARowFrom:(NSArray *)playerMoves with:(int)startCell to:(int)endCell incrementCellsBy:(int)increment {
    BOOL doHaveAWinner = YES;
    for  (int move = startCell; move < endCell; move+= increment) {
        if (![playerMoves containsObject:[NSNumber numberWithInt:move]]) {
            doHaveAWinner = NO;
        }
    }
    
    return doHaveAWinner;
}

-(BOOL)isThreeInRowHorizontal:(NSArray *)playerMoves {
    BOOL doHaveAWinner = [self isThreeInARowFrom:playerMoves with:0 to:3 incrementCellsBy:1];
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
