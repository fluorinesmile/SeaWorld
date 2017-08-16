#import "PopulationController.h"

#import "ApplicationCore.h"
#import "CellGenerator.h"
#import "BaseAnimal.h"
#import "SeaWorldModel.h"
#import "WorldGridCell.h"

#import "Constants.h"

#include <time.h>
#include <stdlib.h>

#define kOrcaFillingPercents        5
#define kPenguinFillingPercents     50

@interface PopulationController () {
    SeaWorldMatrix* worldMatrix;
    CellGenerator* cellGenerator;
}

@end

@implementation PopulationController

- (instancetype)init {
    self = [super init];
    if(self) {
        cellGenerator = [[CellGenerator alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(addNewIndivid:) name: kAddNewIndividNotification object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(removeIndivid:) name: kRemoveIndividNotification object: nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)addNewIndivid:(NSNotification*)notification {
    NSDictionary* object = notification.object;
    if(!object)
        return;
    GridCellType type = [[object objectForKey: @"animalType"] unsignedIntegerValue];
    WorldGridCell* newCell = [cellGenerator createCellForType: type];
    newCell.animal.position = [[object objectForKey: @"index"] unsignedIntegerValue];
    [newCell.animal calculateEnviroment];
    [[ApplicationCore sharedInstance].seaWorldModel.population addObject: newCell];
}

- (void)removeIndivid:(NSNotification*)notification {
    NSDictionary* object = notification.object;
    if(!object)
        return;
    NSUInteger index = [[object objectForKey: @"index"] unsignedIntegerValue];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(WorldGridCell*_Nullable cell, NSDictionary<NSString *,id> *__unused _Nullable bindings) {
        return cell.animal.position == index;
    }];

    NSArray* filtrated = [[ApplicationCore sharedInstance].seaWorldModel.population filteredArrayUsingPredicate:
                          predicate];
    if(filtrated.count == 0)
        return;
    [[ApplicationCore sharedInstance].seaWorldModel.population removeObject: [filtrated objectAtIndex: 0]];
}

- (void)fillWorld:(SeaWorldModel*)model {    
    [self sortCellsForIndex];
    model.cells = [self createCells];
}

- (void)createPopulationForWorldModelMatrix:(SeaWorldMatrix*)matrix {
    worldMatrix = matrix;
    [ApplicationCore sharedInstance].seaWorldModel.population = [[NSMutableArray alloc] init];
    NSMutableArray* emptyIndexes = [[NSMutableArray alloc] init];
    [self initEmptyCells: emptyIndexes];
    [self createPenguins: emptyIndexes];
    [self createOrcas: emptyIndexes];
}

- (void)initEmptyCells:(NSMutableArray*)emptyIndexes {
    NSUInteger capacity = worldMatrix.rows * worldMatrix.columns;
    for(NSUInteger i = 0; i < capacity; i++)
        [emptyIndexes addObject: [NSNumber numberWithUnsignedInteger: i]];
}

- (void)createPenguins:(NSMutableArray*)emptyIndexes {
    NSUInteger capacity = worldMatrix.rows * worldMatrix.columns;
    NSUInteger penguinsCount = capacity * kPenguinFillingPercents / 100;
    [self createCellsWithType: kPenguin count: penguinsCount emptyIndexes: emptyIndexes];
}

- (void)createOrcas:(NSMutableArray*)emptyIndexes {
    NSUInteger capacity = worldMatrix.rows * worldMatrix.columns;
    NSUInteger orcasCount = capacity * kOrcaFillingPercents / 100;
    [self createCellsWithType: kOrca count: orcasCount emptyIndexes: emptyIndexes];
}

- (void)createCellsWithType:(GridCellType)type count:(NSUInteger)count emptyIndexes:(NSMutableArray*)emptyIndexes {
    for(int i = 0; i < count; i++) {
        NSUInteger indexInWoldGrid =  [self getRandomPosition: emptyIndexes];
        WorldGridCell* cell = [cellGenerator createCellForType: type];
        cell.animal.position = indexInWoldGrid;
        [cell.animal calculateEnviroment];
        [[ApplicationCore sharedInstance].seaWorldModel.population addObject: cell];
    }
}

- (NSUInteger)getRandomPosition:(NSMutableArray*)emptyCells {
    int randIndex = rand() % emptyCells.count;
    NSNumber* indexWrapper = [emptyCells objectAtIndex: randIndex];
    [emptyCells removeObject: indexWrapper];
    return [indexWrapper unsignedIntegerValue];
}

- (void)sortCellsForIndex {
    NSArray* sortedPopulation = [[ApplicationCore sharedInstance].seaWorldModel.population sortedArrayUsingComparator: ^(WorldGridCell* firstCell, WorldGridCell* secondCell) {
        NSNumber* firstNum = [NSNumber numberWithUnsignedInteger: firstCell.animal.position];
        NSNumber* secondNum = [NSNumber numberWithUnsignedInteger: secondCell.animal.position];
        return [firstNum compare: secondNum];
    }];
    [ApplicationCore sharedInstance].seaWorldModel.population = [[NSMutableArray alloc] initWithArray: sortedPopulation];
}

- (NSArray*)createCells {
    NSMutableArray* tmp_cells = [[NSMutableArray alloc] init];
    NSUInteger index = 0;
    for(WorldGridCell* cell in [ApplicationCore sharedInstance].seaWorldModel.population) {
        while(index < cell.animal.position) {
            [tmp_cells addObject: [cellGenerator createCellForType: kEmpty]];
            index++;
        }
        [tmp_cells addObject: cell];
        index = cell.animal.position + 1;
    }
    
    while(index < (worldMatrix.columns * worldMatrix.rows)) {
        [tmp_cells addObject: [cellGenerator createCellForType: kEmpty]];
        index++;
    }
    
    return [[NSArray alloc] initWithArray: tmp_cells];
}

@end
