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
    
    _detailsView.hidden = YES;
    
    //Setup Cell
    [self.mainImageView setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.usernameLabel.text = [NSString stringWithFormat:@"By: %@",image.username];
    self.titleLabel.text = image.title;
}

- (void)toggleDetailsView
{
    if(_detailsView.hidden){
        [self loadComments];

        _detailsView.hidden = NO;
        _detailsView.alpha = 0;
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _detailsView.alpha = 1;
                         }
                         completion:^(BOOL finished){
                             
                         }];
    } else {
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _detailsView.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             _detailsView.hidden = YES;
                         }];
    }
}

- (void)loadComments
{
    if(!self.comments){
        self.commentButton.titleLabel.text = @"";
        
        //Get Comments From API
        API *api = [[API alloc]init];
        api.delegate = self;
        [api getCommentsForPhotoId:self.image.imageID];
    }
}

#pragma mark - API Delegate Methods
- (void)commentsReturned:(NSArray *)comments
{
    self.comments = comments;
    self.commentButton.titleLabel.text = [NSString stringWithFormat:@"%i",[comments count]];
}


@end