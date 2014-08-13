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

@interface GalleryViewController () <APIDelegate>
@property (weak, nonatomic) IBOutlet ImageGridView *imageGridView;

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
    
    
    //Get Images From API
    API *api = [[API alloc]init];
    api.delegate = self;
    [api loadPopularImages];
    
    
    //https://api.flickr.com/services/rest/?&method=flickr.photos.getRecent&api_key=7f5aa8ec4143541af9a984fa08769e6e&extras=url_m&per_page=12&format=json
    
    //[_imageGridView setImagesArray:];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API Delegate Methods
- (void)imagesReturned:(NSArray *)images
{
    [self.imageGridView setImagesArray:images];
}

@end
