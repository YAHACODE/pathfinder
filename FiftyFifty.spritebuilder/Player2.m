//
//  Player2.m
//  FiftyFifty
//
//  Created by Justin Matsnev on 9/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Player2.h"

@implementation Player2
{
    CCParticleSystem *_particles;
}

-(void) didLoadFromCCB
{
    self.physicsBody.collisionType = @"player2";
    _particles.particlePositionType = CCParticleSystemPositionTypeFree;
}

@end
