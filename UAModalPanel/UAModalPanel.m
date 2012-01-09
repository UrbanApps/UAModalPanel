//
//  UACategoryDetailsViewController.m
//  Ambiance
//
//  Created by Matt Coneybeare on 3/6/10.
//  Copyright 2010 Urban Apps LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "UAModalPanel.h"
#import "UARoundedRectView.h"

#define DEFAULT_MARGIN	20


@implementation UAModalPanel

@synthesize roundedRect, closeButton, delegate, contentView, contentContainer, shouldBounce, margin;

- (void)calculateInnerFrame {
	//adjust the popup frame for iPad if it is too big.
	innerFrame = self.frame;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self calculateInnerFrame];
		delegate = nil;
		roundedRect = nil;
		closeButton = nil;
		contentView = nil;
		startEndPoint = CGPointZero;
		
		self.contentContainer = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
		self.contentContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		self.contentContainer.autoresizesSubviews = YES;
		[self addSubview:self.contentContainer];
		
		[self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
		self.roundedRect.hidden = NO;  // init.
		self.closeButton.hidden = NO; // init.
		[self.contentView setBackgroundColor:[UIColor clearColor]];
		self.delegate = nil;
		
		self.margin = DEFAULT_MARGIN;
		
		self.shouldBounce = YES;
		
	}
	return self;
}

- (void) dealloc {
	self.roundedRect = nil;
	self.closeButton = nil;
	self.contentContainer = nil;
	delegate = nil;
	[super dealloc];
}

- (UIView *)roundedRect {
	if (!roundedRect) {
		self.roundedRect = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
		roundedRect.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
		roundedRect.layer.cornerRadius = 4.0f;
		roundedRect.layer.masksToBounds = YES;
		roundedRect.layer.borderColor = [[UIColor whiteColor] CGColor];
		roundedRect.layer.borderWidth = 1.5f;

		[self.contentContainer addSubview:roundedRect];
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
		[self.contentContainer addSubview:closeButton];
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
	[self calculateInnerFrame];
	CGFloat x = (self.frame.origin.x + floor((self.frame.size.width - innerFrame.size.width)/2));
	CGFloat y = (self.frame.origin.y + floor((self.frame.size.height - innerFrame.size.height)/2));
	return CGRectMake(x + margin,
					  y + margin,
					  innerFrame.size.width - 2*margin,
					  innerFrame.size.height - 2*margin);
}

- (CGRect)closeButtonFrame {
	CGRect f = [self roundedRectFrame];
	return CGRectMake(f.origin.x - floor(closeButton.frame.size.width*0.5),
					  f.origin.y - floor(closeButton.frame.size.height*0.5),
					  closeButton.frame.size.width,
					  closeButton.frame.size.height);
}

- (CGRect)contentViewFrame {
	CGRect rect = CGRectInset([self roundedRectFrame], margin, margin);
	return rect;
}


- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.roundedRect.frame = [self roundedRectFrame];
	self.closeButton.frame = [self closeButtonFrame];
	self.contentView.frame = [self contentViewFrame];
	
//	DebugLog(@"roundedRect: %@", NSStringFromCGRect([self _roundedRectFrame]));
//	DebugLog(@"contentView: %@", NSStringFromCGRect([self _contentViewFrame]));
}

- (void)closePressed:(id)sender {
	//What now?
	if (delegate && [delegate respondsToSelector:@selector(removeModalView)]) {
		[delegate performSelector:@selector(removeModalView)];
	}
}

- (void)showAnimationStarting {};		//subcalsses override
- (void)showAnimationPart1Finished {};	//subcalsses override
- (void)showAnimationPart2Finished {};	//subcalsses override
- (void)showAnimationPart3Finished {};	//subcalsses override
- (void)showAnimationFinished {};		//subcalsses override
- (void)show {
	[self showAnimationStarting];
	self.alpha = 0.0;
	self.contentContainer.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
	
	
	void (^animationBlock)(BOOL) = ^(BOOL finished){
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
						 self.contentContainer.transform = CGAffineTransformMakeScale((shouldBounce?1.05:1.0), (shouldBounce?1.05:1.0));
					 }
					 completion:(shouldBounce ? animationBlock : ^(BOOL finished) {
						[self showAnimationFinished];
					})];

}
- (void)showFromPoint:(CGPoint)point {
	startEndPoint = point;
	self.contentContainer.center = point;
	[self show];
}

- (void)hideWithDelegate:(id)del selector:(SEL)sel {	
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
						 if ([del respondsToSelector:sel])
							 [del performSelector:sel];
					 }];
}


@end
