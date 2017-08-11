#import "SeaWorldViewCell.h"

#define kReuseIdentifier        @"SeaWorldViewCell"

@interface SeaWorldViewCell ()
@property (weak, nonatomic) IBOutlet UIView *frameView;

@end

@implementation SeaWorldViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frameView.layer.borderColor = [UIColor colorWithWhite: 0.6f alpha: 1.0f].CGColor;
    self.frameView.layer.borderWidth = 0.3f;
}

+ (NSString*)reuseIdentifier {
    return kReuseIdentifier;
}

@end
