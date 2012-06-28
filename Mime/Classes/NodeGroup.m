//
//  NodeGroup.m
//  Mime
//
//  Created by Rahil Patel on 6/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NodeGroup.h"

@implementation NodeGroup

#pragma mark - overridden functions
+ (id)nodeGroup {
    return [[[self alloc] nodeGroup] autorelease];
}

- (id)nodeGroup {
	if (!(self = [super init]))
		return nil;
    
    lineColor = ccc4f(CCRANDOM_0_1(), CCRANDOM_0_1(), CCRANDOM_0_1(), 1);
    
    return self;
}

- (void)draw {
    if ([[self children] count] < 1)
        return;
    
    if ([[self children] count] == 1) {
        // draw a point
        CGPoint p = ((CCNode*)[[self children] objectAtIndex:0]).position;
        ccDrawColor4F(0, 1, 0, 1);
        ccDrawSolidCircle(p, 25/2, 90, 50, NO);
        return;
    }
    
    // draw a line between each point
    ccDrawColor4F(lineColor.r, lineColor.g, lineColor.b, lineColor.a);
    glLineWidth(25.0f);
    
    for (int i = 0; i < [[self children] count] - 1; i++) {
        CGPoint p1 = ((CCNode*)[[self children] objectAtIndex:i]).position;
        CGPoint p2 = ((CCNode*)[[self children] objectAtIndex:i + 1]).position;
        ccDrawLine(p1, p2);
    }
    
    [super draw];
}

#pragma mark - touch handlers
- (void)onEnter
{
	CCDirector *director =  [CCDirector sharedDirector];
    
	[[director touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	CCDirector *director = [CCDirector sharedDirector];
    
	[[director touchDispatcher] removeDelegate:self];
	[super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    //CGPoint touchPoint = [touch locationInView:[touch view]];
    //touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    //CCLOG(@"touchPoint (%f, %f)", touchPoint.x, touchPoint.y);
    //CCLOG(@"hitbox: (%f, %f)", hitbox.origin.x, hitbox.origin.y);
    //CCLOG(@"nodespace (%f, %f), nodespaceAR (%f, %f)", [self convertTouchToNodeSpace:touch].x, [self convertTouchToNodeSpace:touch].y,[self convertTouchToNodeSpaceAR:touch].x, [self convertTouchToNodeSpaceAR:touch].y);
    
    // if touching point
    for (int i = 0; i < [[self children] count]; i++) {
        // if touching first point
        
        
        CCNode* p = (CCNode*)[[self children] objectAtIndex:i];
        CGRect hitbox = CGRectMake(p.position.x - 25/2, p.position.y - 25/2, 25, 25);
        
        //CCLOG(@"hitbox: (%f, %f)", hitbox.origin.x, hitbox.origin.y);
        
        if ((CGRectContainsPoint(hitbox, [self convertTouchToNodeSpaceAR:touch]))) {
            CCLOG(@"stop touching me!");
            [self removeFromParentAndCleanup:YES];
        }
    }
    
    return NO; // claim touch?
}

//- (BOOL)containsTouchLocation:(UITouch *)touch {
//	CGPoint p = [self convertTouchToNodeSpaceAR:touch];
//	CGRect r = [self rectInPixels];
//	return CGRectContainsPoint(r, p);
//}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event { // hmmmm, may be better to have a single touch and check multiple sprite groups
    
    //if (!(CGRectContainsPoint(hitbox, [self convertTouchToNodeSpaceAR:touch])))
        //return;
    
    //CCLOG(@"stop touching me!");
    //[self removeFromParentAndCleanup:YES];
    
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
}
- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    
}

@end
