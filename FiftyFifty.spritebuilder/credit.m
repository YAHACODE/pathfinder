//
//  credit.m
//  FiftyFifty
//
//  Created by yahya on 8/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "credit.h"
#import "StartScene.h"


@implementation credit
{

}

-(void) playEffect
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"button.wav"];
}


-(void)credit
{
    [self playEffect];
    CCScene *StartScene = [CCBReader loadAsScene:@"StartScene"];
    [[CCDirector sharedDirector] replaceScene:StartScene];
    NSLog(@"clicked");
}




@end
