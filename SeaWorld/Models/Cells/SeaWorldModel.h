#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Constants.h"
#import "SeaWorldMatrix.h"

@class BaseAnimal;

@interface SeaWorldModel : NSObject

@property (strong, nonatomic) NSArray* cells;
@property (strong, nonatomic) NSMutableArray* population;

@property (strong, nonatomic) SeaWorldMatrix* matrix;
@property (nonatomic) CGRect frame;

+ (SeaWorldModel*)createWorldWithWidth:(NSUInteger)width height:(NSUInteger)height freeSpace:(CGRect)frame;

@end
