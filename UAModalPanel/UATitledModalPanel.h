//
//  UAModalTitledDisplayPanelView.h
//  Flipped Text
//
//  Created by Matt Coneybeare on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UAModalPanel.h"
#import "UANoisyGradientBackground.h"	

@interface UATitledModalPanel : UAModalPanel {

	CGFloat						titleBarHeight;
	UANoisyGradientBackground	*titleBar;
	UILabel						*headerLabel;

}

// Height of the title view. Default = 40.0f
@property (nonatomic, assign) CGFloat					titleBarHeight;
// The gradient bacground of the title
@property (nonatomic, retain) UANoisyGradientBackground	*titleBar;
// The title label
@property (nonatomic, retain) UILabel					*headerLabel;

- (CGRect)titleBarFrame;

@end
