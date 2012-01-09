//
//  UAModalTitledDisplayPanelView.h
//  Flipped Text
//
//  Created by Matt Coneybeare on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UAModalDisplayPanelView.h"
#import "UANoisyGradientBackground.h"	

@interface UAModalTitledDisplayPanelView : UAModalDisplayPanelView {

	UANoisyGradientBackground	*titleBar;
	UILabel						*headerLabel;

}

@property (nonatomic, retain) UANoisyGradientBackground	*titleBar;
@property (nonatomic, retain) UILabel					*headerLabel;

- (CGRect)titleBarFrame;

@end
