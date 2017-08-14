#import "CellGenerator.h"

#import "OrcaCell.h"
#import "PenguinCell.h"
#import "WorldGridCell.h"

@implementation CellGenerator

- (WorldGridCell*)createCellForType:(GridCellType)type {
    switch (type) {
        case kEmpty:
            return [[WorldGridCell alloc] init];
            break;

        case kOrca:
            return [[OrcaCell alloc] init];
            break;

        case kPenguin:
            return [[PenguinCell alloc] init];
            break;

        default:
            return nil;
            break;
    }
}

@end
