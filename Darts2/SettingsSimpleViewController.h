//
//  SettingsSimpleViewController.h
//  Darts2
//
//  Created by Youri van der Lans on 9/25/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DartsModel.h"

@interface SettingsSimpleViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    DartsModel *dartsModel;
    
    UIPickerView *levelPicker;
    NSArray *levels;
}

@property (nonatomic, retain) DartsModel *dartsModel;

@property (nonatomic, retain) IBOutlet UIPickerView *levelPicker;
@property (nonatomic, retain) IBOutlet NSArray *levels;

@end
