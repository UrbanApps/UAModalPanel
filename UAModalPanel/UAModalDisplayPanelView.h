//
//  UAModalDisplayPanelView.h
//  Ambiance
//
//  Created by Matt Coneybeare on 3/6/10.
//  Copyright 2010 Urban Apps LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UARoundedRectView.h"

@interface UAModalDisplayPanelView : UIView {	
	id			delegate;
	
	UIView		*contentContainer;
	UIView		*roundedRect;
	UIButton	*closeButton;
	UIView		*contentView;
	
	CGFloat		margin;
	
	CGPoint		startEndPoint;
	
	CGRect		innerFrame;
	
	BOOL		shouldBounce;
	
}

@property (nonatomic, assign) id			delegate;
@property (nonatomic, retain) UIView		*contentContainer;
@property (nonatomic, retain) UIView		*roundedRect;
@property (nonatomic, retain) UIButton		*closeButton;
@property (nonatomic, retain) UIView		*contentView;
@property (nonatomic, assign) CGFloat		margin;
@property (nonatomic, assign) BOOL			shouldBounce;

- (void)show;
- (void)showFromPoint:(CGPoint)point;
- (void)hideWithDelegate:(id)del selector:(SEL)sel;

- (CGRect)roundedRectFrame;
- (CGRect)closeButtonFrame;
- (CGRect)contentViewFrame;

@end
