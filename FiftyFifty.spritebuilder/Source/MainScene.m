//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Justin & Yahya & Mitchell on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Player.h"
#import "Gameover.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "goal.h"
#import "Gamestate.h"
#import "Player2.h"
#import "Pattern1.h"


static  CGFloat scrollSpeed = 500.f;

@implementation MainScene
{
    Player *player;
    Player2 *player2;
    CCPhysicsNode *_physicsNode;
    CCNodeColor *_background1;
    CCNodeColor *_background2;
    CCNode *_scroller;
    NSArray *_backgrounds;
    BOOL _loadPattern;
    CCNode * _pattern;
    BOOL presentedGameOver;
    float timerTillScrollFaster;
    
    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_highscoreLabel;
    

    CCSprite *_wall;
    CCNode *_testicles;
    int points;

    
    float _timeSinceObstacle;
    CCLabelTTF *_instructions;
    
    BOOL _gameOver;
    CCNodeColor *_bottomFloor;
    CCSprite *_finger;
    CCNodeColor *_side;
    CCNodeColor *_side2;
    
    float totalGameTime;
    
    bool paused;
    Gameover *_gameOverScreen;
    
    BOOL didShowScreen;
    
    NSMutableArray* _obstacles;
    BOOL _tapped;
    
    Pattern1 *_obstacle1;
    Pattern1 *_wall1;
    Pattern1 *_wall2;
    
}

-(void) didLoadFromCCB
{
    //_physicsNode.debugDraw = YES;
    //_physicsNode.debugDraw = YES;
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self;
    _backgrounds = @[_background1, _background2];
    _loadPattern = YES;
    
    [self loadPattern];
    
    scrollSpeed = 500.f;
    
    _timeSinceObstacle = 0.0f;
    totalGameTime = 0;
    
    paused = true;
    
    _obstacles = [NSMutableArray array];
    
    player.physicsBody.collisionGroup = @"players";
    player2.physicsBody.collisionGroup = @"players";
    
    
    
}

-(void) doGameOver
{

    [[Gamestate sharedInstance] setCurrentScore:points];

    

    _gameOverScreen.score = points;
    _gameOverScreen.mainScene = self;
    
    CCAnimationManager* animationManager = self.animationManager;
    [_gameOverScreen trackGameOver];
    [animationManager runAnimationsForSequenceNamed:@"GameoverIn"];
}

-(void) playEffect
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"button.wav"];
}

-(void)restart
{
    [[[CCDirector sharedDirector] responderManager] removeAllResponders];
    [self playEffect];
    CCAnimationManager* animationManager = self.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"GameoverOut"];

    
}



- (void)update:(CCTime)delta {
    
    if (!presentedGameOver) {
        totalGameTime += delta;
        
        // FINGER MOVING
        float centerOfScreen = _instructions.position.x;
        _finger.position = ccp(cos(totalGameTime * 3) * 70 + centerOfScreen,_finger.position.y);
        //
        
        if (paused) return;
        
        _scroller.position = ccp(_scroller.position.x , _scroller.position.y - (scrollSpeed *delta));
        // loop the ground
        
        scrollSpeed += 4.4* delta;
        // Increment the time since the last obstacle was added
        _timeSinceObstacle += delta; // delta is approximately 1/60th of a second
        
        // Check to see if two seconds have passed
        if (_timeSinceObstacle > 0.25f)
        {
            // Add a new obstacle
            [self loadPattern];
            
            // Then reset the timer.
            _timeSinceObstacle = 0.0f;
            
        }

    }
    
    for (CCNode *pattern in [_obstacles copy]) {
        // get the world position of the ground
        CGPoint patternWorldPosition = [_scroller convertToWorldSpace:pattern.position];
        // get the screen position of the ground
//        CGPoint patternScreenPosition = [self convertToNodeSpace:patternWorldPosition];
        // if the left corner is one complete width off the screen, move it to the right
        if (patternWorldPosition.y <= (-pattern.contentSize.height)) {
            [pattern removeFromParent];
            [_obstacles removeObject:pattern];
        }

        
    }
    
    if (points == 5) {
        //player.texture = [CCTexture textureWithFile:@"ccbResources/SquarePurple.png"];
//        explosion.texture = explosionPic.texture;
        
        _obstacle1.color = [CCColor redColor];


    }

    
    
}



-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair player:(CCSprite *)nodeA obstacle:(CCNode *)nodeB
{
    [nodeA removeFromParent];
    if (!_gameOver) {
        presentedGameOver = YES;
        _gameOver = YES;
        CCParticleExplosion *explosion = [[CCParticleExplosion alloc] init];
        CCSprite *explosionPic = [CCSprite spriteWithImageNamed:@"ccbResources/explosion.png"];
        explosion.texture = explosionPic.texture;
        
        explosion.color = [CCColor redColor];
        explosion.speed = 180;
        [explosion setTotalParticles:30];
        [_testicles addChild:explosion];
        explosion.position = player.position;
        scrollSpeed = 0;
        [self performSelector:@selector(doGameOver) withObject:nil afterDelay:1];
    }
    return FALSE;
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!presentedGameOver) {
        _instructions.visible = FALSE;
        _bottomFloor.visible = FALSE;
        _finger.visible = FALSE;
        [self performSelector:@selector(side) withObject:nil afterDelay:1];
        [self performSelector:@selector(side2) withObject:nil afterDelay:1];

     //   scrollSpeed = 500.f;
        paused = false;
    }

   // [[CCDirector sharedDirector] resume];
}

-(void) side
{
    _side.visible = FALSE;
}

-(void) side2
{
    _side2.visible = FALSE;
}


-(void) actualRestart
{
    
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
    [[CCDirector sharedDirector] resume];
}

-(void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!presentedGameOver) {
        CGPoint touchLocation = [touch locationInNode:self];
        float screenWidth = [[CCDirector sharedDirector] viewSize].width;
        float leftPadding = 3;
        float rightPadding = 18;
        player.position = ccp(MAX(40+leftPadding,MIN(touchLocation.x,screenWidth-32-rightPadding)), player.position.y);
    }
}



- (void) loadPattern
{
    
    CGPoint screenPosition = [self convertToWorldSpace:ccp(-118, 0)];
    CGPoint lastPosition = [_scroller convertToNodeSpace:screenPosition];
    
    CCNode *pattern;

    
    
        int random = arc4random() % 2;
        switch (random) {
                
            case 0:
                pattern = [CCBReader load:@"pattern1"];
                break;
            case 1:
                pattern = [CCBReader load:@"pattern2"];
                break;
                

        }
        
        pattern.positionInPoints = ccp(-119, lastPosition.y+290);
        [_scroller addChild:pattern];

//        lastPosition = ccp(lastPosition.x , lastPosition.y + pattern.contentSize.height);
    
        
    [_obstacles addObject:pattern];
    
    
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair player:(CCNode *)nodeA goal:(CCNode *)nodeB
{

    [nodeB removeFromParent];
    points++;
    [self showScore];
    _scoreLabel.visible = true;

    
    

    
    return false;
}


- (void)showScore
{
    _scoreLabel.string = [NSString stringWithFormat:@"%d", points];
}




@end
