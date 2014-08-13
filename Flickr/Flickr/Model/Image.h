//
//  Image.h
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import <Foundation/Foundation.h>

@interface Image : NSObject
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSNumber *imageID;

@end