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


- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
	if ((self = [super initWithFrame:frame])) {
		
		CGFloat colors[8] = BLACK_BAR_COMPONENTS;
		[self.titleBar setColorComponents:colors];
		self.headerLabel.text = title;
		
		
		UIWebView *wv = [[[UIWebView alloc] initWithFrame:CGRectZero] autorelease];
		[wv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/coneybeare/UAModalPanel"]]];
		
		UITableView *tv = [[[UITableView alloc] initWithFrame:CGRectZero] autorelease];
		[tv setDataSource:self];
		
		UIImageView *iv = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
		[iv setImage:[UIImage imageNamed:@"UrbanApps.png"]];
		[iv setContentMode:UIViewContentModeScaleAspectFit];
		
		NSArray *contentArray = [NSArray arrayWithObjects:wv, tv, iv, nil];
		
		int i = arc4random() % 3;
		v = [[contentArray objectAtIndex:i] retain];
		[self.contentView addSubview:v];
		
	}	
	return self;
}

- (void)dealloc {
    [v release];
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


@end
