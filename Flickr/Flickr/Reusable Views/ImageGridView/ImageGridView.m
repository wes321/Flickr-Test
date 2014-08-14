//
//  ImageGridView.m
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import "ImageGridView.h"
#import "ImageGridCell.h"

static NSString * const imageCellIdentifier = @"ImageGridCell";


@interface ImageGridView ()  <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
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


- (void)awakeFromNib
{
    [self.imageCollectionView registerNib:[UINib nibWithNibName:imageCellIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:imageCellIdentifier];
    
    self.imagesArray = [[NSArray alloc]init];
    
    if(!self.refreshControl){
        self.refreshControl = [[UIRefreshControl alloc]init];
        [self.imageCollectionView addSubview:self.refreshControl];
        
        [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    }
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

- (void)refreshTable {
    //TODO: refresh your data
    [self.refreshControl endRefreshing];
    
    if ([self.delegate respondsToSelector:@selector(refreshCollectionView)])
    {
        [self.delegate refreshCollectionView];
    }

}

- (void)setImagesArray:(NSArray *)imagesArray
{
    _imagesArray = imagesArray;
    [self.activityIndicator stopAnimating];
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
    ImageGridCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCellIdentifier
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
