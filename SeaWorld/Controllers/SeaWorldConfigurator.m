#import "SeaWorldConfigurator.h"

#define kMinVerticalSpacer          8.0

@implementation SeaWorldConfigurator

- (SeaWorldModel*)seaWorldModelForFrame:(CGRect)frame {
    SeaWorldModel* worldModel = [[SeaWorldModel alloc] init];
    worldModel.matrix.rows = frame.size.height / kWorldCellHeight;
    worldModel.matrix.columns = frame.size.width / kWorldCellWidth;
    [worldModel calculateFrame];
    return worldModel;
}

@end
