//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Justin & Yahya & Mitchell on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface MainScene : CCNode <CCPhysicsCollisionDelegate>
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event;

-(void)restart;


@end
