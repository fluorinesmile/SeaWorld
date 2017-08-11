#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SeaWorldMatrix.h"

#define kWorldCellWidth                 15
#define kWorldCellHeight                10

@interface SeaWorldModel : NSObject

@property (strong, nonatomic) NSArray* cells;
@property (strong, nonatomic) SeaWorldMatrix* matrix;
@property (nonatomic, readonly) CGRect frame;

- (void)calculateFrame;

@end
