#import "SeaWorldCell.h"

#import "AnimalInterface.h"

@interface AnimalCell : SeaWorldCell

@property (strong, nonatomic) id <Animal> animal;

@end
