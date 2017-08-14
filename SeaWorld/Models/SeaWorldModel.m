#import "SeaWorldModel.h"

@implementation SeaWorldModel

- (instancetype)init {
    self = [super init];
    if(self) {
        self.matrix = [[SeaWorldMatrix alloc] init];
    }
    return self;
}

+ (SeaWorldModel*)createWorldWithWidth:(NSUInteger)width height:(NSUInteger)height freeSpace:(CGRect)frame {
    SeaWorldModel* model = [[SeaWorldModel alloc] init];
    model.matrix.columns = width;
    model.matrix.rows = height;

    
    // calculateFrame

    CGFloat minCellWidth = frame.size.width / kWorldColumns;
    CGFloat minCellHeight = frame.size.height / kWorldRows;

    BOOL isSquareCell = YES;
    // Let each cell is square cell

    if(isSquareCell) {
        
        CGFloat cellSide = minCellWidth;
        
        if(minCellHeight < minCellHeight)
            cellSide = minCellHeight;
        model.matrix.cellWidth = model.matrix.cellHeight = cellSide;
    }
    else {
        model.matrix.cellWidth = minCellWidth;
        model.matrix.cellHeight = minCellHeight;
    }
    
    CGFloat gridWidth = model.matrix.cellWidth * kWorldColumns;
    CGFloat gridHeight = model.matrix.cellHeight * kWorldRows;
    
    model.frame = CGRectMake((frame.size.width - gridWidth) / 2, frame.origin.y, gridWidth, gridHeight);
    return model;
}

@end
