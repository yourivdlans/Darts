//
//  AppDelegate.h
//  Darts2
//
//  Created by Youri van der Lans on 9/22/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
//    UINavigationController *navigationController;
    RootViewController *rootViewController;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
//@property (retain, nonatomic) IBOutlet UINavigationController *navigationController;
@property (retain, nonatomic) IBOutlet RootViewController *rootViewController;

@end
