#import <Foundation/Foundation.h>

#import "Constants.h"

@class WorldGridCell;

@interface CellGenerator : NSObject

- (WorldGridCell*)createCellForType:(GridCellType)type;

@end
