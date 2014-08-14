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
    [self.browseButton.layer setCornerRadius:5];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.browseButton setAlpha:0];
    [self.logoImageView setAlpha:0];
}
- (void)viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.browseButton setAlpha:1];
                         [self.browseButton setFrame: CGRectMake(self.browseButton.frame.origin.x, self.browseButton.frame.origin.y - 20, self.browseButton.frame.size.width, self.browseButton.frame.size.height)];
                         
                         [self.logoImageView setAlpha:1];
                         [self.logoImageView setFrame: CGRectMake(self.logoImageView.frame.origin.x, self.logoImageView.frame.origin.y - 20, self.logoImageView.frame.size.width, self.logoImageView.frame.size.height)];
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
