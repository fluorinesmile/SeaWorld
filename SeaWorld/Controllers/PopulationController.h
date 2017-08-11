#import <Foundation/Foundation.h>

#import "SeaWorldModel.h"

@interface PopulationController : NSObject

- (NSArray*)createPopulation;
- (void)setWorldMatrix:(SeaWorldMatrix*)matrix;

@end
