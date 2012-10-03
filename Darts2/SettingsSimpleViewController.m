//
//  SettingsSimpleViewController.m
//  Darts2
//
//  Created by Youri van der Lans on 9/25/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import "SettingsSimpleViewController.h"

@interface SettingsSimpleViewController ()

@end

@implementation SettingsSimpleViewController

@synthesize dartsModel, levelPicker, levels, levelPickerTextField;

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
    NSArray *temp = [[NSArray alloc] initWithObjects:@"Easy", @"Medium", @"Hard", nil];
    self.levels = temp;
    [temp release];
    
    // Hide picker on view press
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    // Set default values
    self.levelPickerTextField.text = [levels objectAtIndex:self.dartsModel.level];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissPicker {
    [levelPickerTextField resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [levels count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [levels objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.dartsModel.level = row;
    self.levelPickerTextField.text = [levels objectAtIndex:row];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ( textField == levelPickerTextField )
    {
        levelPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
        levelPicker.delegate = self;
        levelPicker.dataSource = self;
        levelPicker.showsSelectionIndicator = YES;
        
        [levelPicker selectRow:self.dartsModel.level inComponent:0 animated:NO];
        
        textField.inputView = levelPicker;
        [levelPicker release];
    }
    
    return YES;
}

@end
