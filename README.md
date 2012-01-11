What is UAModalPanel?
---------------------

![UAModalPanel Example Pic](http://files.urbanapps.com/images/UAModalPanel.jpg "UAModalPanel Example Pic") ![UAModalPanel Example Pic 2](http://files.urbanapps.com/images/UAModalPanel2.jpg "UAModalPanel Example Pic 2")

`UAModalPanel` is an alternative modal panel that you can popup in your view controllers to show content that might not need an entire new screen to show. It works on the iPhone and iPad, with or without rotation, and is a non-ARC project.

Example Video
---------------------
I can't figure out how to embed a video in markdown, so here is a link to it: http://www.youtube.com/watch?v=AJDR0GAsV9E


Step 0: Prerequisites
---------------------
You'll need at least XCode 3.2.

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

* QuartzCore.framework

If you are missing any frameworks, right click the 'Frameworks' group and select Add -> Existing Frameworks. Select the framework you are missing and add it to your project.


Step 3: Implement UAModalPanel
------------------------

**Subclass UAModalPanel**

The best way to use the panel is to subclass it and add your own elements to the `contentView`. To get a plain modal panel, subclass `UAModalPanel`. To get a titled modal panel, subclass `UATitledModalPanel`. Check out the example project for a sample subclass, `UAExampleModalPanel`

**Add UAModalPanel to a View Controller**

In your `.h` file, keep an instance variable to the panel. This allows your controller to communicate with the panel if necessary, and to close it when done.

    @class UAModalPanel;
    @interface UAViewController : UIViewController {
        UAModalPanel *currentPanel;
    }
    @property (nonatomic, retain) UAModalPanel  *currentPanel;
    
In your .m file, synthesize and dealloc the panel

    @synthesize currentPanel;
    - (void)dealloc {
        self.currentPanel = nil;
        [super dealloc];
    }
    
Display the panel by creating an instance of your subclass and show it from a point:

    - (IBAction)showModalPanel:(id)sender {
        self.currentPanel = [[[UAExampleModalPanel alloc] initWithFrame:self.view.bounds] autorelease];
        self.currentPanel.delegate = self;
        [self.view addSubview:self.currentPanel];
        [self.currentPanel showFromPoint:[sender center]];
    }

You must also implement the delegate method for when the close button is pressed:

    - (void)removeModalView {
        [self.currentPanel hideWithDelegate:self selector:@selector(removeModal)];
    }

... and for when the close animations are completed:

    - (void)removeModal {
        [self.currentPanel removeFromSuperview];
        self.currentPanel = nil;
    }



Step 4: Customize UAModalPanel
------------------------
  
**UAModalPanel Customizations**

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
  
**UATitledModalPanel customizations**
    
    // Height of the title view. Default = 40.0f
    self.currentPanel.titleBarHeight = 80.0f;
    
    // The background color gradient of the title
    CGFloat colors[8] = {0, 1, 1, 1, 1, 1, 0, 1};
    [self.currentPanel.titleBar setColorComponents:colors];
    
    // The header label, a UILabel with the same frame as the titleBar
    self.currentPanel.headerLabel.font = [UIFont boldSystemFontOfSize:24];
  
**UANoisyGradientBackground and UAGradientBackground customizations**

These components are pretty self explanatory. Dig in if you want to use these for other purposes, but I leave that as an exercise to the reader :)



Step 5: There is no step 5.
------------------------

That's it. Please feel free to fork and submit pull requests, fix issues or whatever else.


* 13k reputation on Stack Overflow: http://stackoverflow.com/users/69634/coneybeare
* Follow my code blog: http://code.coneybeare.net
* Contact me on Twitter: http://twitter.com/coneybeare
