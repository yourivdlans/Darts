//
//  RootViewController.h
//  Darts2
//
//  Created by Youri van der Lans on 9/22/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import "DartsModel.h"

@class SettingsViewController;

@interface RootViewController : UIViewController
{
    DartsModel *dartsModel;
    
    SettingsViewController *settingsViewController;
    UISlider *verticalSlider;
    UISlider *horizontalSlider;
    UIButton *fire;
    NSArray *fields;
    NSInteger dart;
    NSInteger totalPoints;
    NSInteger deviation;
    UILabel *totalPointsLabel;
    UILabel *dart1label;
    UILabel *dart2label;
    UILabel *dart3label;
    UILabel *crosshair;
    NSTimer *crosshairTimer;
}

@property (nonatomic, retain) DartsModel *dartsModel;

@property (retain, nonatomic) NSArray *fields;
@property (nonatomic) int dart;
@property (nonatomic) int totalPoints;
@property (nonatomic) int deviation;
@property (retain, nonatomic) SettingsViewController *settingsViewController;
@property (retain, nonatomic) IBOutlet UISlider *verticalSlider;
@property (retain, nonatomic) IBOutlet UISlider *horizontalSlider;
@property (retain, nonatomic) IBOutlet UILabel *totalPointsLabel;
@property (retain, nonatomic) IBOutlet UILabel *dart1label;
@property (retain, nonatomic) IBOutlet UILabel *dart2label;
@property (retain, nonatomic) IBOutlet UILabel *dart3label;
@property (retain, nonatomic) IBOutlet UILabel *crosshair;

- (IBAction)showSettings;
- (IBAction)fire;
- (IBAction)positionCrosshair:(id)sender;
- (BOOL)checkBouncerWithAngle:(double)angle AndDistance:(double)distance;
- (void)moveCrosshairWithX:(int)x andWithY:(int)y;
- (void)deviateCrosshair;

@end
