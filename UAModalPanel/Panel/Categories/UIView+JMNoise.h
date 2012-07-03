//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NoiseLayer : CALayer
+ (UIImage *)noiseTileImage;
+ (void)drawPixelInContext:(CGContextRef)context point:(CGPoint)point width:(CGFloat)width opacity:(CGFloat)opacity whiteLevel:(CGFloat)whiteLevel;
@end

@interface UIView (JMNoise)

// Can be used directly on UIView
- (void)applyNoise;
- (void)applyNoiseWithOpacity:(CGFloat)opacity atLayerIndex:(NSUInteger) layerIndex;
- (void)applyNoiseWithOpacity:(CGFloat)opacity;

// Can be invoked from a drawRect() method
- (void)drawCGNoise;
- (void)drawCGNoiseWithOpacity:(CGFloat)opacity;
- (void)drawCGNoiseWithOpacity:(CGFloat)opacity blendMode:(CGBlendMode)blendMode;

@end
