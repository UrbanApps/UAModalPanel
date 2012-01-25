//
//  UANoisyGradientBackground.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UAGradientBackground.h"

@interface UANoisyGradientBackground : UAGradientBackground {
	CGFloat		noiseOpacity;
	CGBlendMode	blendMode;
}

@property (nonatomic, assign) CGFloat		noiseOpacity;
@property (nonatomic, assign) CGBlendMode	blendMode;

- (id)initWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle color:(CGFloat *)components lineMode:(UAGradientLineMode)lineModes noiseOpacity:(CGFloat)opacity blendMode:(CGBlendMode)mode;
- (id)initWithFrame:(CGRect)frame noiseOpacity:(CGFloat)opacity;
- (id)initWithFrame:(CGRect)frame blendMode:(CGFloat)mode;

+ (id)gradientWithFrame:(CGRect)frame style:(UAGradientBackgroundStyle)aStyle color:(CGFloat *)components lineMode:(UAGradientLineMode)lineModes noiseOpacity:(CGFloat)opacity blendMode:(CGBlendMode)mode;
+ (id)gradientWithFrame:(CGRect)frame noiseOpacity:(CGFloat)opacity;
+ (id)gradientWithFrame:(CGRect)frame blendMode:(CGFloat)mode;

@end
