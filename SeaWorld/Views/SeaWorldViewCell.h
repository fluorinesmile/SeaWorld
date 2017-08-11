#import <UIKit/UIKit.h>

#import "AnimalCell.h"

@interface SeaWorldViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *animalIcon;

+ (NSString*)reuseIdentifier;

@end
