#import "BaseAnimal.h"

#import "ApplicationCore.h"
#import "SeaWorldModel.h"
#import "WorldGridCell.h"

#include <time.h>
#include <stdlib.h>

struct RowLimit {
    NSInteger left;
    NSInteger right;
};
typedef struct RowLimit RowLimit;


@implementation BaseAnimal

- (void)step {
    [self move];
    [self calculateEnviroment];
    [self tryReproduction];
}

#pragma mark - Move

- (void)move {
    
    int randCellInEnviroment = rand() % self.enviromentCells.count;
    NSUInteger checkedIndex = [[self.enviromentCells objectAtIndex: randCellInEnviroment] unsignedIntegerValue];

    if(![self chekEmptyCell: checkedIndex])
        return;
    
    self.position = checkedIndex;
    self.stepsCounter++;
}

#pragma mark - Reproduction

- (void)tryReproduction {
    if(self.stepsCounter < self.reproductionStep)
        return;
    
    self.stepsCounter = 0;
    srand(time(0));
    NSInteger index = [self searchEmptyCell];
    if(index < 0)
        return;
    [self reproductionOnIndex: index];
}

- (void)reproductionOnIndex:(NSUInteger)index {
    NSDictionary* notifyObject = @{
                                   @"animalType" : [NSNumber numberWithUnsignedInteger: self.type],
                                   @"index" : [NSNumber numberWithUnsignedInteger: index]
                                   };
    [[NSNotificationCenter defaultCenter] postNotificationName: kAddNewIndividNotification object: notifyObject];
}

#pragma mark - Die

- (void)die {
    NSDictionary* notifyObject = @{
                                   @"index" : [NSNumber numberWithUnsignedInteger: self.position]
                                   };
    [[NSNotificationCenter defaultCenter] postNotificationName: kRemoveIndividNotification object: notifyObject];

}

#pragma mark - Additional

- (NSInteger)searchEmptyCell {
    int randCellInEnviroment = rand() % self.enviromentCells.count;
    NSUInteger checkedIndex = [[self.enviromentCells objectAtIndex: randCellInEnviroment] unsignedIntegerValue];
    
    if([self chekEmptyCell: checkedIndex])
       return checkedIndex;
    
    for(NSNumber* enviromentIndex in self.enviromentCells) {
        if([self chekEmptyCell: [enviromentIndex unsignedIntegerValue]])
            return [enviromentIndex unsignedIntegerValue];
    }
    
    return -1; // if all enviroment cells isn't empty
}

- (BOOL)chekEmptyCell:(NSUInteger)cellIndex {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(WorldGridCell*_Nullable cell, NSDictionary<NSString *,id> *__unused _Nullable bindings) {
        return cell.animal.position == cellIndex;
    }];
    
    NSArray* filtrated =  [[ApplicationCore sharedInstance].seaWorldModel.population filteredArrayUsingPredicate:
                          predicate];

    if(filtrated.count > 0)
        return NO;

    return YES;
}

- (void)calculateEnviroment {
    
    // SeaWorld model is array but we work with it like matrix
    
    SeaWorldModel* model = [ApplicationCore sharedInstance].seaWorldModel;
        
    NSMutableArray* tmp_enviromentCells = [[NSMutableArray alloc] init];
    NSInteger index = self.position;
    
    RowLimit limit;
    
    NSInteger originalIndex = index;
    index -= model.matrix.columns;                  // stand up on previous row
    
    if(index >= 0) {                                // if index < 0 we don't need in this row
        limit = [self getRowLimitForIndex: index];  // get limit indexes for rigth & left side for current row
        
        index--;                                    // stand up on previous cell on previous row
        
        for(NSInteger i = index; i < index + 3; i++) {
            if((i >= limit.left) && (i <= limit.right))
                [self addIndex: i enviromentCells: tmp_enviromentCells];
        }
    }
    
    
    index = originalIndex + model.matrix.columns;               // stand up on next row (for original index)
    
    if(index < (model.matrix.rows * model.matrix.columns)) {    // if index > cell count, we don't need in this row
        limit = [self getRowLimitForIndex: index];
        index--;                                                // stand up on previous cell in next row
    
        for(NSInteger i = index; i < index + 3; i++) {
            if((i >= limit.left) && (i <= limit.right))
                [self addIndex: i enviromentCells: tmp_enviromentCells];
        }
    }
    
    index = originalIndex;
    limit = [self getRowLimitForIndex: index];
    index--;
    for(NSInteger i = index; i < index + 3; i += 2) {
        if((i >= limit.left) && (i <= limit.right))
            [self addIndex: i enviromentCells: tmp_enviromentCells];
    }
    
    self.enviromentCells = [[NSArray alloc] initWithArray: tmp_enviromentCells];
}

- (void)addIndex:(NSInteger)index enviromentCells:(NSMutableArray*)enviromentCells {
    SeaWorldModel* model = [ApplicationCore sharedInstance].seaWorldModel;

    NSUInteger cellCount = model.matrix.rows * model.matrix.columns;
    if((index < 0) && (index >= cellCount))
        return;
    
    [enviromentCells addObject: [NSNumber numberWithInteger: index]];
}

- (RowLimit)getRowLimitForIndex:(NSInteger)index {
    RowLimit limit;
    
    SeaWorldModel* model = [ApplicationCore sharedInstance].seaWorldModel;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode: NSNumberFormatterRoundDown];
    [formatter setMaximumFractionDigits: 0];

    CGFloat double_row = (CGFloat)index / model.matrix.columns;
    NSString* rowWrapperResult = [formatter stringFromNumber: [NSNumber numberWithFloat: double_row]];
    NSInteger row = [rowWrapperResult integerValue];
    
    limit.left = row * (NSInteger) model.matrix.columns;
    limit.right = limit.left + (NSInteger) model.matrix.columns - 1;
    return limit;
}

@end
