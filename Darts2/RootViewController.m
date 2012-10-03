//
//  RootViewController.m
//  Darts2
//
//  Created by Youri van der Lans on 9/22/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import "RootViewController.h"

static int bulls_eye_radius = 4;
static int bull_radius = 8;
static int triple_start_radius = 43;
static int triple_stop_radius = 47;
static int double_start_radius = 71;
static int board_radius = 75;

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize dartsModel, settingsViewController, verticalSlider, horizontalSlider, fields, dart, totalPoints, totalPointsLabel, dart1label, dart2label, dart3label, crosshair, deviation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    self.dartsModel = [DartsModel sharedManager];
    
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
    deviation = [self determineDeviation];
    
    crosshair.hidden = YES;

    double interval = 1 - ( self.dartsModel.level * 0.4 );
    [self startTimerWithInterval:interval];
    
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    double interval = 1 - ( self.dartsModel.level * 0.4 );
    [self startTimerWithInterval:interval];
    [self determineDeviation];
}

- (void) startTimerWithInterval:(double)interval
{
    [crosshairTimer invalidate];
    crosshairTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(deviateCrosshair) userInfo:nil repeats:YES];
    [crosshairTimer fire];
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

- (int)determineDeviation
{
    deviation = 1;
    deviation += dartsModel.beersDrunk;
    deviation *= dartsModel.dart / 5 + 1;
    if( dartsModel.overweight == NO )
    {
        deviation += 10;
    }
    
    return deviation;
}

- (IBAction)positionCrosshair:(id)sender
{
    if( crosshair.isHidden )
    {
         crosshair.hidden = NO;
    }
    
    int horizontal = (int)(horizontalSlider.value);
    int vertical = (int)(verticalSlider.value);
    [self moveCrosshairWithX:horizontal andWithY:vertical];
}

- (void)deviateCrosshair
{
    int deviation_x = (arc4random() % (deviation*2)) - deviation;
    int deviation_y = (arc4random() % (deviation*2)) - deviation;
    
    int horizontal = (int)(horizontalSlider.value) + deviation_x;
    int vertical = (int)(verticalSlider.value) + deviation_y;
    
    [self moveCrosshairWithX:horizontal andWithY:vertical];
}

- (void)moveCrosshairWithX:(int)x andWithY:(int)y
{
    NSInteger toX = x+50;
    NSInteger toY = y+20;
    
    [UIView beginAnimations:nil context:NULL]; // animate the following:
    crosshair.center = CGPointMake(toX, toY);
    [UIView setAnimationDuration:0.1];
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fire
{
    int horizontal = crosshair.center.x - 50;
    int vertical = crosshair.center.y - 20;

    double distance = sqrt(  pow((double)horizontal - 100, 2) + pow((double)vertical - 100, 2) );
    double angle = atan((((double)horizontal - 100) / (100 - (double)vertical)) ) * ( 180 / M_PI);
    
    if( vertical > 100 ){
        angle = angle + 180;
    }else if( horizontal < 100 && vertical <= 100 ){
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
    
    bool bouncer = [self checkBouncerWithAngle:angle AndDistance:distance];
    
    if(bouncer == YES)
    {
        points = 0;
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
