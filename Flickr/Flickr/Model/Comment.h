//
//  Comment.h
//  Flickr
//
//  Created by Wesley Lorenzini on 8/13/14.
//
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSDate *dateCreated;
@end