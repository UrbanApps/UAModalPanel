//
//  UAViewController.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UAModalDisplayPanelView;

@interface UAViewController : UIViewController {
	UAModalDisplayPanelView *currentPanel; // pointer to the current one
}

@property (nonatomic, retain) UAModalDisplayPanelView	*currentPanel; // pointer to the current one

- (IBAction)showModalPanel:(id)sender;

@end
