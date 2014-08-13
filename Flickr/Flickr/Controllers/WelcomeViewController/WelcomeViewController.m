//
//  WelcomeViewController.m
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import "WelcomeViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface WelcomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIButton *browseButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
- (IBAction)browseImagesTapped:(id)sender;

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _browseButton.layer.cornerRadius = 5;
}

- (void)viewWillAppear:(BOOL)animated
{
    _browseButton.alpha = 0;
    _logoImageView.alpha = 0;
}
- (void)viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _browseButton.alpha = 1;
                         _browseButton.frame = CGRectMake(_browseButton.frame.origin.x, _browseButton.frame.origin.y - 20, _browseButton.frame.size.width, _browseButton.frame.size.height);
                         
                         _logoImageView.alpha = 1;
                         _logoImageView.frame = CGRectMake(_logoImageView.frame.origin.x, _logoImageView.frame.origin.y - 20, _logoImageView.frame.size.width, _logoImageView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)browseImagesTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
