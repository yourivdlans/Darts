//
//  DartsModel.m
//  Darts2
//
//  Created by Youri van der Lans on 9/28/12.
//  Copyright (c) 2012 Youri van der Lans. All rights reserved.
//

#import "DartsModel.h"

static DartsModel *dartsModel = nil;

@implementation DartsModel

@synthesize level, overweight, beersDrunk, dart;

#pragma mark Singleton Methods
+ (id)sharedManager
{
    @synchronized(self) {
        if(dartsModel == nil)
            dartsModel = [[super allocWithZone:NULL] init];
    }
    
    return dartsModel;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedManager] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX; //denotes an object that cannot be released
}

- (oneway void)release
{
    // never release
}

- (id)autorelease
{
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        plistPath = [rootPath stringByAppendingPathComponent:@"darts.plist"];
        
        NSLog(@"%@", plistPath);
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            plistPath = [[NSBundle mainBundle] pathForResource:@"darts" ofType:@"plist"];
        }
        
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!temp)
        {
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        }
        
        NSDictionary *settings = [temp objectForKey:@"settings"];
        
        NSLog(@"%@", plistPath);
        
        level = [[settings objectForKey:@"level"] intValue];
        overweight = [[settings objectForKey:@"overweight"] boolValue];
        dart = [[settings objectForKey:@"dart"] intValue];
        beersDrunk = [[settings objectForKey:@"beers_drunk"] intValue];
        
        NSLog(@"%i", level);
        NSLog(@"%i", overweight);
        NSLog(@"%i", dart);
        NSLog(@"%i", beersDrunk);
    }
    
    return self;
}

- (void)dealloc
{
    // Should never be called, but just here for clarity really.
    [super dealloc];
}

- (void)writeSettings
{
    NSLog(@"try to write settings");
    
    NSNumber *tmpLevel = [NSNumber numberWithInt:level];
    NSNumber *tmpOverweight = [NSNumber numberWithBool:overweight];
    NSNumber *tmpDart = [NSNumber numberWithInt:dart];
    NSNumber *tmpBeersDrunk = [NSNumber numberWithInt:beersDrunk];
    
    NSLog(@"%@", tmpLevel);
    NSLog(@"%@", tmpOverweight);
    NSLog(@"%@", tmpDart);
    NSLog(@"%@", tmpBeersDrunk);
    
    NSArray *temp = [NSArray arrayWithObjects:tmpLevel, tmpOverweight, tmpDart, tmpBeersDrunk, nil];
    
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"darts.plist"];
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects: temp forKeys:[NSArray arrayWithObjects: @"level", @"overweight", @"dart", @"beers_drunk", nil]];
    NSDictionary *settingsPlistDict = [NSDictionary dictionaryWithObject:plistDict forKey:@"settings"];
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:settingsPlistDict
                                                        format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    
    if(plistData)
    {
        [plistData writeToFile:plistPath atomically:YES];
        NSLog(@"settings written");
    }
    else
    {
        NSLog(@"%@", error);
        [error release];
    }
}

@end