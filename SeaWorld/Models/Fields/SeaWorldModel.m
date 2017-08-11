#import "SeaWorldModel.h"

@implementation SeaWorldModel

- (instancetype)init {
    self = [super init];
    if(self) {
        self.matrix = [[SeaWorldMatrix alloc] init];
    }
    return self;
}

- (void)calculateFrame {
    _frame.origin = CGPointMake(0, 0);
    _frame.size.width = kWorldCellWidth * _matrix.columns;
    _frame.size.height = kWorldCellHeight * _matrix.rows;
}

@end
