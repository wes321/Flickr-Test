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
static NSString * const imagesPerRequest = @"25";

@implementation API

- (void)loadPopularImages
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@method=flickr.photos.getRecent&api_key=%@&extras=url_m,owner_name&per_page=%@&format=json&nojsoncallback=1",baseURL,flickrAPIKey,imagesPerRequest] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *response) {
        
            if([[response objectForKey:@"photos"] objectForKey:@"photo"]){
                NSArray *images = [[response objectForKey:@"photos"] objectForKey:@"photo"];
                
                NSMutableArray *imageObjectArray = [[NSMutableArray alloc]init];
                for (int i = 0; i < [images count]; i++) {
                    Image *image = [[Image alloc]init];
                    image.imageURL = [[images objectAtIndex:i] objectForKey:@"url_m"];
                    image.imageID  = @([[[images objectAtIndex:i] objectForKey:@"id"] intValue]);
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
                NSLog(@"loadPopularImages Error: Invalid Response - %@",response);
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"loadPopularImages Error: %@",error.description);
    }];
    
}

- (void)getCommentsForPhotoId:(int)photoId
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@method=flickr.photos.comments.getList&api_key=%@&photo_id=%d&format=json&nojsoncallback=1",baseURL,flickrAPIKey,photoId] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *response) {
        
        if([[response objectForKey:@"comments"] objectForKey:@"comment"]){
            NSArray *comments = [[response objectForKey:@"comments"] objectForKey:@"comment"];
            
            
            NSMutableArray *commentObjectArray = [[NSMutableArray alloc]init];
            for (int i = 0; i < [comments count]; i++) {
                Comment *comment = [[Comment alloc]init];
                
                

//                if(image.imageURL){
//                    [imageObjectArray addObject:image];
//                }
            }
            
            if ([self.delegate respondsToSelector:@selector(commentsReturned:)]){
                [self.delegate commentsReturned:commentObjectArray];
            }
        } else {
            NSLog(@"loadPopularImages Error: Invalid Response - %@",response);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"loadPopularImages Error: %@",error.description);
    }];
}

@end
