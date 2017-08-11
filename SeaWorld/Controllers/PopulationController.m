#import "PopulationController.h"

#import "OrcaCell.h"
#import "PenguinCell.h"
#import "SeaWorldCell.h"
#import "SeaWorldCellGenerator.h"

#include <time.h>
#include <stdlib.h>

#define kOrcaFillingPercents        5
#define kPenguinFillingPercents     50

@interface PopulationController () {
    SeaWorldMatrix* worldMatrix;
    SeaWorldCellGenerator* seaWorldCellGenerator;
}

@end

@implementation PopulationController

- (void)setWorldMatrix:(SeaWorldMatrix*)matrix {
    worldMatrix = matrix;
}

- (NSArray*)createPopulation {
    seaWorldCellGenerator = [[SeaWorldCellGenerator alloc] init];
    NSMutableArray* population = [[NSMutableArray alloc] init];
    [self initPopulation: population withCapacity: (worldMatrix.rows * worldMatrix.columns)];
    srand(time(0));
    [self setPenguins: population];
    [self setOrcas: population];
    
    return [[NSArray alloc] initWithArray: population];
}

- (void)initPopulation:(NSMutableArray*)population withCapacity:(NSUInteger)capacity{
    for(NSUInteger i = 0; i < capacity; i++)
        [population addObject: [seaWorldCellGenerator getCellForType: kEmpty]];
}

- (void)setPenguins:(NSMutableArray*)population {
    NSUInteger penguinsCount = population.count * kPenguinFillingPercents / 100;
    for(int i = 0; i < penguinsCount; i++)
        [self setAnimalWithType: kPenguin inPopulation: population];
}

- (void)setOrcas:(NSMutableArray*)population {
    NSUInteger orcasCount = population.count * kOrcaFillingPercents / 100;
    for(int i = 0; i < orcasCount; i++) {
        [self setAnimalWithType: kOrca inPopulation: population];
    }
}

- (void)setAnimalWithType:(SeaWorldCellType)type inPopulation:(NSMutableArray*)population {
    NSUInteger randomIndex = rand() % population.count;
    SeaWorldCell* seaWorldCell = [population objectAtIndex: randomIndex];
    if(!seaWorldCell.empty)
        randomIndex = [self searchEmptyCellInPopulation: population startIndex: (randomIndex + 1)];
    
    [population replaceObjectAtIndex: randomIndex withObject: [seaWorldCellGenerator getCellForType: type]];
}

- (NSUInteger)searchEmptyCellInPopulation:(NSMutableArray*)population startIndex:(NSUInteger)index {
    if(index >= population.count)
        index = 0;
    
    //search in tail of array
    for(NSUInteger i = index; i < population.count; i++) {
        SeaWorldCell* seaWorldCell = [population objectAtIndex: index];
        if(seaWorldCell.empty)
            return i;
    }
    
    //search in head of array, if tail's cells not empty
    for(NSUInteger i = 0; i < index; i++) {
        SeaWorldCell* seaWorldCell = [population objectAtIndex: index];
        if(seaWorldCell.empty)
            return i;
    }

    return 0;
}

@end
