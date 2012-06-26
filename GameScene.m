//
//  MyCocos2DClass.m
//  Mime
//
//  Created by Rahil Patel on 6/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	GameScene *layer = [GameScene node];
	[scene addChild: layer];
	
	return scene;
}

-(id) init {
	if(!(self=[super init]))
        return nil;
    
    [self setIsTouchEnabled:YES];
    touchPoint = CGPointZero;
    touchPoints = [[NSMutableArray array] retain];
    
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
    [touchPoints release];
	[super dealloc];
}

#pragma mark - private functions
- (void)update: (ccTime)dt {
    CCLOG(@"touch point x:%f y:%f", touchPoint.x, touchPoint.y);
}

#pragma mark - touch handlers

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    [touchPoints addObject:[NSValue valueWithCGPoint:touchPoint]];
    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    [touchPoints addObject:[NSValue valueWithCGPoint:touchPoint]];
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    // do stuff
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
	// do stuff
}

- (void) draw {    
    //ccDrawColor4B(0, 0, 0, 255); // openGL ES 2.0 is crazy, don't look inside!
    //ccDrawCircle(touchPoint, 10, CC_DEGREES_TO_RADIANS(90), 40, NO); // no draw color filled circle function in CCDrawingPrimitives =(
    
    // rectangles are cool too, right?
    
    for (int i; i < [touchPoints count]; i++) {
        CGPoint tp = [[touchPoints objectAtIndex:i] CGPointValue];
        
        CGPoint p1 = ccp(tp.x - 5, tp.y - 5);
        CGPoint p2 = ccp(tp.x + 5, tp.y + 5);
        ccDrawSolidRect(p1, p2, ccc4f(1, 1, 0, 1)); // drawing white doesn't work?
    }
    
}

@end
