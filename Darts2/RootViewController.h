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
    UILabel *totalPointsLabel;
    UIButton *fire;
    NSArray *fields;
    NSInteger dart;
    NSInteger totalPoints;
}

@property (retain, nonatomic) NSArray *fields;
@property (readwrite, atomic) int dart;
@property (readwrite, atomic) int totalPoints;
@property (retain, nonatomic) SettingsViewController *settingsViewController;
@property (retain, nonatomic) IBOutlet UISlider *verticalSlider;
@property (retain, nonatomic) IBOutlet UISlider *horizontalSlider;
@property (retain, nonatomic) IBOutlet UILabel *horizontalPosition;
@property (retain, nonatomic) IBOutlet UILabel *verticalPosition;
@property (retain, nonatomic) IBOutlet UILabel *totalPointsLabel;

- (IBAction)showSettings;
- (IBAction)fire;
- (IBAction)updatePositions:(id)sender;
- (BOOL)checkBouncerWithAngle:(double)angle AndDistance:(double)distance;

@end
