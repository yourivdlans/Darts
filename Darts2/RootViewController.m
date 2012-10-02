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

@synthesize settingsViewController, verticalSlider, horizontalSlider, fields, dart, totalPoints, totalPointsLabel, dart1label, dart2label, dart3label, fire;

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
    [[UIImage imageNamed:@"retina_wood.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    fields = [[NSArray alloc] initWithObjects:@20, @1, @18, @4, @13, @6, @10, @15, @2, @17, @3, @19, @7, @16, @8, @11, @14, @9, @12, @5, nil];
    dart = 0;
    totalPoints = 0;
	// Do any additional setup after loading the view.
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if( UIInterfaceOrientationIsLandscape(toInterfaceOrientation) )
    {
        dart1label.center = CGPointMake(340,60);
        dart2label.center = CGPointMake(340,90);
        dart3label.center = CGPointMake(340,120);
        
        totalPointsLabel.center = CGPointMake(340,160);
    }
    else
    {
        dart1label.center = CGPointMake(85,290);
        dart2label.center = CGPointMake(85,320);
        dart3label.center = CGPointMake(85,350);
        
        totalPointsLabel.center = CGPointMake(85,390);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if ( dart == 1 ){        
        dart1label.text = [NSString stringWithFormat:@"Dart 1: %d", points];
        dart2label.text = [NSString stringWithFormat:@"Dart 2: "];
        dart3label.text = [NSString stringWithFormat:@"Dart 3: "];
    }else if ( dart == 2 ){
        dart2label.text = [NSString stringWithFormat:@"Dart 2: %d", points];
    }else if ( dart == 3 ){
        dart3label.text = [NSString stringWithFormat:@"Dart 3: %d", points];
    }
    
    bool bouncer = [self checkBouncerWithAngle:angle AndDistance:distance];
    if( dart >= 3 ){
        NSString *endOfTurnAlertMessage = [[NSString alloc] initWithFormat:@"Je hebt in totaal %d punten!", totalPoints];
        UIAlertView *endOfTurnAlert = [[UIAlertView alloc] initWithTitle:@"Je beurt is afgelopen!"
                                                                 message: endOfTurnAlertMessage
                                                                delegate: nil
                                                       cancelButtonTitle: @"OK"
                                                       otherButtonTitles: nil ];
        [endOfTurnAlert show];
        [endOfTurnAlertMessage release];
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
