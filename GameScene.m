//
//  MyCocos2DClass.m
//  Mime
//
//  Created by Rahil Patel on 6/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "Sprite.h"
#import "SpriteGroup.h"
#import "SpriteGroupGroup.h"

@implementation GameScene

#pragma mark - overridden functions
+ (CCScene *) scene {
	CCScene *scene = [CCScene node];
	GameScene *layer = [GameScene node];
	[scene addChild: layer];
	
	return scene;
}

- (id) init {
	if(!(self=[super init]))
        return nil;
    
    [self setIsTouchEnabled:YES];
    
    spriteGroupGroup = [[SpriteGroupGroup spriteGroupGroup] retain];
    [self addChild:spriteGroupGroup];
    
    CGSize ws = [[CCDirector sharedDirector] winSize];
    CGRect bottomTouchAreaRectangle = CGRectMake(50, 0, ws.width, 50);
    bottomTouchArea = [CCSprite spriteWithFile:@"white.png" rect:bottomTouchAreaRectangle];
    bottomTouchArea.color = ccc3(0, 255, 255);
    bottomTouchArea.opacity = 255/2;
    bottomTouchArea.position = ccp(ws.width/2, 25);
    [self addChild:bottomTouchArea z:10];
    
    
    [self schedule: @selector(update:)];
    
    return self;
}

- (void)onEnter {
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:0 swallowsTouches:NO];
    [super onEnter];
}

- (void)onExit {
    [[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
    [super onExit];
}

- (void) dealloc {
	[super dealloc];
}

#pragma mark - private functions
- (void)update:(ccTime)dt {
    
}

#pragma mark - touch handlers
// create points
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    if (!(CGRectContainsPoint(bottomTouchArea.textureRect, touchPoint)))
        return NO;
    //return CGRectContainsPoint(r, [self convertTouchToNodeSpaceAR:touch]); //self.textureRect wasn't working correctly
    
    Sprite *sprite = [Sprite spriteWithPosition:touchPoint];
    currentSpriteGroup = [[SpriteGroup spriteGroup] retain];
    [spriteGroupGroup addChild:currentSpriteGroup];
    [currentSpriteGroup addChild:sprite];
    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    Sprite *sprite = [Sprite spriteWithPosition:ccp(touchPoint.x, 50)];
    [currentSpriteGroup addChild:sprite];
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [currentSpriteGroup release];
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
	// do stuff
}

@end
