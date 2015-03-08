//
//  UAGradientBackground.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UAGradientBackgroundStyle) {
	UAGradientBackgroundStyleRadial = 0,
	UAGradientBackgroundStyleRadialReversed,
	UAGradientBackgroundStyleLinear,
	UAGradientBackgroundStyleLinearReversed,
	UAGradientBackgroundStyleCenterHighlight,
} ;

typedef NS_OPTIONS(NSUInteger, UAGradientLineMode) {
	UAGradientLineModeNone = 0,
	UAGradientLineModeTop = 2,
	UAGradientLineModeBottom = 4,
	UAGradientLineModeTopAndBottom = 8
} ;

@interface UAGradientBackground : UIView {
	UAGradientBackgroundStyle	gradientStyle;
	UAGradientLineMode			lineMode;
	CGFloat						*colorComponents;
}

@property (nonatomic, assign) UAGradientBackgroundStyle	gradientStyle;
@property (nonatomic, assign) UAGradientLineMode		lineMode;

- (instancetype)initWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle color:(CGFloat *)components lineMode:(UAGradientLineMode)lineModes NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame color:(CGFloat *)components;
- (instancetype)initWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle;
- (instancetype)initWithFrame:(CGRect)frame;

- (void)setColorComponents:(CGFloat *)components;

+ (id)gradientWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle color:(CGFloat *)components lineMode:(UAGradientLineMode)lineModes;
+ (id)gradientWithFrame:(CGRect)frame color:(CGFloat *)components;
+ (id)gradientWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle;
+ (id)gradientWithFrame:(CGRect)frame;
@end
