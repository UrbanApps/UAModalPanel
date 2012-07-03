//  Created by Jason Morrissey

#import "UIView+JMNoise.h"
#include <stdlib.h>

#define kNoiseTileDimension 50
#define kNoiseIntensity 250
#define kNoiseDefaultOpacity 0.4
#define kNoisePixelWidth 0.3

#define JM_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#pragma Mark -
#pragma Mark - Noise Layer

@implementation NoiseLayer

static UIImage * JMNoiseImage;

- (void)setFrame:(CGRect)frame;
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

+ (void)drawPixelInContext:(CGContextRef)context point:(CGPoint)point width:(CGFloat)width opacity:(CGFloat)opacity whiteLevel:(CGFloat)whiteLevel;
{
    CGColorRef fillColor = [UIColor colorWithWhite:whiteLevel alpha:opacity].CGColor;
    CGContextSetFillColor(context, CGColorGetComponents(fillColor));
    CGRect pointRect = CGRectMake(point.x - (width/2), point.y - (width/2), width, width);
    CGContextFillEllipseInRect(context, pointRect);
}

+ (UIImage *)noiseTileImage;
{
    if (!JMNoiseImage)
    {
        #ifndef __clang_analyzer__
        CGFloat imageScale;
        
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        {
            imageScale = [[UIScreen mainScreen] scale];
        }
        else 
        {
            imageScale = 1;
        }

        NSUInteger imageDimension = imageScale * kNoiseTileDimension;

        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(nil,imageDimension,imageDimension,8,0,
                                                     colorSpace,kCGImageAlphaPremultipliedLast);
        CFRelease(colorSpace);

        for (int i=0; i<(kNoiseTileDimension * kNoiseIntensity); i++)
        {
            int x = arc4random() % (imageDimension + 1);
            int y = arc4random() % (imageDimension + 1);
            int opacity = arc4random() % 100;
            CGFloat whiteLevel = arc4random() % 100;
            [NoiseLayer drawPixelInContext:context point:CGPointMake(x, y) width:(kNoisePixelWidth * imageScale) opacity:(opacity) whiteLevel:(whiteLevel / 100.)];
        }

        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        if (JM_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"4.0"))
        {
            JMNoiseImage = [[UIImage alloc] initWithCGImage:imageRef scale:imageScale orientation:UIImageOrientationUp];
        }
        else
        {
            JMNoiseImage = [[UIImage alloc] initWithCGImage:imageRef];
        }
        #endif
    }
    return JMNoiseImage;
}

- (void)drawInContext:(CGContextRef)ctx;
{
    UIGraphicsPushContext(ctx);
    [[NoiseLayer noiseTileImage] drawAsPatternInRect:self.bounds];
    UIGraphicsPopContext();
}

@end

#pragma Mark -
#pragma Mark - UIView implementations

@implementation UIView (JMNoise)

- (void)applyNoise;
{
    [self applyNoiseWithOpacity:kNoiseDefaultOpacity];
}

- (void)applyNoiseWithOpacity:(CGFloat)opacity atLayerIndex:(NSUInteger) layerIndex;
{
    NoiseLayer * noiseLayer = [[[NoiseLayer alloc] init] autorelease];
    [noiseLayer setFrame:self.bounds];
    noiseLayer.masksToBounds = YES;
    noiseLayer.opacity = opacity;
    [self.layer insertSublayer:noiseLayer atIndex:layerIndex];
}

- (void)applyNoiseWithOpacity:(CGFloat)opacity;
{
    [self applyNoiseWithOpacity:opacity atLayerIndex:0];
}

- (void)drawCGNoise;
{
    [self drawCGNoiseWithOpacity:kNoiseDefaultOpacity];
}

- (void)drawCGNoiseWithOpacity:(CGFloat)opacity;
{
    [self drawCGNoiseWithOpacity:opacity blendMode:kCGBlendModeNormal];
}

- (void)drawCGNoiseWithOpacity:(CGFloat)opacity blendMode:(CGBlendMode)blendMode;
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);    
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:self.bounds];
    CGContextAddPath(context, [path CGPath]);
    CGContextClip(context);
    CGContextSetBlendMode(context, blendMode);
    CGContextSetAlpha(context, opacity);
    [[NoiseLayer noiseTileImage] drawAsPatternInRect:self.bounds];
    CGContextRestoreGState(context);    
}

@end
