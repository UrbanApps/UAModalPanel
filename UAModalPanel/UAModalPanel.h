//
//  UAModalDisplayPanelView.h
//  Ambiance
//
//  Created by Matt Coneybeare on 3/6/10.
//  Copyright 2010 Urban Apps LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UARoundedRectView.h"

@class UAModalPanel;

typedef void (^UAModalDisplayPanelEvent)(UAModalPanel* panel);
typedef void (^UAModalDisplayPanelAnimationComplete)(BOOL finished);

@interface UAModalPanel : UIView {	
	id			delegate;
	
	UIView		*contentContainer;
	UIView		*roundedRect;
	UIButton	*closeButton;
	UIView		*contentView;
	
	CGPoint		startEndPoint;
	CGRect		innerFrame;
	
	CGFloat		outerMargin;
	CGFloat		innerMargin;
	UIColor		*borderColor;
	CGFloat		borderWidth;
	CGFloat		cornerRadius;
	UIColor		*contentColor;
	BOOL		shouldBounce;
	
}

@property (nonatomic, assign) id			delegate;
@property (nonatomic, retain) UIView		*contentContainer;
@property (nonatomic, retain) UIView		*roundedRect;
@property (nonatomic, retain) UIButton		*closeButton;
@property (nonatomic, retain) UIView		*contentView;

// Margin between edge of container frame and panel. Default = 20.0
@property (nonatomic, assign) CGFloat		outerMargin;
// Margin between edge of panel and the content area. Default = 20.0
@property (nonatomic, assign) CGFloat		innerMargin;
// Border color of the panel. Default = [UIColor whiteColor]
@property (nonatomic, retain) UIColor		*borderColor;
// Border width of the panel. Default = 1.5f
@property (nonatomic, assign) CGFloat		borderWidth;
// Corner radius of the panel. Default = 4.0f
@property (nonatomic, assign) CGFloat		cornerRadius;
// Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
@property (nonatomic, retain) UIColor		*contentColor;
// Shows the bounce animation. Default = YES
@property (nonatomic, assign) BOOL			shouldBounce;

@property (readwrite, copy) UAModalDisplayPanelEvent onClosePressed;

- (void)show;
- (void)showFromPoint:(CGPoint)point;
- (void)hideWithDelegate:(id)del selector:(SEL)sel;
- (void)hideWithOnComplete:(UAModalDisplayPanelAnimationComplete)onComplete;

- (CGRect)roundedRectFrame;
- (CGRect)closeButtonFrame;
- (CGRect)contentViewFrame;

@end
