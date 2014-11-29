//
//  Gameover.h
//  FiftyFifty
//
//  Created by Justin & Yahya & Mitchell on 8/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import <AmazonAd/AmazonAdInterstitial.h>
@class MainScene;

@interface Gameover : CCNode <AmazonAdInterstitialDelegate>

@property (nonatomic, weak) MainScene *mainScene;
@property (nonatomic, retain) AmazonAdInterstitial *interstitial;
@property (nonatomic, assign) int score;

-(void)trackGameOver;
@end
