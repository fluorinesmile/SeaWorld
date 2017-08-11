#pragma once

#import <UIKit/UIKit.h>

@protocol Animal <NSObject>

@property (strong, nonatomic) NSArray* lifeField;
@property (strong, nonatomic) NSArray* movesCounter;

- (void)move;
- (void)reproduction;
- (void)checkMustItDie;
- (void)die;

@optional
- (void)eat;

@end
