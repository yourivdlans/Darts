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
    UISlider *verticalSlider;
    UISlider *horizontalSlider;
    UILabel *horizontalPosition;
    UILabel *verticalPosition;
    UIButton *fire;
}

@property (retain, nonatomic) SettingsViewController *settingsViewController;
@property (retain, nonatomic) IBOutlet UISlider *verticalSlider;
@property (retain, nonatomic) IBOutlet UISlider *horizontalSlider;
@property (retain, nonatomic) IBOutlet UILabel *horizontalPosition;
@property (retain, nonatomic) IBOutlet UILabel *verticalPosition;

- (IBAction)showSettings;
- (IBAction)fire;
- (IBAction)updatePositions:(id)sender;

@end
