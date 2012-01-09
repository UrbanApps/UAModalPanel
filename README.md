What is UAModalPanel?
---------------------

![UAModalPanel Example Pic](http://files.urbanapps.com/images/UAModalPanel.jpg "UAModalPanel Example Pic")

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

This creates new submodule, downloads the files to Submodules/UAModalPanel directory within your project and creates new commit with updated git repo settings.

Thanks to the fact that you added UAModalPanel as submodule, it is easy to keep it updated to the newest version by doing:

    git submodule update


Step 2: Add UAModalPanel to your project
------------------------------------

**Copy files from example project**

Open both the example project (that you downloaded in step 1 above) and your app's project in XCode.

Drag the UAModalPanel Group from the example project into your project's Groups & Files.

Make sure the _"Copy items into destination group's folder (if needed)"_ checkbox is _UNchecked_.

XCode 4 note: adding the files is different in Xcode 4 - first, make sure your UAModalPanel project window is closed, then you drag the UAModalPanel.xcodeproj file (from a Finder window) to your project. You should see the UAModalPanel's proj tree open up within your project in XCode, and then you should be able to drag UAModalPanel group as stated above. You then **must remove UAModalPanel.xcodeproj (whole UAModalPanel project) from your project**, so that it does not interfere with your project.

**Add Frameworks**

Expand the 'Frameworks' group in your project's file list. Make sure you have the following framework installed:

* QuartzCore.framework

If you are missing any frameworks, right click the 'Frameworks' group and select Add -> Existing Frameworks. Select the framework you are missing and add it to your project.

**Base SDK and Deployment Targets**

If you aren't already, you'll want to make sure your base SDK is set to Latest iOS. You can still support older versions (back to 3.*) by setting your deployment target.

Step 3: Using UAModalPanel
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
  
        self.currentPanel = [[[UAExampleModalPanel alloc] initWithFrame:self.view.bounds title:[(UIButton *)sender titleForState:UIControlStateNormal]] autorelease];
  
        self.currentPanel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.currentPanel.autoresizesSubviews = YES;
        self.currentPanel.delegate = self;
        self.currentPanel.margin = 20.0f;
        self.currentPanel.shouldBounce = YES;

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

  
That's it. Please feel free to fork and submit pull requests, fix issues or whatever else.


* 13k reputation on Stack Overflow: http://stackoverflow.com/users/69634/coneybeare
* Follow my code blog: http://code.coneybeare.net
* Contact me on Twitter: @coneybeare
