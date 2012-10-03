//
//  SettingsViewController.m
//  Darts2
//
//  Created by Youri van der Lans on 9/24/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize window, settingsSimpleViewController, settingsAdvancedViewController;

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
    
    if ( self.settingsSimpleViewController.view.superview == nil )
    {
        if ( self.settingsSimpleViewController == nil )
        {
            SettingsSimpleViewController *tmp = [[SettingsSimpleViewController alloc] initWithNibName:@"SettingsSimpleViewController" bundle:nil];
            tmp.title = @"Simple";
            tmp.tabBarItem.image = [UIImage imageNamed:@"settings.png"];
            self.settingsSimpleViewController = tmp;
            [tmp release]; tmp = nil;
        }
    }
    
    if ( self.settingsAdvancedViewController.view.superview == nil )
    {
        if ( self.settingsAdvancedViewController == nil )
        {
            SettingsAdvancedViewController *tmp = [[SettingsAdvancedViewController alloc] initWithNibName:@"SettingsAdvancedViewController" bundle:nil];
            tmp.title = @"Advanced";
            tmp.tabBarItem.image = [UIImage imageNamed:@"settings.png"];
            self.settingsAdvancedViewController = tmp;
            [tmp release]; tmp = nil;
        }
    }
    
    if ( self.viewControllers == nil )
    {
        self.viewControllers = [NSArray arrayWithObjects:self.settingsSimpleViewController, self.settingsAdvancedViewController, nil];
    }
    
    self.window.rootViewController = self.tabBarController;
    [self.window addSubview:self.tabBarController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
