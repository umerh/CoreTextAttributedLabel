//
//  AttributedLabelAppDelegate.m
//  AttributedLabel
//
//  Created by Umer Sheikh on 10-06-13.
//  Copyright Eastern Heritage 2010. All rights reserved.
//

#import "AttributedLabelAppDelegate.h"

@implementation AttributedLabelAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	controller = [[MainViewController alloc] init];
	[window addSubview:controller.view];
    // Override point for customization after application launch
	
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
