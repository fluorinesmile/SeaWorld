#import <Foundation/Foundation.h>

#import "SeaWorldModel.h"

@interface ApplicationCore : NSObject

@property (strong, nonatomic, readonly) SeaWorldModel* seaWorldModel;

+ (ApplicationCore*)sharedInstance;
- (void)generateSeaWorldModelForFrame:(CGRect)frame;

@end
