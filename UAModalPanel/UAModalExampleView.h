//
//  UAModalExampleView.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import "UAModalTitledDisplayPanelView.h"

@interface UAModalExampleView : UAModalTitledDisplayPanelView <UITableViewDataSource> {
	UIView	*v;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
