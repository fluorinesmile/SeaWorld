#import <UIKit/UIKit.h>

@interface SeaWorldViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *animalIcon;

+ (NSString*)reuseIdentifier;

@end
