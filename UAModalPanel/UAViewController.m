//
//  UAViewController.m
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#define USE_BLOCKS

#import "UAViewController.h"

#import "UAExampleModalPanel.h"
#import "UANoisyGradientBackground.h"
#import "UAGradientBackground.h"

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
	
	self.currentPanel = [[[UAExampleModalPanel alloc] initWithFrame:self.view.bounds title:[(UIButton *)sender titleForState:UIControlStateNormal]] autorelease];

#ifdef USE_BLOCKS
    // NOTE: actually keeping a reference to the current panel is less necessary when using blocks as the block
    // passes back a point to the panel
    self.currentPanel.onClosePressed = ^(UAModalPanel* panel) {
        [panel hideWithOnComplete:^(BOOL finished) {
            [panel removeFromSuperview];
            
            if (panel == self.currentPanel) {
                self.currentPanel = nil;
            }
        }];
    };
#else
    self.currentPanel.delegate = self;
#endif
	
	// Show the defaults mostly, but once in awhile show a funky one
	if (arc4random() % 5 == 4) {
		// Funky time.
		
		// Margin between edge of container frame and panel. Default = 20.0
		self.currentPanel.outerMargin = 30.0f;  // Default = 20.0f;
		
		// Margin between edge of panel and the content area. Default = 20.0
		self.currentPanel.innerMargin = 30.0f;  // Default = 20.0f;
		
		// Border color of the panel. Default = [UIColor whiteColor]
		self.currentPanel.borderColor = [UIColor blueColor];
		
		// Border width of the panel. Default = 1.5f;
		self.currentPanel.borderWidth = 5.0f;
		
		// Corner radius of the panel. Default = 4.0f
		self.currentPanel.cornerRadius = 10.0f;
		
		// Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
		self.currentPanel.contentColor = [UIColor yellowColor];
		
		// Shows the bounce animation. Default = YES
		self.currentPanel.shouldBounce = NO;
		
		// Height of the title view. Default = 40.0f
		[(UATitledModalPanel *)self.currentPanel setTitleBarHeight:80.0f];
		
		// The background color gradient of the title
		CGFloat colors[8] = {0, 0, 1, 1, 1, 0, 0, 1};
		[[(UATitledModalPanel *)self.currentPanel titleBar] setColorComponents:colors];
		// The gradient style (Linear, linear reversed, radial, radial reversed, center highlight). Default = Linear
		[[(UATitledModalPanel *)self.currentPanel titleBar] setGradientStyle:UAGradientBackgroundStyleCenterHighlight];
		// The line mode of the gradient view (top, bottom, both, none). Top is a white line, bottom is a black line.
		[[(UATitledModalPanel *)self.currentPanel titleBar] setLineMode:UAGradientLineModeNone];
		// The noise layer opacity. Default = 0.4
		[[(UATitledModalPanel *)self.currentPanel titleBar] setNoiseOpacity:0.8];
		
		// The header label, a UILabel with the same frame as the titleBar
		[(UATitledModalPanel *)self.currentPanel headerLabel].font = [UIFont boldSystemFontOfSize:48];
	}
	
	
	
	[self.view addSubview:self.currentPanel];
	[self.currentPanel showFromPoint:[sender center]];
}


#pragma mark - UAModalDisplayPanelViewDelegate

#ifndef USE_BLOCKS

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

#endif


@end
