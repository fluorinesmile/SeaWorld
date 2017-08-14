#import "Orca.h"

#import "ApplicationCore.h"
#import "Penguin.h"
#import "WorldGridCell.h"
#import "SeaWorldModel.h"

#define kOrcaReproductionStep              8
#define kOrcaDeathWithoutEatStep           3

@interface Orca () {
    Penguin* tastyPenguin;
}

@property (nonatomic) NSUInteger hungerCounter;

@end

@implementation Orca

- (instancetype)init {
    self = [super init];
    if(self) {
        self.type = kOrca;
        self.reproductionStep = kOrcaReproductionStep;
        self.hungerCounter = 0;
        tastyPenguin = nil;
    }
    return self;
}

- (void)move {
    if([self findTastyPenguin])
        [self eatPenguin];
    else {
        [super move];
        self.hungerCounter++;
        if([self checkMustItDie])
            [self die];
    }
}

- (void)eatPenguin {
    self.hungerCounter = 0;
    [self moveOnTastyPenguinPosition];
}

- (BOOL)findTastyPenguin {
    for(NSNumber* enviromentIndex in self.enviromentCells) {
        if([self isPenguin: [enviromentIndex unsignedIntegerValue]])
            return YES;
    }
    tastyPenguin = nil;
    return NO;
}

- (BOOL)isPenguin:(NSInteger)index {

    WorldGridCell* cell = [[ApplicationCore sharedInstance].seaWorldModel.cells objectAtIndex: index];
    if(cell.animal && cell.animal.type == kPenguin) {
        tastyPenguin = (Penguin*)cell.animal;
        return YES;
    }
    return NO;
}

- (void)moveOnTastyPenguinPosition {
    [tastyPenguin die];
    self.position = tastyPenguin.position;
    self.stepsCounter++;
}

- (BOOL)checkMustItDie {
    return self.hungerCounter >= kOrcaDeathWithoutEatStep;
}

@end
