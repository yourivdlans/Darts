//
//  SettingsAdvancedViewController.h
//  Darts2
//
//  Created by Youri van der Lans on 9/25/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DartsModel.h"

@interface SettingsAdvancedViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    DartsModel *dartsModel;
    
    UISwitch *overweightSwitch;
    UITextField *beersDrunkTextField;
    UIPickerView *dartPicker;
    NSArray *darts;
    UITextField *dartPickerTextField;
}

@property (nonatomic, retain) DartsModel *dartsModel;

@property (nonatomic, retain) IBOutlet UISwitch *overweightSwitch;
@property (nonatomic, retain) IBOutlet UITextField *beersDrunkTextField;
@property (nonatomic, retain) IBOutlet UIPickerView *dartPicker;
@property (nonatomic, retain) IBOutlet NSArray *darts;
@property (nonatomic, retain) IBOutlet UITextField *dartPickerTextField;

- (IBAction)setAdvancedSetting:(id)sender;

@end
