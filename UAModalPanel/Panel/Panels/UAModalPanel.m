//
//  UACategoryDetailsViewController.m
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "UAModalPanel.h"
#import "UARoundedRectView.h"

#define DEFAULT_MARGIN				20.0f
#define DEFAULT_BACKGROUND_COLOR	[UIColor colorWithWhite:0.0 alpha:0.8]
#define DEFAULT_CORNER_RADIUS		4.0f
#define DEFAULT_BORDER_WIDTH		1.5f
#define DEFAULT_BORDER_COLOR		[UIColor whiteColor]
#define DEFAULT_BOUNCE				YES

@implementation UAModalPanel

@synthesize roundedRect, closeButton, delegate, contentView, contentContainer;
@synthesize innerMargin, outerMargin, cornerRadius, borderWidth, borderColor, contentColor, shouldBounce;
@synthesize onClosePressed;


- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self != nil) {
		delegate = nil;
		roundedRect = nil;
		closeButton = nil;
		contentView = nil;
		startEndPoint = CGPointZero;
		
		outerMargin = DEFAULT_MARGIN;
		innerMargin = DEFAULT_MARGIN;
		cornerRadius = DEFAULT_CORNER_RADIUS;
		borderWidth = DEFAULT_BORDER_WIDTH;
		borderColor = [DEFAULT_BORDER_COLOR retain];
		contentColor = [DEFAULT_BACKGROUND_COLOR retain];
		shouldBounce = DEFAULT_BOUNCE;
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		self.autoresizesSubviews = YES;
		
		self.contentContainer = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
		self.contentContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		self.contentContainer.autoresizesSubviews = YES;
		[self addSubview:self.contentContainer];
		
		[self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]]; // Fixed value, the bacground mask.
				
		[self.contentView setBackgroundColor:[UIColor clearColor]];
		self.delegate = nil;
	
		self.tag = (arc4random() % 32768);
		
	}
	return self;
}

- (void)dealloc {
	self.roundedRect = nil;
	self.closeButton = nil;
	self.contentContainer = nil;
	self.borderColor = nil;
	self.contentColor = nil;
	delegate = nil;
	[super dealloc];
}

#pragma mark - Description

- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %d>", [[self class] description], self.tag];
}

#pragma mark - Accessors

- (void)setCornerRadius:(CGFloat)newRadius {
	cornerRadius = newRadius;
	self.roundedRect.layer.cornerRadius = cornerRadius;
}
- (void)setBorderWidth:(CGFloat)newWidth {
	borderWidth = newWidth;
	self.roundedRect.layer.borderWidth = borderWidth;
}
- (void)setBorderColor:(UIColor *)newColor {
	[newColor retain];
	[borderColor release];
	borderColor = newColor;
	
	self.roundedRect.layer.borderColor = [borderColor CGColor];
}
- (void)setContentColor:(UIColor *)newColor {
	[newColor retain];
	[contentColor release];
	contentColor = newColor;
	
	self.roundedRect.backgroundColor = contentColor;
}

- (UIView *)roundedRect {
	if (!roundedRect) {
		self.roundedRect = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
		roundedRect.layer.masksToBounds = YES;
		roundedRect.backgroundColor = self.contentColor;
		roundedRect.layer.borderColor = [self.borderColor CGColor];
		roundedRect.layer.borderWidth = self.borderWidth;
		roundedRect.layer.cornerRadius = self.cornerRadius;

		[self.contentContainer insertSubview:roundedRect atIndex:0];
	}
	return roundedRect;
}
- (UIButton*)closeButton {
	if (!closeButton) {
		self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
		[self.closeButton setFrame:CGRectMake(0, 0, 44, 44)];
		self.closeButton.layer.shadowColor = [[UIColor blackColor] CGColor];
		self.closeButton.layer.shadowOffset = CGSizeMake(0,4);
		self.closeButton.layer.shadowOpacity = 0.3;
		
		[closeButton addTarget:self action:@selector(closePressed:) forControlEvents:UIControlEventTouchUpInside];		
		[self.contentContainer insertSubview:closeButton aboveSubview:self.roundedRect];
	}
	return closeButton;
}
- (UIView *)contentView {
	if (!contentView) {
		self.contentView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
		self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		self.contentView.autoresizesSubviews = YES;
		[self.contentContainer addSubview:contentView];
	}
	return contentView;
}

- (CGRect)roundedRectFrame {

	return CGRectMake(self.outerMargin + self.frame.origin.x,
					  self.outerMargin + self.frame.origin.y,
					  self.frame.size.width - 2*self.outerMargin,
					  self.frame.size.height - 2*self.outerMargin);
}

- (CGRect)closeButtonFrame {
	CGRect f = [self roundedRectFrame];
	return CGRectMake(f.origin.x - floor(closeButton.frame.size.width*0.5),
					  f.origin.y - floor(closeButton.frame.size.height*0.5),
					  closeButton.frame.size.width,
					  closeButton.frame.size.height);
}

- (CGRect)contentViewFrame {
	CGRect rect = CGRectInset([self roundedRectFrame], self.innerMargin, self.innerMargin);
	return rect;
}


- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.roundedRect.frame = [self roundedRectFrame];
	self.closeButton.frame = [self closeButtonFrame];
	self.contentView.frame = [self contentViewFrame];
	
//	UADebugLog(@"roundedRect frame: %@", NSStringFromCGRect(self.roundedRect.frame));
//	UADebugLog(@"contentView frame: %@", NSStringFromCGRect(self.contentView.frame));
}

- (void)closePressed:(id)sender {
	
	// Using Delegates
	if ([delegate respondsToSelector:@selector(shouldCloseModalPanel:)]) {
		if ([delegate shouldCloseModalPanel:self]) {
			UADebugLog(@"Closing using delegates for modalPanel: %@", self);
			[self hide];
		}
		
	
	// Using blocks
	} else if (self.onClosePressed) {
		UADebugLog(@"Closing using blocks for modalPanel: %@", self);
		self.onClosePressed(self);
		
	// No delegate or blocks. Just close myself
	} else {
		UADebugLog(@"Closing modalPanel: %@", self);
		[self hide];
	}
}

- (void)showAnimationStarting {};		//subcalsses override
- (void)showAnimationPart1Finished {};	//subcalsses override
- (void)showAnimationPart2Finished {};	//subcalsses override
- (void)showAnimationPart3Finished {};	//subcalsses override
- (void)showAnimationFinished {};		//subcalsses override
- (void)show {
	
	if ([delegate respondsToSelector:@selector(willShowModalPanel:)])
		[delegate willShowModalPanel:self];
	
	[self showAnimationStarting];
	self.alpha = 0.0;
	self.contentContainer.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
	
	
	void (^animationBlock)(BOOL) = ^(BOOL finished) {
		[self showAnimationPart1Finished];
		// Wait one second and then fade in the view
		[UIView animateWithDuration:0.1
						 animations:^{
							 self.contentContainer.transform = CGAffineTransformMakeScale(0.95, 0.95);
						 }
						 completion:^(BOOL finished){
							 
							 [self showAnimationPart2Finished];
							 // Wait one second and then fade in the view
							 [UIView animateWithDuration:0.1
											  animations:^{
												  self.contentContainer.transform = CGAffineTransformMakeScale(1.02, 1.02);
											  }
											  completion:^(BOOL finished){
												  
												  [self showAnimationPart3Finished];
												  // Wait one second and then fade in the view
												  [UIView animateWithDuration:0.1
																   animations:^{
																	   self.contentContainer.transform = CGAffineTransformIdentity;
																   }
																   completion:^(BOOL finished){
																	   [self showAnimationFinished];
																	   if ([delegate respondsToSelector:@selector(didShowModalPanel:)])
																		   [delegate didShowModalPanel:self];
																   }];
											  }];
						 }];
	};
	
	// Show the view right away
    [UIView animateWithDuration:0.3
						  delay:0.0
						options:UIViewAnimationCurveEaseOut
					 animations:^{
						 self.alpha = 1.0;
						 self.contentContainer.center = self.center;
						 self.contentContainer.transform = CGAffineTransformMakeScale((shouldBounce ? 1.05 : 1.0), (shouldBounce ? 1.05 : 1.0));
					 }
					 completion:(shouldBounce ? animationBlock : ^(BOOL finished) {
						[self showAnimationFinished];
						if ([delegate respondsToSelector:@selector(didShowModalPanel:)])
							[delegate didShowModalPanel:self];
					})];

}
- (void)showFromPoint:(CGPoint)point {
	startEndPoint = point;
	self.contentContainer.center = point;
	[self show];
}

- (void)hide {	
	// Hide the view right away
	if ([delegate respondsToSelector:@selector(willCloseModalPanel:)])
		[delegate willCloseModalPanel:self];
	
    [UIView animateWithDuration:0.3
					 animations:^{
						 self.alpha = 0;
						 if (startEndPoint.x != CGPointZero.x || startEndPoint.y != CGPointZero.y) {
							 self.contentContainer.center = startEndPoint;
						 }
						 self.contentContainer.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
					 }
					 completion:^(BOOL finished){
						 if ([delegate respondsToSelector:@selector(didCloseModalPanel:)]) {
							 [delegate didCloseModalPanel:self];
						 }
						 [self removeFromSuperview];
					 }];
}


- (void)hideWithOnComplete:(UAModalDisplayPanelAnimationComplete)onComplete {	
	// Hide the view right away
    [UIView animateWithDuration:0.3
					 animations:^{
						 self.alpha = 0;
						 if (startEndPoint.x != CGPointZero.x || startEndPoint.y != CGPointZero.y) {
							 self.contentContainer.center = startEndPoint;
						 }
						 self.contentContainer.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
					 }
					 completion:^(BOOL finished){
						 if (onComplete)
                             onComplete(finished);
					 }];
}


@end
