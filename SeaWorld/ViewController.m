#import "ViewController.h"

#import "ApplicationCore.h"
#import "SeaWorldConfigurator.h"
#import "SeaWorldCell.h"
#import "SeaWorldModel.h"
#import "SeaWorldViewCell.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
}

@property (strong, nonatomic) UICollectionView* worldGrid;
@property (weak, nonatomic) IBOutlet UIButton* restartButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    [self startConfiguring];
}

- (void)startConfiguring {
    // TODO: show nice loading screen
    
    [[ApplicationCore sharedInstance] generateSeaWorldModelForFrame: CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width, self.restartButton.frame.origin.y)];
    [self configureWorldGrid];
}

- (void)configureWorldGrid {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    _worldGrid = [[UICollectionView alloc] initWithFrame: [ApplicationCore sharedInstance].seaWorldModel.frame collectionViewLayout: layout];
    [_worldGrid setDataSource: self];
    [_worldGrid setDelegate: self];

    UINib* cellNib = [UINib nibWithNibName: [SeaWorldViewCell reuseIdentifier] bundle: nil];
    [_worldGrid registerNib: cellNib forCellWithReuseIdentifier: [SeaWorldViewCell reuseIdentifier]];
    
    [_worldGrid setBackgroundColor: [UIColor colorWithWhite: 0.6f alpha: 1.0f]];
    [self.view addSubview: _worldGrid];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [ApplicationCore sharedInstance].seaWorldModel.cells.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SeaWorldViewCell* cellView = [collectionView dequeueReusableCellWithReuseIdentifier: [SeaWorldViewCell reuseIdentifier] forIndexPath: indexPath];
    SeaWorldCell* cellData = [[ApplicationCore sharedInstance].seaWorldModel.cells objectAtIndex: indexPath.row];
    [cellView.animalIcon setImage: cellData.icon];
    return cellView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kWorldCellWidth, kWorldCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
