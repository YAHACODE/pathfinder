//
//  Gamestate.h
//  FiftyFifty
//
//  Created by Justin Matsnev on 8/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gamestate : NSObject
+(id)sharedInstance;
@property (nonatomic, assign) int currentScore;
-(long)getHighScore;

@end
