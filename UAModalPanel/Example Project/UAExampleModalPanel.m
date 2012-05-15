//
//  UAModalExampleView.m
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import "UAExampleModalPanel.h"

#define BLACK_BAR_COMPONENTS				{ 0.22, 0.22, 0.22, 1.0, 0.07, 0.07, 0.07, 1.0 }

@implementation UAExampleModalPanel

@synthesize viewLoadedFromXib;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
	if ((self = [super initWithFrame:frame])) {
		
		CGFloat colors[8] = BLACK_BAR_COMPONENTS;
		[self.titleBar setColorComponents:colors];
		self.headerLabel.text = title;
		
		
		////////////////////////////////////
		// RANDOMLY CUSTOMIZE IT
		////////////////////////////////////
		// Show the defaults mostly, but once in awhile show a completely random funky one
		if (arc4random() % 4 == 0) {
			// Funky time.
			UADebugLog(@"Showing a randomized panel for modalPanel: %@", self);
			
			// Margin between edge of container frame and panel. Default = 20.0
			self.outerMargin = ((arc4random() % 4) + 1) * 20.0f;
            
            // Margin between top/bottom edge of container frame and panel. Default = 20.0
            self.outerMarginY = ((arc4random() % 4) + 1) * 20.0f;
            
			// Margin between edge of panel and the content area. Default = 20.0
			self.innerMargin = ((arc4random() % 4) + 1) * 10.0f;
			
			// Border color of the panel. Default = [UIColor whiteColor]
			self.borderColor = [UIColor colorWithRed:(arc4random() % 2) green:(arc4random() % 2) blue:(arc4random() % 2) alpha:1.0];
			
			// Border width of the panel. Default = 1.5f;
			self.borderWidth = ((arc4random() % 21)) * 0.5f;
			
			// Corner radius of the panel. Default = 4.0f
			self.cornerRadius = (arc4random() % 21);
			
			// Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
			self.contentColor = [UIColor colorWithRed:(arc4random() % 2) green:(arc4random() % 2) blue:(arc4random() % 2) alpha:1.0];
			
			// Shows the bounce animation. Default = YES
			self.shouldBounce = (arc4random() % 2);
			
			// Height of the title view. Default = 40.0f
			[self setTitleBarHeight:((arc4random() % 5) + 2) * 20.0f];
			
			// The background color gradient of the title
			CGFloat colors[8] = {
				(arc4random() % 2), (arc4random() % 2), (arc4random() % 2), 1,
				(arc4random() % 2), (arc4random() % 2), (arc4random() % 2), 1
			};
			[[self titleBar] setColorComponents:colors];
			
			// The gradient style (Linear, linear reversed, radial, radial reversed, center highlight). Default = UAGradientBackgroundStyleLinear
			[[self titleBar] setGradientStyle:(arc4random() % 5)];
			
			// The line mode of the gradient view (top, bottom, both, none). Top is a white line, bottom is a black line.
			[[self titleBar] setLineMode: pow(2, (arc4random() % 3))];
			
			// The noise layer opacity. Default = 0.4
			[[self titleBar] setNoiseOpacity:(((arc4random() % 10) + 1) * 0.1)];
			
			// The header label, a UILabel with the same frame as the titleBar
			[self headerLabel].font = [UIFont boldSystemFontOfSize:floor(self.titleBarHeight / 2.0)];
		}

	
		//////////////////////////////////////
		// SETUP RANDOM CONTENT
		//////////////////////////////////////
		UIWebView *wv = [[[UIWebView alloc] initWithFrame:CGRectZero] autorelease];
		[wv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://urbanapps.com/product_list"]]];
		
		UITableView *tv = [[[UITableView alloc] initWithFrame:CGRectZero] autorelease];
		[tv setDataSource:self];
		
		UIImageView *iv = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
		[iv setImage:[UIImage imageNamed:@"UrbanApps.png"]];
		[iv setContentMode:UIViewContentModeScaleAspectFit];
		
		[[NSBundle mainBundle] loadNibNamed:@"UAExampleView" owner:self options:nil];
		
		NSArray *contentArray = [NSArray arrayWithObjects:wv, tv, iv, viewLoadedFromXib, nil];
		
		int i = arc4random() % [contentArray count];
		v = [[contentArray objectAtIndex:i] retain];
		[self.contentView addSubview:v];
		
	}	
	return self;
}

- (void)dealloc {
    [v release];
	[viewLoadedFromXib release];
    [super dealloc];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[v setFrame:self.contentView.bounds];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString *cellIdentifier = @"UAModalPanelCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
	}
	
	[cell.textLabel setText:[NSString stringWithFormat:@"Row %d", indexPath.row]];
	
	return cell;
}

#pragma mark - Actions
- (IBAction)buttonPressed:(id)sender {
	// The button was pressed. Lets do something with it.
	
	// Maybe the delegate wants something to do with it...
	if ([delegate respondsToSelector:@selector(superAwesomeButtonPressed:)]) {
		[delegate performSelector:@selector(superAwesomeButtonPressed:) withObject:sender];
	
	// Or perhaps someone is listening for notifications 
	} else {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"SuperAwesomeButtonPressed" object:sender];
	}
		
	NSLog(@"Super Awesome Button pressed!");
}

@end
