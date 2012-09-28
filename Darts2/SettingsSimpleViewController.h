//
//  SettingsSimpleViewController.h
//  Darts2
//
//  Created by Youri van der Lans on 9/25/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsSimpleViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView *levelPicker;
    NSArray *levels;
    int currentLevel;
}

@property (nonatomic, retain) IBOutlet UIPickerView *levelPicker;
@property (nonatomic, retain) IBOutlet NSArray *levels;
@property (nonatomic) int currentLevel;

@end
