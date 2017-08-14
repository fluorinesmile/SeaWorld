#import "ViewController.h"

#import "ApplicationCore.h"
#import "LoadingView.h"
#import "WorldGridCell.h"
#import "SeaWorldModel.h"
#import "SeaWorldViewCell.h"

#define kRestartButtonMargin   8

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
}

@property (strong, nonatomic) UICollectionView* worldGrid;
@property (weak, nonatomic) IBOutlet UIButton* restartButton;
@property (strong, nonatomic) LoadingView* loadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden: YES];
    [self configureLoadingView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self showLoadingView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    [self startConfiguring];
}

- (void)startConfiguring {
    [_restartButton setEnabled: NO];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        [[ApplicationCore sharedInstance] generateSeaWorldModelForFrame: CGRectMake(0, statusBarHeight, self.view.frame.size.width, self.restartButton.frame.origin.y - kRestartButtonMargin - statusBarHeight)];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self configureWorldGrid];
        });
    });
}

- (void)configureLoadingView {
    _loadingView = [LoadingView
                    alertControllerWithTitle: @"Please, wait some moment…\n\n"
                    message: @""
                    preferredStyle: UIAlertControllerStyleAlert];
    
}

- (void)showLoadingView {
    [_loadingView.view setNeedsLayout];
    [self.navigationController presentViewController: _loadingView animated: YES completion: nil];
}

- (void)closeLoadingView {
    [_loadingView dismissViewControllerAnimated: YES completion:^{
        [_restartButton setEnabled: YES];
    }];

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
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(handleTap:)];
    [_worldGrid addGestureRecognizer: tapRecognizer];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [_worldGrid setUserInteractionEnabled: NO];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[ApplicationCore sharedInstance] nextStepWithCompletionBlock: ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.worldGrid reloadData];
                [_worldGrid setUserInteractionEnabled: YES];
            });
        }];
    });
}

- (IBAction)restart:(id)sender {
    [self showLoadingView];
    [self startConfiguring];
}

#pragma mark - UICollectionVIewDelegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [ApplicationCore sharedInstance].seaWorldModel.cells.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SeaWorldViewCell* cellView = [collectionView dequeueReusableCellWithReuseIdentifier: [SeaWorldViewCell reuseIdentifier] forIndexPath: indexPath];
    WorldGridCell* cell = [[ApplicationCore sharedInstance].seaWorldModel.cells objectAtIndex: indexPath.row];
    [cellView.animalIcon setImage: cell.icon];
    return cellView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    SeaWorldModel* model = [ApplicationCore sharedInstance].seaWorldModel;
    return CGSizeMake(model.matrix.cellWidth, model.matrix.cellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger cellCount = [ApplicationCore sharedInstance].seaWorldModel.cells.count;
    if(indexPath.row == (cellCount - 1))
        [self closeLoadingView];
}

@end
