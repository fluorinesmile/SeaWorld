#import <Foundation/Foundation.h>

#import "SeaWorldModel.h"

@interface ApplicationCore : NSObject

@property (strong, nonatomic) SeaWorldModel* seaWorldModel;

+ (ApplicationCore*)sharedInstance;
- (void)generateSeaWorldModelForFrame:(CGRect)frame;
- (void)nextStepWithCompletionBlock:(void (^)())completionBlock;

@end
