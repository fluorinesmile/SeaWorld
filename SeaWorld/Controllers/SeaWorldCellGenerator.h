#import <Foundation/Foundation.h>
#import "SeaWorldCell.h"

typedef NS_ENUM(NSUInteger, SeaWorldCellType) {
    kEmpty,
    kOrca,
    kPenguin
};

@interface SeaWorldCellGenerator : NSObject

- (SeaWorldCell*)getCellForType:(SeaWorldCellType)type;

@end
