#import <Foundation/Foundation.h>

@class SeaWorldModel;
@class SeaWorldMatrix;

@interface PopulationController : NSObject

- (void)refreshWorld:(SeaWorldModel*)model;
- (void)createPopulationForWorldModelMatrix:(SeaWorldMatrix*)matrix;
- (void)fillWorld:(SeaWorldModel*)model;
- (NSArray*)cells;

@end
