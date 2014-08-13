//
//  UIView+Additions.m
//  Flickr
//
//  Created by Wesley Lorenzini on 8/12/14.
//
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

+ (id) loadFromNib {
	NSString* nibName = NSStringFromClass([self class]);
	NSArray* elements = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
	for (NSObject* anObject in elements) {
		if ([anObject isKindOfClass:[self class]]) {
			return anObject;
		}
	}
	return nil;
}

@end