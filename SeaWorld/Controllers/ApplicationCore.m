#import "ApplicationCore.h"

#import "PopulationController.h"
#import "SeaWorldConfigurator.h"

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
    SeaWorldConfigurator* seaWorldConfigurator = [[SeaWorldConfigurator alloc] init];
    _seaWorldModel = [seaWorldConfigurator seaWorldModelForFrame: frame];
    [populationController setWorldMatrix: _seaWorldModel.matrix];
    _seaWorldModel.cells = [populationController createPopulation];
}

@end
