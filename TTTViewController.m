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

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSUserDefaults standardUserDefaults]setObject:self.playerOneVictories forKey:playerOneScoreKey];
    [[NSUserDefaults standardUserDefaults]setObject:self.playerTwoVictories forKey:playerTwoScoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)startNewGame {
    self.isFirstPlayersTurn = YES;
    self.gameBoardPlacesO = [NSMutableArray array];
    self.gameBoardPlacesX = [NSMutableArray array];
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
        } else {
            winningPlayer = @"Player 1";
            self.playerOneVictories = [NSNumber numberWithInt:[self.playerOneVictories intValue] + 1];
        }
        NSLog(@"player %@ WON", winner);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"WINNER"
                                                       message:[NSString stringWithFormat:@"Congratulations to %@", winningPlayer]
                                                      delegate:self
                                             cancelButtonTitle:@"Play Again"
                                             otherButtonTitles:nil];
        [alert show];
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
    /*
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
    */
    
    /* works but ugly -- move these calls to a method that loops through em all
    if ([self isThreeInARowFrom:self.gameBoardPlacesX with:0 to:3 incrementCellsBy:1] ||
        [self isThreeInARowFrom:self.gameBoardPlacesX with:3 to:6 incrementCellsBy:1] ||
        [self isThreeInARowFrom:self.gameBoardPlacesX with:6 to:9 incrementCellsBy:1]) {
        self.winner = @"X";
    }  else if ([self isThreeInARowFrom:self.gameBoardPlacesX with:2 to:7 incrementCellsBy:2] ||
                [self isThreeInARowFrom:self.gameBoardPlacesX with:0 to:9 incrementCellsBy:4]) {
        self.winner = @"X";
    } else if ([self isThreeInARowFrom:self.gameBoardPlacesX with:0 to:7 incrementCellsBy:3] ||
               [self isThreeInARowFrom:self.gameBoardPlacesX with:1 to:8 incrementCellsBy:3] ||
               [self isThreeInARowFrom:self.gameBoardPlacesX with:2 to:9 incrementCellsBy:3]) {
        self.winner = @"X";
    }
    */

    NSNumber *max=[self.gameBoardPlacesX valueForKeyPath:@"@max.self"];
    NSNumber *min=[self.gameBoardPlacesX valueForKeyPath:@"@min.self"];
    
    if ([self isThreeInARowFrom:self.gameBoardPlacesX with:[min integerValue] to:[max integerValue] incrementCellsBy:1]) {
        self.winner = @"X";
    }

}

/* works but ugly
- (BOOL)isThreeInARowFrom:(NSArray *)playerMoves with:(int)startCell to:(int)endCell incrementCellsBy:(int)increment {
    BOOL doHaveAWinner = YES;
    for  (int move = startCell; move < endCell; move+= increment) {
        if (![playerMoves containsObject:[NSNumber numberWithInt:move]]) {
            doHaveAWinner = NO;
        }
    }

    return doHaveAWinner;
}
*/



- (BOOL)isThreeInARowFrom:(NSArray *)playerMoves with:(NSInteger)startCell to:(NSInteger)endCell incrementCellsBy:(int)increment {
    BOOL doHaveAWinner = YES;
    int counter;
    for  (NSInteger move = 0; move < 9; move+= increment) {
        counter++;
        NSLog(@"counter =%d", counter);
        if (![playerMoves containsObject:[NSNumber numberWithInteger:move]]) {
            doHaveAWinner = NO;
        }
        if (counter % 3 == 0) {
            if (doHaveAWinner) {
                break;
            } else {
                doHaveAWinner = YES;
            }
        }
    }
    
    return doHaveAWinner;
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
