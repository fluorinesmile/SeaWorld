#import "PlayingFieldCell.h"

#define kReuseIdentifier        @"PlayingFieldCell"

@interface PlayingFieldCell ()

@property (strong, nonatomic) UIImageView* animalIcon;
@property (strong, nonatomic) UIView* cellFrame;

@end

@implementation PlayingFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (NSString*)reuseIdentifier {
    return kReuseIdentifier;
}

- (void)refresh {
    _cellFrame = [[UIView alloc] initWithFrame: self.frame];
    _cellFrame.backgroundColor = [UIColor whiteColor];
    _cellFrame.layer.borderColor = [UIColor colorWithWhite: 0.6f alpha: 1.0f].CGColor;
    _cellFrame.layer.borderWidth = 0.5f;
    
    [self addSubview: _cellFrame];
    
    _animalIcon = [[UIImageView alloc] initWithFrame: self.frame];
    [self addSubview: _animalIcon];
}

@end
