//
//  GalleryViewController.m
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import "GalleryViewController.h"
#import "WelcomeViewController.h"
#import "ImageGridView.h"
#import "API.h"

@interface GalleryViewController () <APIDelegate, ImageGridViewDelegate>
@property (weak, nonatomic) IBOutlet ImageGridView *imageGridView;
@property (strong, nonatomic) API *api;

@end

@implementation GalleryViewController

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
    self.title = @"Gallery";
    
    self.api = [[API alloc]init];
    self.api.delegate = self;
    
    self.imageGridView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
//    if(self.shouldLaunchWelcome){
//        self.shouldLaunchWelcome = NO;
//
//        WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:[NSBundle mainBundle]];
//        [self presentViewController:welcomeViewController animated:NO completion:^{
//        }];
//    }
    
    
    [self.api loadRecentImages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - API Delegate Methods
- (void)imagesReturned:(NSArray *)images
{
    [self.imageGridView setImagesArray:images];
}

#pragma mark - ImageGridView Delegate Methods
- (void)refreshCollectionView
{
    [self.api loadRecentImages];
}

@end
