//
//  ImageGridCell.m
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import "ImageGridCell.h"
#import "UIImageView+AFNetworking.h"

@interface ImageGridCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIView *detailsView;
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
    
}

@end
