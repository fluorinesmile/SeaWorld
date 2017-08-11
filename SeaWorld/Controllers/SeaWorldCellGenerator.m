#import "SeaWorldCellGenerator.h"

#import "OrcaCell.h"
#import "PenguinCell.h"


@implementation SeaWorldCellGenerator

- (SeaWorldCell*)getCellForType:(SeaWorldCellType)type {
    switch (type) {
        case kEmpty:
            return [[SeaWorldCell alloc] init];
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
