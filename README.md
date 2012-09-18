What is UAModalPanel?
---------------------

![UAModalPanel Example Pic](https://github.com/coneybeare/UAModalPanel/raw/master/_README_ASSETS/UAModalPanel.jpg)![UAModalPanel Example Pic 2](https://github.com/coneybeare/UAModalPanel/raw/master/_README_ASSETS/UAModalPanel2.jpg)![UAModalPanel Example Pic 3](https://github.com/coneybeare/UAModalPanel/raw/master/_README_ASSETS/UAModalPanel3.jpg)![UAModalPanel Example Pic 4](https://github.com/coneybeare/UAModalPanel/raw/master/_README_ASSETS/UAModalPanel4.jpg)

UAModalPanel is a highly customizable, alternative modal panel that you can popup in your view controllers to show content that might not need an entire new screen to show. It has a bounce animation, content fade-in, and a fancy noisy-gradient title bar. It works on the iPhone and iPad, with or without rotation.

Example Video
---------------------
http://www.youtube.com/watch?v=AJDR0GAsV9E



Step 0: Prerequisites
---------------------
You'll need at least Xcode 3.2 and an iOS 4.0+ project


Step 1: Get UAModalPanel files (add as Git submodule)
----------------
In terminal navigate to the root of your project directory and run these commands (assuming your project is a git repo):

    git submodule add git://github.com/coneybeare/UAModalPanel.git Submodules/UAModalPanel
    git commit -m 'UAModalPanel added as submodule'

This creates new submodule, downloads the files to Submodules/UAModalPanel directory within your project and creates new commit with updated git repo settings. Thanks to the fact that you added UAModalPanel as submodule, it is easy to keep it updated to the newest version by simply doing:

    git submodule update


Step 2: Add UAModalPanel to your project
------------------------------------

**Copy files from example project**

* Open both the example project (that you downloaded in step 1 above) and your app's project in XCode.
* Drag the UAModalPanel Group from the example project into your project's Groups & Files.
* Make sure the _"Copy items into destination group's folder (if needed)"_ checkbox is _UNchecked_.

XCode 4 note: adding the files is different in Xcode 4 - first, make sure your UAModalPanel project window is closed, then you drag the UAModalPanel.xcodeproj file (from a Finder window) to your project. You should see the UAModalPanel's proj tree open up within your project in XCode, and then you should be able to drag UAModalPanel group as stated above. You then **must remove UAModalPanel.xcodeproj (whole UAModalPanel project) from your project**, so that it does not interfere with your project.

**Add Frameworks**

Expand the 'Frameworks' group in your project's file list. Make sure you have the following framework installed:

* `QuartzCore.framework`

If you are missing any frameworks, right click the 'Frameworks' group and select Add -> Existing Frameworks. Select the framework you are missing and add it to your project.


Step 3: Implement UAModalPanel
------------------------

**Subclass UAModalPanel**

The best way to use the panel is to subclass it and add your own elements to the `contentView`. To get a plain modal panel, subclass [UAModalPanel](https://github.com/coneybeare/UAModalPanel/blob/master/UAModalPanel/Panel/Panels/UAModalPanel.h) . To get a titled modal panel, subclass [UATitledModalPanel](https://github.com/coneybeare/UAModalPanel/blob/master/UAModalPanel/Panel/Panels/UATitledModalPanel.h). Check out the example project for a sample subclass, [UAExampleModalPanel](https://github.com/coneybeare/UAModalPanel/blob/master/UAModalPanel/Example%20Project/UAExampleModalPanel.h)

**Add UAModalPanel to a View Controller**

Display the panel by creating an instance of your subclass and show it from a point:

````objective-c
- (IBAction)showModalPanel:(id)sender {
    UAModalPanel *modalPanel = [[[UAExampleModalPanel alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:modalPanel];
    [modalPanel showFromPoint:[sender center]];
}
````

UAModalPanel knows how to close itself, but if you want more control or action button handling, read on.

**Optional Event Handling**

You can optionally implement either the UAModalPanelDelegate methods for callbacks and validations...

````objective-c
// Optional: This is called before the open animations.
//   Only used if delegate is set and not using blocks.
- (void)willShowModalPanel:(UAModalPanel *)modalPanel;

// Optional: This is called after the open animations.
//   Only used if delegate is set and not using blocks.
- (void)didShowModalPanel:(UAModalPanel *)modalPanel;

// Optional: This is called when the close button is pressed
//   You can use it to perform validations
//   Return YES to close the panel, otherwise NO
//   Only used if delegate is set and not using blocks.
- (BOOL)shouldCloseModalPanel:(UAModalPanel *)modalPanel;

// Optional: This is called when the action button is pressed
//   Action button is only visible when its title is non-nil;
//   Only used if delegate is set and not using blocks.
- (void)didSelectActionButton:(UAModalPanel *)modalPanel;

// Optional: This is called before the close animations.
//   Only used if delegate is set and not using blocks.
- (void)willCloseModalPanel:(UAModalPanel *)modalPanel;

// Optional: This is called after the close animations.
//   Only used if delegate is set and not using blocks.
- (void)didCloseModalPanel:(UAModalPanel *)modalPanel;
````
    
...or you can use blocks when creating the panel.

````objective-c
// The block is responsible for closing the panel,
//   either with -[UAModalPanel hide] or -[UAModalPanel hideWithOnComplete:]
//   Panel is a reference to the modalPanel
    modalPanel.onClosePressed = ^(UAModalPanel* panel) {
        // Do something awesome when the close button is pressed
        [panel hideWithOnComplete:^(BOOL finished) {
            // Do something else awesome after it closes.
        }];
    };
    
//   Panel is a reference to the modalPanel
    modalPanel.onActionPressed = ^(UAModalPanel* panel) {
        // Do something awesome when the action button is pressed
    };

````

**Animation Hooks**

You can add any of these methods to your subclass to get hooks at various points of the bounce animation.

````objective-c
- (void)showAnimationStarting;
- (void)showAnimationPart1Finished;
- (void)showAnimationPart2Finished;
- (void)showAnimationPart3Finished;
- (void)showAnimationFinished;
````

**Logging**

You can add `UAMODALVIEW_DEBUG` as a preprocessor macro on your project to turn on some potentially useful logging in UAModalPanel.


Step 4: Customize UAModalPanel
------------------------
  
The best place to customize is in your UAModalPanel subclass.

**UAModalPanel Customizations**

````objective-c
// Margin between edge of container frame and panel. Default = {20.0, 20.0, 20.0, 20.0}
self.margin = UIEdgeInsetsMake(10.0, 20.0, 30.0, 20.0);
    
// Padding between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
self.padding = UIEdgeInsetsMake(10.0, 20.0, 30.0, 20.0);
    
// Border color of the panel. Default = [UIColor whiteColor]
self.borderColor = [UIColor blueColor];
    
// Border width of the panel. Default = 1.5f;
self.borderWidth = 5.0f;
    
// Corner radius of the panel. Default = 4.0f
self.cornerRadius = 10.0f;
    
// Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
self.contentColor = [UIColor yellowColor];
    
// Shows the bounce animation. Default = YES
self.shouldBounce = NO;

// Shows the actionButton. Default title is nil, thus the button is hidden by default
[self.actionButton setTitle:@"Foobar" forState:UIControlStateNormal];
````

**UATitledModalPanel customizations**

````objective-c
// Height of the title view. Default = 40.0f
self.titleBarHeight = 80.0f;
    
// The background color gradient of the title
CGFloat colors[8] = {0, 1, 1, 1, 1, 1, 0, 1};
[self.titleBar setColorComponents:colors];
    
// The header label, a UILabel with the same frame as the titleBar
self.headerLabel.font = [UIFont boldSystemFontOfSize:24];
````

**UANoisyGradientBackground and UAGradientBackground customizations**

````objective-c
// The gradient style (Linear, linear reversed, radial, radial reversed, center highlight). Default = Linear
[[self titleBar] setGradientStyle:UAGradientBackgroundStyleCenterHighlight];
    
// The line mode of the gradient view (top, bottom, both, none)
[[self titleBar] setLineMode:UAGradientLineModeNone];
    
// The noise layer opacity
[[self titleBar] setNoiseOpacity:0.3];
````


Step 5: There is no step 5.
------------------------

That's it. Please feel free to fork and submit pull requests, fix issues or whatever else.


ARC Support
------------------------
UAModalPanel is not using ARC, but you can use it in your ARC project by adding `-fno-objc-arc` compiler flag to the "Compile Sources" section found in the Target's "Build Settings" tab

![ARC Settings](https://github.com/coneybeare/UAModalPanel/raw/master/_README_ASSETS/UAModalPanelARC.png)


Cocoapods
------------------------
UAModalPanel can be added to a project using [Cocoapods](https://github.com/CocoaPods/CocoaPods)


App that are using UAModalPanel:
------------------------
If you are using UAModalPanel, please contact me to get added to this list!

* [Ambiance](http://ambianceapp.com/iphone), [Ambiance Lite](http://ambianceapp.com/iphone)
* [Hourly News](http://itunes.apple.com/us/app/hourly-news/id493859859?mt=8)
* [FlippedText](http://flippedtext.com)
* [Hanging with Cheats](http://hangingwithcheats.com)


Get in touch:
------------------------

* [Follow my code blog](http://code.coneybeare.net)
* [Follow me on Twitter](http://twitter.com/coneybeare) 
* [Contact me](http://coneybeare.net)


Donate:
------------------------
Please support us so that we can continue to make UAModalPanel even more awesome! If you are feeling particularly generous, please buy me a beer! 


[![Paypal Button](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif "Paypal Button")](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LGPE58JWZKBG2)
