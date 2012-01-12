//
//  UANoisyGradientBackground.m
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import "UANoisyGradientBackground.h"
#import "UIView+JMNoise.h"

//#import <QuartzCore/QuartzCore.h>

#define NOISE_DEFAULT_OPACITY 0.4

@implementation UANoisyGradientBackground

@synthesize noiseOpacity, blendMode;


- (id)initWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle color:(CGFloat *)components lineMode:(UAGradientLineMode)lineModes noiseOpacity:(CGFloat)opacity blendMode:(CGBlendMode)mode {
	if ((self = [self initWithFrame:frame style:aStyle color:components lineMode:lineModes])) {
		self.noiseOpacity = opacity;
		self.blendMode = mode;
	}
	return self;
}
- (id)initWithFrame:(CGRect)frame noiseOpacity:(CGFloat)opacity {
	if (self = [self initWithFrame:frame]) {
		self.noiseOpacity = opacity;
	}
	return self;
}
- (id)initWithFrame:(CGRect)frame blendMode:(CGFloat)mode {
	if ((self = [self initWithFrame:frame])) {
		self.blendMode = blendMode;
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.noiseOpacity = NOISE_DEFAULT_OPACITY;
		self.blendMode = kCGBlendModeNormal;
    }
    return self;
}



+ (id)gradientWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle color:(CGFloat *)components lineMode:(UAGradientLineMode)lineModes noiseOpacity:(CGFloat)opacity blendMode:(CGBlendMode)mode {
	return  [[[UANoisyGradientBackground alloc] initWithFrame:frame
														style:aStyle
														color:components
													 lineMode:lineModes
												 noiseOpacity:opacity
													blendMode:mode] autorelease];
}
+ (id)gradientWithFrame:(CGRect)frame noiseOpacity:(CGFloat)noiseOpacity {
	return [[[UANoisyGradientBackground alloc] initWithFrame:frame noiseOpacity:noiseOpacity] autorelease];
}
+ (id)gradientWithFrame:(CGRect)frame blendMode:(CGFloat)mode {
	return [[[UANoisyGradientBackground alloc] initWithFrame:frame blendMode:mode] autorelease];
}



- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	[self drawCGNoiseWithOpacity:self.noiseOpacity blendMode:self.blendMode];
}

@end

