//
//  UAViewController.m
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import "UAViewController.h"

#import "UAExampleModalPanel.h"
#import "UANoisyGradientBackground.h"
#import "UAGradientBackground.h"

@implementation UAViewController

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


- (IBAction)showModalPanel:(id)sender {
	
	UAExampleModalPanel *modalPanel = [[UAExampleModalPanel alloc] initWithFrame:self.view.bounds title:[(UIButton *)sender titleForState:UIControlStateNormal]];
	 
	/////////////////////////////////
	// Randomly use the blocks method, delgate methods, or neither of them
	int blocksDelegateOrNone = arc4random() % 3;
	
	
	////////////////////////
	// USE BLOCKS
	if (0 == blocksDelegateOrNone) {
		///////////////////////////////////////////
		// The block is responsible for closing the panel,
		//   either with -[UAModalPanel hide] or -[UAModalPanel hideWithOnComplete:]
		//   Panel is a reference to the modalPanel
		modalPanel.onClosePressed = ^(UAModalPanel* panel) {
			// [panel hide];
			[panel hideWithOnComplete:^(BOOL finished) {
				[panel removeFromSuperview];
			}];
			UADebugLog(@"onClosePressed block called from panel: %@", panel);
		};
		
		///////////////////////////////////////////
		//   Panel is a reference to the modalPanel
		modalPanel.onActionPressed = ^(UAModalPanel* panel) {
			UADebugLog(@"onActionPressed block called from panel: %@", panel);
		};
		
		UADebugLog(@"UAModalView will display using blocks: %@", modalPanel);
	
	////////////////////////
	// USE DELEGATE
	} else if (1 == blocksDelegateOrNone) {
		///////////////////////////////////
		// Add self as the delegate so we know how to close the panel
		modalPanel.delegate = self;
		
		UADebugLog(@"UAModalView will display using delegate methods: %@", modalPanel);
	
	////////////////////////
	// USE NOTHING
	} else {
		// no-op. No delegate or blocks
		UADebugLog(@"UAModalView will display without blocks or delegate methods: %@", modalPanel);
	}
	
	
	///////////////////////////////////
	// Add the panel to our view
	[self.view addSubview:modalPanel];
	
	///////////////////////////////////
	// Show the panel from the center of the button that was pressed
	[modalPanel showFromPoint:[sender center]];
}


#pragma mark - UAModalDisplayPanelViewDelegate 

// Optional: This is called before the open animations.
//   Only used if delegate is set.
- (void)willShowModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"willShowModalPanel called with modalPanel: %@", modalPanel);
}

// Optional: This is called after the open animations.
//   Only used if delegate is set.
- (void)didShowModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"didShowModalPanel called with modalPanel: %@", modalPanel);
}

// Optional: This is called when the close button is pressed
//   You can use it to perform validations
//   Return YES to close the panel, otherwise NO
//   Only used if delegate is set.
- (BOOL)shouldCloseModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"shouldCloseModalPanel called with modalPanel: %@", modalPanel);
	return YES;
}

// Optional: This is called when the action button is pressed
//   Action button is only visible when its title is non-nil;
//   Only used if delegate is set and not using blocks.
- (void)didSelectActionButton:(UAModalPanel *)modalPanel {
	UADebugLog(@"didSelectActionButton called with modalPanel: %@", modalPanel);
}

// Optional: This is called before the close animations.
//   Only used if delegate is set.
- (void)willCloseModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"willCloseModalPanel called with modalPanel: %@", modalPanel);
}

// Optional: This is called after the close animations.
//   Only used if delegate is set.
- (void)didCloseModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"didCloseModalPanel called with modalPanel: %@", modalPanel);
}


@end
