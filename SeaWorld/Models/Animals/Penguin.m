#import "Penguin.h"

#define kPenguinReproductionStep       3

@implementation Penguin

- (instancetype)init {
    self = [super init];
    if(self) {
        self.type = kPenguin;
        self.reproductionStep = kPenguinReproductionStep;
    }
    return self;
}

@end
