//
//  Gameover.m
//  FiftyFifty
//
//  Created by Justin & Yahya & Mitchell on 8/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameover.h"
#import "MainScene.h"
#import <AmazonAd/AmazonAdOptions.h>
#import <AmazonAd/AmazonAdInterstitial.h>
#import "Gamestate.h"


@implementation Gameover
{

    CCLabelTTF *_score1;
    CCLabelTTF *_highScore;
    
    BOOL didShowScreen;
}



- (void)interstitialDidLoad:(AmazonAdInterstitial *)interstitial
{
    NSLog(@"Interstial loaded.");
}

- (void)interstitialDidFailToLoad:(AmazonAdInterstitial *)interstitial withError:(AmazonAdError *)error
{
    NSLog(@"Interstitial failed to load.");
}

- (void)interstitialDidDismiss:(AmazonAdInterstitial *)interstitial{
    NSLog(@"Modal view has been dismissed, its time to resume the paused activities.");
    AmazonAdOptions *adOptions = [AmazonAdOptions options];
    
    
    [self.interstitial load:adOptions];
}

-(void)didLoadFromCCB {
    
    
    self.interstitial = [AmazonAdInterstitial amazonAdInterstitial];
    self.interstitial.delegate = self;
    AmazonAdOptions *adOptions = [AmazonAdOptions options];
    
    
    [self.interstitial load:adOptions];

}

- (void)restart:(id)sender
{
   
    [self.mainScene restart];
}


-(void) playEffect
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"button.wav"];
}

-(void) setScore: (int)score
{
    long highScore = [[Gamestate sharedInstance] getHighScore];
    if (score > highScore) {
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"HighScore"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        highScore = score;
    }
    
    _score1.string = [NSString stringWithFormat:@"%i", score];
    _highScore.string = [NSString stringWithFormat:@"%li", highScore];
}





-(void)trackGameOver {
        NSInteger gamesPlayed = [[NSUserDefaults standardUserDefaults] integerForKey:@"gamesPlayed"];
        gamesPlayed++;
        [[NSUserDefaults standardUserDefaults] setInteger:gamesPlayed forKey:@"gamesPlayed"];
        if (gamesPlayed % 2 == 0) {
            if (self.interstitial.isReady) {
                [self.interstitial presentFromViewController:[CCDirector sharedDirector]];
            }
        }
}


@end

