//
//  RootViewController.h
//  Darts2
//
//  Created by Youri van der Lans on 9/22/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@class SettingsViewController;

@interface RootViewController : UIViewController
{
    SettingsViewController *settingsViewController;
}

@property (retain, nonatomic) SettingsViewController *settingsViewController;

- (IBAction)showSettings;

@end
