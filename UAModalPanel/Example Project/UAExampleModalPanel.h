//
//  UAModalExampleView.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import "UATitledModalPanel.h"

@interface UAExampleModalPanel : UATitledModalPanel <UITableViewDataSource> {
	UIView			*v;
	IBOutlet UIView	*viewLoadedFromXib;
}

@property (nonatomic, strong) IBOutlet UIView *viewLoadedFromXib;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title NS_DESIGNATED_INITIALIZER;
- (IBAction)buttonPressed:(id)sender;

@end
