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
#import "Comment.h"
#import "CommentCell.h"

static NSString * const cellIdentifier = @"CommentCell";

@interface ImageGridCell () <APIDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIView *detailsView;
@property (retain, nonatomic) NSArray *comments;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;
- (IBAction)commentButtonPressed:(id)sender;
@end

@implementation ImageGridCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    [self.commentsTableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
}

- (void)setImage:(Image *)image
{
    _image = image;

    //Setup Cell
    [self.mainImageView setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.usernameLabel.text = [NSString stringWithFormat:@"By: %@",image.username];
    self.titleLabel.text = image.title;
    self.commentCountLabel.text = @"";
    
    self.comments = nil;
    [self.commentsTableView setFrame:CGRectMake(0, 320, 320, 258)];
    [self.commentsTableView setHidden: YES];
    
    [self.detailsView setHidden:YES];
    [self.detailsView setFrame:CGRectMake(0, 258, 320, 62)];
    
    [self.commentCountLabel setHidden:YES];
    [self.commentButton setHidden:YES];
}

- (void)toggleDetailsView
{
    if(self.detailsView.hidden){
        [self loadComments];

        [self.detailsView setHidden:NO];
        [self.detailsView setAlpha:0];
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.detailsView setAlpha:1];
                         }
                         completion:^(BOOL finished){
                             
                         }];
    } else {
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.detailsView setAlpha:0];
                         }
                         completion:^(BOOL finished){
                             [self.detailsView setHidden:YES];
                         }];
    }
}

- (void)loadComments
{
    API *api = [[API alloc]init];
    api.delegate = self;
    [api getCommentsForPhotoId:self.image.imageID];
}

#pragma mark - API Delegate Methods
- (void)commentsReturned:(NSArray *)comments
{
    self.comments = comments;
    if([comments count] > 0){
        self.commentCountLabel.text = [NSString stringWithFormat:@"%i",[comments count]];
        if(self.commentCountLabel.hidden){
            [self.commentCountLabel setHidden:NO];
            [self.commentCountLabel setAlpha:0];
            [self.commentButton setHidden:NO];
            [self.commentButton setAlpha:0];
            
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [self.commentCountLabel setAlpha:1];
                                 [self.commentButton setAlpha:1];
                             }
                             completion:^(BOOL finished){
                             }];
        }
        [self.commentsTableView reloadData];
    } else {
        self.commentCountLabel.text = @"";
        [self.commentButton setHidden:YES];
        [self.commentCountLabel setHidden:YES];
    }
}


#pragma mark - Table Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Comment *comment = [self.comments objectAtIndex:indexPath.row];
    [cell setComment:comment];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment *comment = [self.comments objectAtIndex:indexPath.row];
    
    CGFloat height = 0.0;
    
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width, 5000000);
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin;
    
    NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGRect labelBounds = [comment.message boundingRectWithSize:maximumLabelSize
                                              options:options
                                           attributes:attr
                                              context:nil];
    height = labelBounds.size.height;
    
    return height + 35;
}


#pragma mark - IBAction Methods
- (IBAction)commentButtonPressed:(id)sender
{
    if(self.commentsTableView.hidden){
        [self.commentsTableView setHidden:NO];
        [self.commentsTableView setFrame:CGRectMake(0, 320, 320, 258)];
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.detailsView setFrame:CGRectMake(0, 0, 320, 62)];
                             [self.commentsTableView setFrame: CGRectMake(0, 62, 320, 258)];
                         }
                         completion:^(BOOL finished){
                             
                         }];
    } else {
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.detailsView setFrame:CGRectMake(0, 258, 320, 62)];
                             [self.commentsTableView setFrame:CGRectMake(0, 320, 320, 258)];
                         }
                         completion:^(BOOL finished){
                             [self.commentsTableView setHidden:YES];
                         }];
    }
}
@end