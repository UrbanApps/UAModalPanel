//
//  UAViewController.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UAModalPanel;

@interface UAViewController : UIViewController {
	UAModalPanel *currentPanel; // pointer to the current one
}

@property (nonatomic, retain) UAModalPanel	*currentPanel; // pointer to the current one

- (IBAction)showModalPanel:(id)sender;

@end
