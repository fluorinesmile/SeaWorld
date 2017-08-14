#import "LoadingView.h"

@interface LoadingView () {
    UIActivityIndicatorView* indicator;
}
@end

@implementation LoadingView

- (void)viewDidLoad {
    [super viewDidLoad];
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [indicator removeFromSuperview];
    
    CGRect frame = self.view.frame;
    indicator.center = CGPointMake(frame.size.width / 2, frame.size.height * 2 / 3);
    indicator.color = [UIColor lightGrayColor];
    [indicator startAnimating];
    [self.view addSubview: indicator];
}

@end
