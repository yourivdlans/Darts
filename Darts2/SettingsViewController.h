//
//  SettingsViewController.h
//  Darts2
//
//  Created by Youri van der Lans on 9/24/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsSimpleViewController.h"
#import "SettingsAdvancedViewController.h"

@class SettingsSimpleViewController, SettingsAdvancedViewController;

@interface SettingsViewController : UITabBarController
{
    UIWindow *window;
    
    SettingsSimpleViewController *settingsSimpleViewController;
    SettingsAdvancedViewController *settingsAdvancedViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SettingsSimpleViewController *settingsSimpleViewController;
@property (nonatomic, retain) IBOutlet SettingsAdvancedViewController *settingsAdvancedViewController;

@end
