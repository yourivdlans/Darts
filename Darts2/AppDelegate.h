//
//  AppDelegate.h
//  Darts2
//
//  Created by Youri van der Lans on 9/22/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DartsModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    DartsModel *dartsModel;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) DartsModel *dartsModel;

@end
