#import "PenguinCell.h"
#import "Penguin.h"

@implementation PenguinCell

- (instancetype)init {
    self = [super init];
    if(self) {
        self.icon = [UIImage imageNamed: @"penguin"];
        self.animal = [[Penguin alloc] init];
    }
    return self;
}

@end
