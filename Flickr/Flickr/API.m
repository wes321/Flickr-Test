//
//  API.m
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import "API.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "Image.h"
#import "Comment.h"

//Flickr Config
static NSString * const flickrAPIKey = @"7f5aa8ec4143541af9a984fa08769e6e";
static NSString * const baseURL = @"https://api.flickr.com/services/rest/?&";
static NSString * const imagesPerRequest = @"50";

@implementation API

- (void)loadRecentImages
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@method=flickr.photos.getRecent&api_key=%@&extras=url_m,owner_name&per_page=%@&format=json&nojsoncallback=1",baseURL,flickrAPIKey,imagesPerRequest] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *response) {
        
            app.networkActivityIndicatorVisible = NO;
        
            if([[response objectForKey:@"photos"] objectForKey:@"photo"]){
                NSArray *images = [[response objectForKey:@"photos"] objectForKey:@"photo"];
                
                NSMutableArray *imageObjectArray = [[NSMutableArray alloc]init];
                for (int i = 0; i < [images count]; i++) {
                    Image *image = [[Image alloc]init];
                    image.imageURL = [[images objectAtIndex:i] objectForKey:@"url_m"];
                    image.imageID  = [[images objectAtIndex:i] objectForKey:@"id"];
                    image.username = [[images objectAtIndex:i] objectForKey:@"ownername"];
                    image.title = [[images objectAtIndex:i] objectForKey:@"title"];
                    
                    if(image.imageURL){
                        [imageObjectArray addObject:image];
                    }
                }

                if ([self.delegate respondsToSelector:@selector(imagesReturned:)]){
                    [self.delegate imagesReturned:imageObjectArray];
                }
            } else {
                NSLog(@"loadRecentImages Error: Invalid Response - %@",response);
                app.networkActivityIndicatorVisible = NO;
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"loadRecentImages Error: %@",error.description);
    }];
    
}

- (void)getCommentsForPhotoId:(NSNumber *)photoId
{
    
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    //Test PhotoId with Comments
    //photoId = @(14888674755);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *URL = [NSString stringWithFormat:@"%@method=flickr.photos.comments.getList&api_key=%@&photo_id=%@&format=json&nojsoncallback=1",baseURL,flickrAPIKey,photoId];
    //NSLog(@"URL-%@",URL);
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *response) {
        
        app.networkActivityIndicatorVisible = NO;

        if([[response objectForKey:@"comments"] objectForKey:@"comment"]){
            NSArray *comments = [[response objectForKey:@"comments"] objectForKey:@"comment"];
            
            //NSLog(@"Comments-%@",comments);
            
            NSMutableArray *commentObjectArray = [[NSMutableArray alloc]init];
            for (int i = 0; i < [comments count]; i++) {
                Comment *comment = [[Comment alloc]init];
                
                comment.message     = [[comments objectAtIndex:i] objectForKey:@"_content"];
                comment.username    = [[comments objectAtIndex:i] objectForKey:@"authorname"];
                
                NSTimeInterval seconds = [[[comments objectAtIndex:i] objectForKey:@"datecreate"] doubleValue];
                NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
                comment.dateCreated = epochNSDate;
                
                [commentObjectArray addObject:comment];
            }
            
            if ([self.delegate respondsToSelector:@selector(commentsReturned:)]){
                [self.delegate commentsReturned:commentObjectArray];
            }
        } else {
            if(![[response objectForKey:@"stat"] isEqualToString:@"ok"]){
                NSLog(@"getCommentsForPhotoId Error: Invalid Response - %@",response);
                app.networkActivityIndicatorVisible = NO;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"lgetCommentsForPhotoId Error: %@",error.description);
    }];
}

@end
