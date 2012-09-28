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
    if (self = [super init]) {
        NSLog(@"test");
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
        
        self.level = [[settings objectForKey:@"level"] intValue];
        self.overweight = [[settings objectForKey:@"overweight"] boolValue];
        self.dart = [[settings objectForKey:@"overweight"] intValue];
        self.beersDrunk = [[settings objectForKey:@"overweight"] intValue];
    }
    return self;
}

- (void)dealloc
{
    // Should never be called, but just here for clarity really.
    [super dealloc];
}

@end