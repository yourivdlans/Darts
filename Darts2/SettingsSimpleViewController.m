//
//  SettingsSimpleViewController.m
//  Darts2
//
//  Created by Youri van der Lans on 9/25/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import "SettingsSimpleViewController.h"

#define dataPath @"darts.plist"

@interface SettingsSimpleViewController ()

@end

@implementation SettingsSimpleViewController

@synthesize dartsModel, levelPicker, levels;

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
    
//    CGFloat dX=levelPicker.bounds.size.width/2, dY=levelPicker.bounds.size.height/2;
//    levelPicker.transform = CGAffineTransformTranslate(CGAffineTransformScale(CGAffineTransformMakeTranslation(-dX, -dY), 0.6, 0.6), dX, dY);
    
    [levelPicker selectRow:self.dartsModel.level inComponent:0 animated:NO];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}

@end
