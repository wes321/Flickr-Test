//
//  ImageGridCell.m
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import "ImageGridCell.h"
#import "UIImageView+AFNetworking.h"
#import "API.h"

@interface ImageGridCell () <APIDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIView *detailsView;
@property (retain, nonatomic) NSArray *comments;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@end

@implementation ImageGridCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setImage:(Image *)image
{
    _image = image;
    self.detailsView.hidden = YES;
    
    //Setup Cell
    [self.mainImageView setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.usernameLabel.text = [NSString stringWithFormat:@"By: %@",image.username];
    self.titleLabel.text = image.title;
    self.commentCountLabel.text = @"";
    
    self.comments = nil;
}

- (void)toggleDetailsView
{
    if(self.detailsView.hidden){
        [self loadComments];

        self.detailsView.hidden = NO;
        self.detailsView.alpha = 0;
        self.commentButton.hidden = YES;
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.detailsView.alpha = 1;
                         }
                         completion:^(BOOL finished){
                             
                         }];
    } else {
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.detailsView.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             self.detailsView.hidden = YES;
                         }];
    }
}

- (void)loadComments
{
    if(!self.comments){
        API *api = [[API alloc]init];
        api.delegate = self;
        [api getCommentsForPhotoId:self.image.imageID];
    }
}

#pragma mark - API Delegate Methods
- (void)commentsReturned:(NSArray *)comments
{
    self.comments = comments;
    if([comments count] > 0){
        self.commentCountLabel.text = [NSString stringWithFormat:@"%i",[comments count]];
        self.commentCountLabel.alpha = 0;
        self.commentCountLabel.hidden = NO;
        
        self.commentButton.alpha = 0;
        self.commentButton.hidden = NO;
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.commentButton.alpha = 1;
                             self.commentCountLabel.alpha = 1;
                         }
                         completion:^(BOOL finished){
                         }];
    } else {
        self.commentCountLabel.text = @"";
        self.commentButton.hidden = YES;
        self.commentCountLabel.hidden = YES;
    }
}


@end