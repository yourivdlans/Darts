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
    UIButton *fire;
    NSArray *fields;
    NSInteger dart;
    NSInteger totalPoints;
    UILabel *totalPointsLabel;
    UILabel *dart1label;
    UILabel *dart2label;
    UILabel *dart3label;
}

@property (retain, nonatomic) NSArray *fields;
@property (readwrite, atomic) int dart;
@property (readwrite, atomic) int totalPoints;
@property (retain, nonatomic) SettingsViewController *settingsViewController;
@property (retain, nonatomic) IBOutlet UISlider *verticalSlider;
@property (retain, nonatomic) IBOutlet UISlider *horizontalSlider;
@property (retain, nonatomic) IBOutlet UILabel *totalPointsLabel;
@property (retain, nonatomic) IBOutlet UILabel *dart1label;
@property (retain, nonatomic) IBOutlet UILabel *dart2label;
@property (retain, nonatomic) IBOutlet UILabel *dart3label;
@property (retain, nonatomic) IBOutlet UIButton *fire;


- (IBAction)showSettings;
- (IBAction)fire;
- (BOOL)checkBouncerWithAngle:(double)angle AndDistance:(double)distance;

@end
