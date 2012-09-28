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

@synthesize overweightSwitch, beersDrunkTextField, dartPicker, darts, overweight, dart, beersDrunk;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        plistPath = [rootPath stringByAppendingPathComponent:@"darts.plist"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"darts" ofType:@"plist"];
        }
        
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        }
        
        NSDictionary *settings = [temp objectForKey:@"settings"];
        self.overweight = [[settings objectForKey:@"overweight"] boolValue];
        self.dart = [[settings objectForKey:@"overweight"] intValue];
        self.beersDrunk = [[settings objectForKey:@"overweight"] intValue];
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
    NSLog(@"set!");
}

@end
