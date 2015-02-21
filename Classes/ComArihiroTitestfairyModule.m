/**
 * ComArihiroTitestfairy is Copyright by Hiroki Arai.
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComArihiroTitestfairyModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TestFairy.h"

@implementation ComArihiroTitestfairyModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
    return @"e2974ca1-a63a-4634-8d3d-9c488fa4186e";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
    return @"com.arihiro.titestfairy";
}

#pragma mark Lifecycle

-(void)startup
{
    // this method is called when the module is first loaded
    // you *must* call the superclass
    [super startup];

    NSLog(@"[INFO] %@ loaded",self);
}

#pragma Public APIs

-(void)begin:(id)apitoken
{
    ENSURE_SINGLE_ARG(apitoken, NSString);

    [TestFairy begin:apitoken];

    return;
}


@end
