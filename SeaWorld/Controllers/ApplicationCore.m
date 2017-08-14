#import "ApplicationCore.h"

#import "AnimalInterface.h"
#import "WorldGridCell.h"
#import "PopulationController.h"

@interface ApplicationCore () {
    PopulationController* populationController;
}

@end

@implementation ApplicationCore

+ (ApplicationCore*)sharedInstance {
    static ApplicationCore* core = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        core = [[self alloc] init];
    });
    
    return core;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        populationController = [[PopulationController alloc] init];
    }
    return self;
}

- (void)generateSeaWorldModelForFrame:(CGRect)frame {
    _seaWorldModel = [SeaWorldModel createWorldWithWidth: kWorldColumns height: kWorldRows freeSpace: frame];
    populationController = [[PopulationController alloc] init];
    [populationController createPopulationForWorldModelMatrix: _seaWorldModel.matrix];
    [populationController fillWorld: _seaWorldModel];
}

- (void)nextStepWithCompletionBlock:(void (^)())completionBlock {
    for(WorldGridCell* cell in _seaWorldModel.cells) {
        if(cell.animal != nil)
            [cell.animal step];
    }
    [populationController fillWorld: _seaWorldModel];
    
    if(completionBlock)
        completionBlock();
}

@end
