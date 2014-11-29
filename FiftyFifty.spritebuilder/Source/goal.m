//
//  goal.m
//  FiftyFifty
//
//  Created by Justin & Yahya & Mitchell on 8/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "goal.h"

@implementation goal


- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"goal";
    self.physicsBody.sensor = TRUE;
}

@end
