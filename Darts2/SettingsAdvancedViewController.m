//
//  SettingsAdvancedViewController.m
//  Darts2
//
//  Created by Youri van der Lans on 9/25/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import "SettingsAdvancedViewController.h"

@interface SettingsAdvancedViewController ()

@end

@implementation SettingsAdvancedViewController

@synthesize dartsModel, overweightSwitch, beersDrunkTextField, dartPicker, darts;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dartsModel = [DartsModel sharedManager];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *temp = [[NSArray alloc] initWithObjects:@"Aluminum", @"Steel", @"Gold", nil];
    self.darts = temp;
    [temp release];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    [tap release];
    
    CGFloat dX=dartPicker.bounds.size.width/2, dY=dartPicker.bounds.size.height/2;
    dartPicker.transform = CGAffineTransformTranslate(CGAffineTransformScale(CGAffineTransformMakeTranslation(-dX, -dY), 0.6, 0.6), dX, dY);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [beersDrunkTextField resignFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger lengthOfString = string.length;
    
    for ( NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++ )
    {
        unichar character = [string characterAtIndex:loopIndex];
        if (character < 48) return NO; // 48 unichar for 0
        if (character > 57) return NO; // 57 unichar for 9
    }
    
    return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [darts count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [darts objectAtIndex:row];
}

- (IBAction)setAdvancedSetting:(id)sender
{
    if ( [sender isKindOfClass:[UISwitch class]] )
    {
        self.overweightSwitch = (UISwitch *)sender;
        self.dartsModel.overweight = [self.overweightSwitch isOn];
    }
    else if ( [sender isKindOfClass:[UITextField class]] )
    {
        self.beersDrunkTextField = (UITextField *)sender;
        self.dartsModel.beersDrunk = [[self.beersDrunkTextField text] intValue];
    }
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.dartsModel.dart = row;
}

@end
