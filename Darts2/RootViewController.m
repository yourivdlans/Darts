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

@synthesize settingsViewController;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
