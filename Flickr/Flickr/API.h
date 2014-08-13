//
//  API.h
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import <Foundation/Foundation.h>

@protocol APIDelegate <NSObject>
@optional
- (void)imagesReturned:(NSArray *)images;
- (void)commentsReturned:(NSArray *)images;
@end

@interface API : NSObject

@property (weak,nonatomic) id<APIDelegate> delegate;
- (void)loadPopularImages;

@end