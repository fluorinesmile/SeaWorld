#import "OrcaCell.h"

#import "Orca.h"

@implementation OrcaCell

- (instancetype)init {
    self = [super init];
    if(self) {
        self.icon = [UIImage imageNamed: @"orca"];
        self.animal = [[Orca alloc] init];
    }
    return self;
}

@end
