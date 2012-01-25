//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

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
