//
//  Player.m
//  FiftyFifty
//
//  Created byJustin & Yahya & Mitchellon 8/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Player.h"
#import "CCEffectPixellate.h"


@implementation Player
{
    CCParticleSystem *_particles;
}

-(void) didLoadFromCCB
{
    self.physicsBody.collisionType = @"player";
    _particles.particlePositionType = CCParticleSystemPositionTypeFree;
}


@end
