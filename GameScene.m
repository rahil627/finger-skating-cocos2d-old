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
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    CGSize ws = [[CCDirector sharedDirector] winSize];
    CGRect r = CGRectMake(50, 0, ws.width, 50);
    if (!(CGRectContainsPoint(r, touchPoint)))
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
