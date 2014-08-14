//
//  CommentCell.h
//  Flickr
//
//  Created by Wesley Lorenzini on 8/13/14.
//
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@interface CommentCell : UITableViewCell
@property (nonatomic, strong) Comment *comment;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@end
