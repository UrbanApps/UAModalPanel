//
//  UARoundedRectView.h
//  Ambiance
//
//  Created by Matt Coneybeare on 3/6/10.
//  Copyright 2010 Urban Apps LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UARoundedRectView : UIView {
	NSInteger	radius;
	CGFloat		*colorComponents;
}

@property (nonatomic, assign) NSInteger	radius;

- (void)setColors:(CGFloat *)components;

@end
