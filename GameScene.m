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


@implementation GameScene

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
    //touchPoints = [[NSMutableArray array] retain];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
    CGSize size = [[CCDirector sharedDirector] winSize];
    label.position =  ccp( size.width /2 , size.height/2 );
    [self addChild: label];
    
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
    // move the points up
    //[self movePoints:touchPoints x:0 y:1];
    
    // remove off screen points
    //[self removeOffScreenPoints:touchPoints];
}

// goddamnit obj-c
- (void) movePoints:(NSMutableArray *)points x:(CGFloat)x y:(CGFloat)y {
    for (int i = 0; i < [points count]; i++) {
        CGPoint tp = [[points objectAtIndex:i] CGPointValue];
        tp.x += x;
        tp.y += y;
        [points replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:tp]];
    }
}

- (void) removeOffScreenPoints:(NSMutableArray *)points {
    for (int i = 0; i < [points count]; i++) {
        CGPoint tp = [[points objectAtIndex:i] CGPointValue];
        CGSize s = [[CCDirector sharedDirector] winSize];
        
        if (tp.x < 0 || tp.x > s.width || tp.y < 0 || tp.y > s.height) {
            [points removeObjectAtIndex:i];
            return; // todo: optimize: only removes 1 point per frame
        }
            
        [points replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:tp]];
    }
}

#pragma mark - touch handlers

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    Sprite *sprite = [Sprite spriteWithPosition:touchPoint];
    
    currentSpriteGroup = [[SpriteGroup spriteGroup] retain];
    [currentSpriteGroup addChild:sprite];
    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    Sprite *sprite = [Sprite spriteWithPosition:touchPoint];
    
    [currentSpriteGroup addChild:sprite];
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [self addChild:currentSpriteGroup];
    [currentSpriteGroup release];
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
	// do stuff
}

- (void) draw {
    //ccDrawColor4B(0, 0, 0, 255); // openGL ES 2.0 is crazy, don't look inside!
    //ccDrawCircle(touchPoint, 10, CC_DEGREES_TO_RADIANS(90), 40, NO); // no draw color filled circle function in CCDrawingPrimitives =(
    
    // rectangles are cool too, right?
    
//    for (int i = 0; i < [touchPoints count]; i++) {
//        CGPoint tp = [[touchPoints objectAtIndex:i] CGPointValue];
//        
//        CGPoint p1 = ccp(tp.x - 25, tp.y - 25);
//        CGPoint p2 = ccp(tp.x + 25, tp.y + 25);
//        ccDrawSolidRect(p1, p2, ccc4f(1, 1, 0, 1)); // drawing white doesn't work?
//    }
    
}

@end
