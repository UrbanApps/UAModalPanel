//
//  UAViewController.m
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import "UAViewController.h"

#import "UAModalExampleView.h"

@implementation UAViewController

@synthesize currentPanel;

#pragma mark - View lifecycle

- (void)dealloc {
    self.currentPanel = nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}


- (IBAction)showModalPanel:(id)sender {
	
	self.currentPanel = [[[UAModalExampleView alloc] initWithFrame:self.view.bounds title:[(UIButton *)sender titleForState:UIControlStateNormal]] autorelease];
	
	self.currentPanel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	self.currentPanel.autoresizesSubviews = YES;
	self.currentPanel.delegate = self;
	self.currentPanel.shouldBounce = YES;
	
	[self.view addSubview:self.currentPanel];
	[self.currentPanel showFromPoint:[sender center]];
}

#pragma mark - UAModalDisplayPanelViewDelegate

- (void)removeModalView {
	if (self.currentPanel) {
		[self.currentPanel hideWithDelegate:self selector:@selector(removeModal)];
	}
}

- (void)removeModal {
	if (self.currentPanel) {
		[self.currentPanel removeFromSuperview];
		self.currentPanel = nil;
	}
}
@end
