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

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self != nil) {
		_delegate = nil;
		_roundedRect = nil;
		_closeButton = nil;
		_actionButton = nil;
		_contentView = nil;
		_startEndPoint = CGPointZero;
		
		_margin = UIEdgeInsetsMake(DEFAULT_MARGIN, DEFAULT_MARGIN, DEFAULT_MARGIN, DEFAULT_MARGIN);
		_padding = UIEdgeInsetsMake(DEFAULT_MARGIN, DEFAULT_MARGIN, DEFAULT_MARGIN, DEFAULT_MARGIN);
		_cornerRadius = DEFAULT_CORNER_RADIUS;
		_borderWidth = DEFAULT_BORDER_WIDTH;
		_borderColor = DEFAULT_BORDER_COLOR;
		_contentColor = DEFAULT_BACKGROUND_COLOR;
		_shouldBounce = DEFAULT_BOUNCE;
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		self.autoresizesSubviews = YES;
		
		_contentContainer = [[UIView alloc] initWithFrame:self.bounds];
		_contentContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		_contentContainer.autoresizesSubviews = YES;
		[self addSubview:_contentContainer];
		
		[self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]]; // Fixed value, the bacground mask.
				
		[_contentView setBackgroundColor:[UIColor clearColor]];
	
		self.tag = (arc4random() % 32768);
		
	}
	return self;
}

#pragma mark - Description

- (NSString *)description {
	return [NSString stringWithFormat:@"<%@ %d>", [[self class] description], self.tag];
}

#pragma mark - Accessors

- (void)setCornerRadius:(CGFloat)newRadius {
	_cornerRadius = newRadius;
	self.roundedRect.layer.cornerRadius = self.cornerRadius;
}
- (void)setBorderWidth:(CGFloat)newWidth {
	_borderWidth = newWidth;
	self.roundedRect.layer.borderWidth = self.borderWidth;
}
- (void)setBorderColor:(UIColor *)newColor {
	_borderColor = newColor;
	self.roundedRect.layer.borderColor = [self.borderColor CGColor];
}
- (void)setContentColor:(UIColor *)newColor {
	_contentColor = newColor;
	self.roundedRect.backgroundColor = self.contentColor;
}

- (UIView *)roundedRect {
	if (!_roundedRect) {
		_roundedRect = [[UIView alloc] initWithFrame:CGRectZero];
		_roundedRect.layer.masksToBounds = YES;
		_roundedRect.backgroundColor = self.contentColor;
		_roundedRect.layer.borderColor = [self.borderColor CGColor];
		_roundedRect.layer.borderWidth = self.borderWidth;
		_roundedRect.layer.cornerRadius = self.cornerRadius;

		[self.contentContainer insertSubview:_roundedRect atIndex:0];
	}
	return _roundedRect;
}
- (UIButton*)closeButton {
	if (!_closeButton) {
		_closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
		[_closeButton setFrame:CGRectMake(0, 0, 44, 44)];
		_closeButton.layer.shadowColor = [[UIColor blackColor] CGColor];
		_closeButton.layer.shadowOffset = CGSizeMake(0,4);
		_closeButton.layer.shadowOpacity = 0.3;
		
		[_closeButton addTarget:self action:@selector(closePressed:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentContainer insertSubview:_closeButton aboveSubview:self.contentView];
	}
	return _closeButton;
}

- (UIButton*)actionButton {
	if (!_actionButton) {
		UIImage *image = [UIImage imageNamed:@"modalButton.png"];
		UIImage *stretch = (([UIImage respondsToSelector:@selector(resizableImageWithCapInsets:)]) ?
				    [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width/2.0, 0, image.size.width/2.0)] :
				    [image stretchableImageWithLeftCapWidth:image.size.width/2.0 topCapHeight:image.size.width/2.0]);
		UIImage *image2 = [UIImage imageNamed:@"modalButton-selected.png"];
		UIImage *stretch2 = (([UIImage respondsToSelector:@selector(resizableImageWithCapInsets:)]) ?
				     [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(0, image2.size.width/2.0, 0, image2.size.width/2.0)] :
				     [image stretchableImageWithLeftCapWidth:image2.size.width/2.0 topCapHeight:image2.size.width/2.0]);
		_actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_actionButton setBackgroundImage:stretch forState:UIControlStateNormal];
		[_actionButton setBackgroundImage:stretch2 forState:UIControlStateHighlighted];
		_actionButton.layer.shadowColor = [[UIColor blackColor] CGColor];
		_actionButton.layer.shadowOffset = CGSizeMake(0,4);
		_actionButton.layer.shadowOpacity = 0.3;
		_actionButton.titleLabel.font = [UIFont boldSystemFontOfSize:11];
		[_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_actionButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
		_actionButton.contentEdgeInsets = UIEdgeInsetsMake(4, 8, 4, 8);
		
		[_actionButton addTarget:self action:@selector(actionPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentContainer insertSubview:_actionButton aboveSubview:self.contentView];
	}
	return _actionButton;
}

- (UIView *)contentView {
	if (!_contentView) {
		_contentView = [[UIView alloc] initWithFrame:CGRectZero];
		_contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		_contentView.autoresizesSubviews = YES;
		[self.contentContainer insertSubview:_contentView aboveSubview:self.roundedRect];
	}
	return _contentView;
}

- (CGRect)roundedRectFrame {

	return CGRectMake(self.margin.left + self.frame.origin.x,
					  self.margin.top + self.frame.origin.y,
					  self.frame.size.width - self.margin.left - self.margin.right,
					  self.frame.size.height - self.margin.top - self.margin.bottom);
}

- (CGRect)closeButtonFrame {
	CGRect f = [self roundedRectFrame];
	return CGRectMake(f.origin.x - floor(self.closeButton.frame.size.width*0.5),
					  f.origin.y - floor(self.closeButton.frame.size.height*0.5),
					  self.closeButton.frame.size.width,
					  self.closeButton.frame.size.height);
}

- (CGRect)actionButtonFrame {
	if (![[self.actionButton titleForState:UIControlStateNormal] length])
		return CGRectZero;
	
	[self.actionButton sizeToFit];
	CGRect f = [self roundedRectFrame];
	return CGRectMake(f.origin.x + f.size.width - self.actionButton.frame.size.width + 11,
					  f.origin.y - floor(self.actionButton.frame.size.height*0.5),
					  self.actionButton.frame.size.width,
					  self.actionButton.frame.size.height);
}

- (CGRect)contentViewFrame {
	CGRect roundedRectFrame = [self roundedRectFrame];
	return CGRectMake(self.padding.left + roundedRectFrame.origin.x,
					  self.padding.top + roundedRectFrame.origin.y,
					  roundedRectFrame.size.width - self.padding.left - self.padding.right,
					  roundedRectFrame.size.height - self.padding.top - self.padding.bottom);
}


- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.roundedRect.frame	= [self roundedRectFrame];
	self.closeButton.frame	= [self closeButtonFrame];
	self.actionButton.frame	= [self actionButtonFrame];
	self.contentView.frame	= [self contentViewFrame];
	
	UADebugLog(@"roundedRect frame: %@", NSStringFromCGRect(self.roundedRect.frame));
	UADebugLog(@"contentView frame: %@", NSStringFromCGRect(self.contentView.frame));
}

- (void)closePressed:(id)sender {
	
	// Using Delegates
	if ([self.delegate respondsToSelector:@selector(shouldCloseModalPanel:)]) {
		if ([self.delegate shouldCloseModalPanel:self]) {
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

- (void)actionPressed:(id)sender {
	
	// Using Delegates
	if ([self.delegate respondsToSelector:@selector(didSelectActionButton:)]) {
		[self.delegate didSelectActionButton:self];
		
		
		// Using blocks
	} else if (self.onActionPressed) {
		UADebugLog(@"Action pressed using blocks for modalPanel: %@", self);
		self.onActionPressed(self);
		
		// No delegate or blocks. Do nothing!
	} else {
		// no-op
	}
}

- (void)showAnimationStarting {};		//subclasses override
- (void)showAnimationPart1Finished {};	//subclasses override
- (void)showAnimationPart2Finished {};	//subclasses override
- (void)showAnimationPart3Finished {};	//subclasses override
- (void)showAnimationFinished {};		//subclasses override
- (void)show {
	
	if ([self.delegate respondsToSelector:@selector(willShowModalPanel:)])
		[self.delegate willShowModalPanel:self];
	
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
																	   if ([self.delegate respondsToSelector:@selector(didShowModalPanel:)])
																		   [self.delegate didShowModalPanel:self];
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
						 self.contentContainer.transform = CGAffineTransformMakeScale((self.shouldBounce ? 1.05 : 1.0), (self.shouldBounce ? 1.05 : 1.0));
					 }
					 completion:(self.shouldBounce ? animationBlock : ^(BOOL finished) {
						[self showAnimationFinished];
						if ([self.delegate respondsToSelector:@selector(didShowModalPanel:)])
							[self.delegate didShowModalPanel:self];
					})];

}
- (void)showFromPoint:(CGPoint)point {
	self.startEndPoint = point;
	self.contentContainer.center = point;
	[self show];
}

- (void)hide {	
	// Hide the view right away
	if ([self.delegate respondsToSelector:@selector(willCloseModalPanel:)])
		[self.delegate willCloseModalPanel:self];
	
    [UIView animateWithDuration:0.3
					 animations:^{
						 self.alpha = 0;
						 if (self.startEndPoint.x != CGPointZero.x || self.startEndPoint.y != CGPointZero.y) {
							 self.contentContainer.center = self.startEndPoint;
						 }
						 self.contentContainer.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
					 }
					 completion:^(BOOL finished){
						 if ([self.delegate respondsToSelector:@selector(didCloseModalPanel:)]) {
							 [self.delegate didCloseModalPanel:self];
						 }
						 [self removeFromSuperview];
					 }];
}


- (void)hideWithOnComplete:(UAModalDisplayPanelAnimationComplete)onComplete {	
	// Hide the view right away
    [UIView animateWithDuration:0.3
					 animations:^{
						 self.alpha = 0;
						 if (self.startEndPoint.x != CGPointZero.x || self.startEndPoint.y != CGPointZero.y) {
							 self.contentContainer.center = self.startEndPoint;
						 }
						 self.contentContainer.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
					 }
					 completion:^(BOOL finished){
						 if (onComplete)
                             onComplete(finished);
					 }];
}

@end
