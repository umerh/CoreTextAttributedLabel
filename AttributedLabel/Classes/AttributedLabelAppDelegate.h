//
//  AttributedLabelAppDelegate.h
//  AttributedLabel
//
//  Created by Umer Sheikh on 10-06-13.
//  Copyright Eastern Heritage 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface AttributedLabelAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
		MainViewController *controller;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

