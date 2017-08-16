#import <Foundation/Foundation.h>

@class SeaWorldModel;
@class SeaWorldMatrix;

@interface PopulationController : NSObject

- (void)createPopulationForWorldModelMatrix:(SeaWorldMatrix*)matrix;
- (void)fillWorld:(SeaWorldModel*)model;

@end
