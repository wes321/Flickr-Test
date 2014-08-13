//
//  ImageGridCell.h
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import "Image.h"

@interface ImageGridCell : UICollectionViewCell
@property (strong, nonatomic) Image *image;
- (void)toggleDetailsView;
@end