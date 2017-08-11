#import <UIKit/UIKit.h>

@interface PlayingFieldCell : UICollectionViewCell

@property (nonatomic) NSUInteger type;

+ (NSString*)reuseIdentifier;
- (void)refresh;

@end
