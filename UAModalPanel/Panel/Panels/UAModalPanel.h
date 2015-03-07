//
//  UAModalDisplayPanelView.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UARoundedRectView.h"

// Logging Helpers
#ifdef UAMODALVIEW_DEBUG
#define UADebugLog( s, ... ) NSLog( @"<%@:%d> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define UADebugLog( s, ... ) 
#endif

@class UAModalPanel;

@protocol UAModalPanelDelegate
@optional
- (void)willShowModalPanel:(UAModalPanel *)modalPanel;
- (void)didShowModalPanel:(UAModalPanel *)modalPanel;
- (void)didSelectActionButton:(UAModalPanel *)modalPanel;
- (BOOL)shouldCloseModalPanel:(UAModalPanel *)modalPanel;
- (void)willCloseModalPanel:(UAModalPanel *)modalPanel;
- (void)didCloseModalPanel:(UAModalPanel *)modalPanel;
@end

typedef void (^UAModalDisplayPanelEvent)(UAModalPanel* panel);
typedef void (^UAModalDisplayPanelAnimationComplete)(BOOL finished);

@interface UAModalPanel : UIView {	
	NSObject<UAModalPanelDelegate>	*__weak delegate;
	
	UIView			*contentContainer;
	UIView			*roundedRect;
	UIButton		*closeButton;
	UIButton		*actionButton;
	UIView			*contentView;
	
	CGPoint			startEndPoint;
	
	UIEdgeInsets	margin;
	UIEdgeInsets	padding;
	
	UIColor			*borderColor;
	CGFloat			borderWidth;
	CGFloat			cornerRadius;
	UIColor			*contentColor;
	BOOL			shouldBounce;
	
}

@property (nonatomic, weak) NSObject<UAModalPanelDelegate>	*delegate;

@property (nonatomic, strong) UIView		*contentContainer;
@property (nonatomic, strong) UIView		*roundedRect;
@property (nonatomic, strong) UIButton		*closeButton;
@property (nonatomic, strong) UIButton		*actionButton;
@property (nonatomic, strong) UIView		*contentView;

// Margin between edge of container frame and panel. Default = {20.0, 20.0, 20.0, 20.0}
@property (nonatomic, assign) UIEdgeInsets	margin;
// Padding between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
@property (nonatomic, assign) UIEdgeInsets	padding;
// Border color of the panel. Default = [UIColor whiteColor]
@property (nonatomic, strong) UIColor		*borderColor;
// Border width of the panel. Default = 1.5f
@property (nonatomic, assign) CGFloat		borderWidth;
// Corner radius of the panel. Default = 4.0f
@property (nonatomic, assign) CGFloat		cornerRadius;
// Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
@property (nonatomic, strong) UIColor		*contentColor;
// Shows the bounce animation. Default = YES
@property (nonatomic, assign) BOOL			shouldBounce;

@property (readwrite, copy)	UAModalDisplayPanelEvent onClosePressed;
@property (readwrite, copy)	UAModalDisplayPanelEvent onActionPressed;

- (void)show;
- (void)showFromPoint:(CGPoint)point;
- (void)hide;
- (void)hideWithOnComplete:(UAModalDisplayPanelAnimationComplete)onComplete;

@property (NS_NONATOMIC_IOSONLY, readonly) CGRect roundedRectFrame;
@property (NS_NONATOMIC_IOSONLY, readonly) CGRect closeButtonFrame;
@property (NS_NONATOMIC_IOSONLY, readonly) CGRect contentViewFrame;

@end
