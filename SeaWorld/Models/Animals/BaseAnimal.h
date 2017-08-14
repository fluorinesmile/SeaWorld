#import <Foundation/Foundation.h>

#import "AnimalInterface.h"
#import "Constants.h"

#define kAddNewIndividNotification  @"AddNewIndividNotification"
#define kRemoveIndividNotification  @"RemoveIndividNotification"

@class WorldGridCell;

@interface BaseAnimal : NSObject <Animal>

@property (strong, nonatomic) NSArray* enviromentCells;
@property (nonatomic) NSUInteger position;
@property (nonatomic) NSUInteger stepsCounter;
@property (nonatomic) NSUInteger reproductionStep;
@property (nonatomic) GridCellType type;

- (void)calculateEnviroment;

- (void)move;
- (void)tryReproduction;
- (void)die;

@end
