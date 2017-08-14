#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Constants.h"

#import "BaseAnimal.h"

@interface WorldGridCell : NSObject

@property (strong, nonatomic) UIImage* icon;
@property (strong, nonatomic) BaseAnimal* animal;
@property (nonatomic) GridCellType type;

@end
