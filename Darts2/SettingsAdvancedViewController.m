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

@synthesize dartsModel, overweightSwitch, beersDrunkTextField, dartPicker, darts, dartPickerTextField;

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
    
    // Set dart picker values
    NSArray *temp = [[NSArray alloc] initWithObjects:@"Aluminum", @"Steel", @"Gold", nil];
    self.darts = temp;
    [temp release];
    
    // Hide keyboard / picker on view press
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    // Set default values
    [overweightSwitch setOn:self.dartsModel.overweight];
    [beersDrunkTextField setText:[NSString stringWithFormat:@"%i", self.dartsModel.beersDrunk]];
    self.dartPickerTextField.text = [darts objectAtIndex:self.dartsModel.dart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [beersDrunkTextField resignFirstResponder];
    [dartPickerTextField resignFirstResponder];
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
    self.dartPickerTextField.text = [darts objectAtIndex:row];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ( textField == dartPickerTextField )
    {
        dartPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
        dartPicker.delegate = self;
        dartPicker.dataSource = self;
        dartPicker.showsSelectionIndicator = YES;
        
        [dartPicker selectRow:self.dartsModel.dart inComponent:0 animated:NO];
        
        textField.inputView = dartPicker;
        [dartPicker release];
    }
    
    return YES;
}

@end
