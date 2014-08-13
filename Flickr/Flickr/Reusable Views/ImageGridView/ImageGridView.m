//
//  ImageGridView.m
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import "ImageGridView.h"
#import "ImageGridCell.h"

static NSString * const ImageCellIdentifier = @"ImageGridCell";


@interface ImageGridView ()  <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@end

@implementation ImageGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [self.imageCollectionView registerNib:[UINib nibWithNibName:ImageCellIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ImageCellIdentifier];
    
    self.imagesArray = [[NSArray alloc]init];
     
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    if(self.subviews.count==0)
    {
        ImageGridView *theView = [[self class] loadFromNib];
        theView.frame = self.frame;
        theView.autoresizingMask = self.autoresizingMask;
        [theView awakeFromNib];
        return theView;
    }
    return self;
}

- (void)setImagesArray:(NSArray *)imagesArray
{
    _imagesArray = imagesArray;
    [self.imageCollectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imagesArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageGridCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCellIdentifier
                                              forIndexPath:indexPath];
    
    imageCell.image = [self.imagesArray objectAtIndex:indexPath.item];
    
    return imageCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageGridCell *imageCell = (ImageGridCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [imageCell toggleDetailsView];
}

@end
