//
//  UARoundedRectView.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UARoundedRectView : UIView {
	NSInteger	radius;
	CGFloat		*colorComponents;
}

@property (nonatomic, assign) NSInteger	radius;

- (void)setColors:(CGFloat *)components;

@end
