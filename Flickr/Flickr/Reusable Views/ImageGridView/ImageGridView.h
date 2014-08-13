//
//  ImageGridView.h
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import <UIKit/UIKit.h>


@protocol ImageGridViewDelegate <NSObject>
- (void)refreshCollectionView;
@end

@interface ImageGridView : UIView
@property (strong, nonatomic) NSArray *imagesArray;
@property (weak,nonatomic) id<ImageGridViewDelegate> delegate;

@end