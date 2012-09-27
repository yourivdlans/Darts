//
//  RootViewController.m
//  Darts2
//
//  Created by Youri van der Lans on 9/22/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize settingsViewController, verticalSlider, horizontalSlider, verticalPosition, horizontalPosition;

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
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Je hebt gegooid!"
                                                      message: [[NSString alloc] initWithFormat:@"horizontal: %d vertical: %d", horizontal, vertical]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    [message release];
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
