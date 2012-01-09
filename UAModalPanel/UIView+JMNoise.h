//  Created by Jason Morrissey

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
