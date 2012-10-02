//
//  DartsModel.h
//  Darts2
//
//  Created by Youri van der Lans on 9/28/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DartsModel : NSObject
{
    int level;
    BOOL overweight;
    int dart;
    int beersDrunk;
}

@property (nonatomic) int level;
@property (nonatomic) BOOL overweight;
@property (nonatomic) int dart;
@property (nonatomic) int beersDrunk;

+ (id)sharedManager;
- (void)writeSettings;

@end
