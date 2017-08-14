#import "WorldGridCell.h"

@implementation WorldGridCell

- (instancetype)init {
    self = [super init];
    if(self){
        _icon = nil;
        _animal = nil;
    }
    return self;
}

@end
