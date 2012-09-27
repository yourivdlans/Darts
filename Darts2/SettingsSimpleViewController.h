//
//  SettingsSimpleViewController.h
//  Darts2
//
//  Created by Youri van der Lans on 9/25/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsSimpleViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDelegate>
{
    NSString *level;
}

@property (nonatomic, retain) NSString *level;

- (IBAction)setSimple:(id)sender;
- (IBAction)setIntermediate:(id)sender;
- (IBAction)setHard:(id)sender;

@end
