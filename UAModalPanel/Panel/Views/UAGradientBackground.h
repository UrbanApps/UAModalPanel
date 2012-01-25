//
//  UAGradientBackground.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	UAGradientBackgroundStyleRadial = 0,
	UAGradientBackgroundStyleRadialReversed,
	UAGradientBackgroundStyleLinear,
	UAGradientBackgroundStyleLinearReversed,
	UAGradientBackgroundStyleCenterHighlight,
} UAGradientBackgroundStyle;

typedef enum {
	UAGradientLineModeNone = 0,
	UAGradientLineModeTop = 2,
	UAGradientLineModeBottom = 4,
	UAGradientLineModeTopAndBottom = 8
} UAGradientLineMode;

@interface UAGradientBackground : UIView {
	UAGradientBackgroundStyle	gradientStyle;
	UAGradientLineMode			lineMode;
	CGFloat						*colorComponents;
}

@property (nonatomic, assign) UAGradientBackgroundStyle	gradientStyle;
@property (nonatomic, assign) UAGradientLineMode		lineMode;

- (id)initWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle color:(CGFloat *)components lineMode:(UAGradientLineMode)lineModes;
- (id)initWithFrame:(CGRect)frame color:(CGFloat *)components;
- (id)initWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle;
- (id)initWithFrame:(CGRect)frame;

- (void)setColorComponents:(CGFloat *)components;

+ (id)gradientWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle color:(CGFloat *)components lineMode:(UAGradientLineMode)lineModes;
+ (id)gradientWithFrame:(CGRect)frame color:(CGFloat *)components;
+ (id)gradientWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle;
+ (id)gradientWithFrame:(CGRect)frame;
@end
