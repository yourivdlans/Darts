//
//  RootViewController.m
//  Darts2
//
//  Created by Youri van der Lans on 9/22/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import "RootViewController.h"

static int bulls_eye_radius = 5;
static int bull_radius = 10;
static int triple_start_radius = 57;
static int triple_stop_radius = 63;
static int double_start_radius = 94;
static int board_radius = 100;


@interface RootViewController ()

@end

@implementation RootViewController

@synthesize settingsViewController, verticalSlider, horizontalSlider, verticalPosition, horizontalPosition, fields, dart, totalPoints, totalPointsLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * 0.5);
    verticalSlider.transform = trans;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"0930Dartbord.jpeg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    fields = [[NSArray alloc] initWithObjects:@20, @1, @18, @4, @13, @6, @10, @15, @2, @17, @3, @19, @7, @16, @8, @11, @14, @9, @12, @5, nil];
    dart = 0;
    totalPoints = 0;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updatePositions:(id)sender
{
    UISlider * slider = (UISlider*) sender;
    int stand = (int)(slider.value+0.5F);
    
    if( slider.tag == 0 ){
        NSString * labelValue = [[NSString alloc] initWithFormat:@"Horizontal: %d", stand];
        horizontalPosition.text = labelValue;
        [labelValue release];
    }else if( slider.tag == 1 ){
        NSString * labelValue = [[NSString alloc] initWithFormat:@"Vertical: %d", stand];
        verticalPosition.text = labelValue;
        [labelValue release];
    }    
}

- (IBAction)fire
{
    int horizontal = (int)(horizontalSlider.value+0.5F);
    int vertical = (int)(verticalSlider.value+0.5F);
    
    double distance = sqrt(  pow((double)horizontal - 125, 2) + pow((double)vertical - 125, 2) );
    double angle = atan((((double)horizontal - 125) / (125 - (double)vertical)) ) * ( 180 / M_PI);
    
    if( vertical > 125 ){
        angle = angle + 180;
    }else if( horizontal < 125 && vertical <= 125 ){
        angle = angle + 360;
    }
    
    int box = floor(((int)angle + 9) % 360 / 18);
    int points = 0;
    
    if( distance < bulls_eye_radius ){
        points = 50;
    }
    else if( distance < bull_radius ){
        points = 25;
    }
    else if( distance < board_radius ){
        points = [[self.fields objectAtIndex:box] intValue ];
        if ( distance > triple_start_radius && distance < triple_stop_radius) {
            points *= 3;
        }else if( distance > double_start_radius ){
            points *= 2;
        }
    }
    
    totalPoints += points;
    
    NSString * totalPointslabelValue = [[NSString alloc] initWithFormat:@"Total points: %d", totalPoints];
    totalPointsLabel.text = totalPointslabelValue;
    dart += 1;
    
    bool bouncer = [self checkBouncerWithAngle:angle AndDistance:distance];
    if( dart >= 3 ){
        NSString *endOfTurnAlertMessage = [[NSString alloc] initWithFormat:@"Je hebt in totaal %d punten!", totalPoints];
        UIAlertView *endOfTurnAlert = [[UIAlertView alloc] initWithTitle:@"Je beurt is afgelopen!"
                                                                 message: endOfTurnAlertMessage
                                                                delegate: nil
                                                       cancelButtonTitle: @"OK"
                                                       otherButtonTitles: nil ];
        [endOfTurnAlert show];
        [endOfTurnAlert release];
        
        dart = 0;
        totalPoints = 0;
    }
    else
    {
        NSString *alert_message = [[NSString alloc] init];
        
        if( bouncer == YES ){
            alert_message = [[NSString alloc] initWithFormat:@"Bouncer!"];
        }else{
            alert_message = [[NSString alloc] initWithFormat:@"Je hebt %d punten!", points];
        }
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Je hebt gegooid!"
                                                        message: alert_message
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil ];
        [alert show];
        [alert release];
        [alert_message release];
    }
    
    [totalPointslabelValue release];
}

- (BOOL)checkBouncerWithAngle:(double)angle AndDistance:(double)distance
{
    if( distance == bulls_eye_radius ){
        return YES;
    }
    
    if( distance == bull_radius ){
        return YES;
    }
    
    if( distance == triple_start_radius ){
        return YES;
    }
    
    if( distance == triple_stop_radius ){
        return YES;
    }
    
    if( distance == board_radius ){
        return YES;
    }
    
    return NO;
}

- (IBAction)showSettings
{
    if ( self.settingsViewController.view.superview == nil )
    {
        if ( self.settingsViewController == nil )
        {
            SettingsViewController *tmp = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
            self.settingsViewController = tmp;
            [tmp release];
        }
    }
    
    [self.navigationController pushViewController:self.settingsViewController animated:YES];
}

@end
