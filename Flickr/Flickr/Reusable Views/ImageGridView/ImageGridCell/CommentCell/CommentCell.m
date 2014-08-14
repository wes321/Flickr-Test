//
//  CommentCell.m
//  Flickr
//
//  Created by Wesley Lorenzini on 8/13/14.
//
//

#import "CommentCell.h"

@interface CommentCell ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic) NSDateFormatter *dateFormatter;

@end


@implementation CommentCell

- (void)awakeFromNib
{
    // Initialization code
    self.messageLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSDateFormatter *)dateFormatter {
    
    if (_dateFormatter != nil)
        return _dateFormatter;
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"MM/dd/yy"];

    return _dateFormatter;
}


- (void)setComment:(Comment *)comment
{
    _comment = comment;
    
    self.usernameLabel.text = comment.username;
    
    NSDateFormatter *dateFormatter = [self dateFormatter];
    
    self.dateLabel.text = [dateFormatter stringFromDate:comment.dateCreated];
    
    self.messageLabel.frame = CGRectMake(9, 26, 303, 50);
    self.messageLabel.text = [comment.message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    [self.messageLabel sizeToFit];
    
    self.messageLabel.frame = CGRectMake(self.messageLabel.frame.origin.x, 26, self.messageLabel.frame.size.width, self.messageLabel.frame.size.height);

}

@end
