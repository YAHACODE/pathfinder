//
//  StartScene.m
//  FiftyFifty
//
//  Created by Mitchell Malinin on 8/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "StartScene.h"
#import "MainScene.h"
@implementation StartScene
{
    CCLabelTTF *_startLabel;
}

-(void)play
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio preloadEffect:@"button.wav"];
    [audio playEffect:@"button.wav"];
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
    NSLog(@"clicked");
}

-(void) playEffect
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"button.wav"];
}




-(void)credit
{
    [self playEffect];
    CCScene *credit = [CCBReader loadAsScene:@"credit"];
    [[CCDirector sharedDirector] replaceScene:credit];
    NSLog(@"clicked");
}

@end
