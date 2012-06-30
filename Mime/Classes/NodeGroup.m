//
//  NodeGroup.m
//  Mime
//
//  Created by Rahil Patel on 6/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NodeGroup.h"
#import "Node.h"
#import "GameManager.h"

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
        ccDrawSolidCircle(p, NODE_SIZE/2, 90, 50, NO);
        return;
    }
    
    // draw a line between each point
    //ccDrawColor4F(lineColor.r, lineColor.g, lineColor.b, lineColor.a);
    //glLineWidth(NODE_SIZE);
    
    //GLfloat v;
    //glGetFloatv(GL_ALIASED_LINE_WIDTH_RANGE, &v); // todo: limitation: max line width is 1
    //CCLOG(@"v: %f", v);
    //glDisable(GL_LINE_SMOOTH); // does not exist in OpenGL 2.0?
    //may just need to draw a rectangle, which will be used for detecting touches anyway
    ccDrawColor4F(lineColor.r, lineColor.g, lineColor.b, lineColor.a);
    // draw a rectangle between each point
    CGPoint p1, p2, vertices[4];
    for (int i = 0; i < [[self children] count] - 1; i++) {
        p1 = ((CCNode*)[[self children] objectAtIndex:i]).position;
        p2 = ((CCNode*)[[self children] objectAtIndex:i + 1]).position;
        
        ccDrawColor4F(lineColor.r, lineColor.g, lineColor.b, lineColor.a);
        //ccDrawLine(p1, p2);
        [self getRectangleVerticesWithPoint:p1 point2:p2 arrayToStoreIn:vertices];
        ccDrawPoly(vertices, 4, YES);
        
        if (IS_DEBUGGING) {
            ccDrawColor4F(0, 0, 1, 1);
            ccDrawSolidCircle(vertices[0], 10, 90, 5, NO);
            ccDrawSolidCircle(vertices[1], 10, 90, 5, NO);
            ccDrawSolidCircle(vertices[2], 10, 90, 5, NO);
            ccDrawSolidCircle(vertices[3], 10, 90, 5, NO);
        }
    }
    
    [super draw];
}

// returns an autorelease array with the 4 vertices
- (void)getRectangleVerticesWithPoint:(CGPoint)p1 point2:(CGPoint)p2 arrayToStoreIn:(CGPoint *) a {
    // create angled rectangle between two points // todo: could create a single polygon
    // http://www.cocos2d-iphone.org/forum/topic/17387
    // also see CGAffineTransform
    
    CGPoint bottomLeftPoint, topLeftPoint, topRightPoint, bottomRightPoint;
    CGFloat hWidth, hHeight, _xpos, _ypos, tX, tY, rad;
    
    // hWidth, hHeight = half the rectangle's width & height
    hWidth = ccpDistance(p1, p2)/2;
    hHeight = NODE_SIZE/2;
    
    // _xpos, _ypos = center position of the rectangle
    //Midpoint AB = (x1 + x2) /2 , (y1 + y2)/2
    _xpos = (p1.x + p2.x)/2;
    _ypos = (p1.y + p2.y)/2;
    
    rad = -ccpAngle(p1, p2);
    if (p1.x > p2.x) // drawing from right to left
        rad = -rad;
    CCLOG(@"rad: %f", rad);
    
    tX = -(hWidth * cosf(rad) - hHeight * sinf(rad) ) + _xpos;
    tY = -(hWidth * sinf(rad) + hHeight * cosf(rad) ) + _ypos;
    bottomLeftPoint = ccp(tX, tY);
    
    tX = -(hWidth * cosf(rad) + hHeight * sinf(rad) ) + _xpos;
    tY = -(hWidth * sinf(rad) - hHeight * cosf(rad) ) + _ypos;
    topLeftPoint = ccp(tX, tY);
    
    tX = (hWidth * cosf(rad) - hHeight * sinf(rad) ) + _xpos;
    tY = (hWidth * sinf(rad) + hHeight * cosf(rad) ) + _ypos;
    topRightPoint = ccp(tX, tY);
    
    tX = (hWidth * cosf(rad) + hHeight * sinf(rad) ) + _xpos;
    tY = (hWidth * sinf(rad) - hHeight * cosf(rad) ) + _ypos;
    bottomRightPoint = ccp(tX, tY);
    
    //ccDrawSolidRect(rp2, rp4, lineColor); // only use to draw non-angled rectangles
    // CGRect is also useless
    
    a[0] = topLeftPoint;
    a[1] = topRightPoint;
    a[2] = bottomRightPoint;
    a[3] = bottomLeftPoint;
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
    
    // if single
    
    // if line
    
    // if touch began on first node
    for (int i = 0; i < [[self children] count]; i++) {
        Node* n = (Node*)[[self children] objectAtIndex:i];
        
        if (n.type == kFirst) { // todo: optimize: just access the first child
            CGRect hitbox = CGRectMake(n.position.x - NODE_SIZE/2, n.position.y - NODE_SIZE/2, NODE_SIZE, NODE_SIZE);
            
            if ((CGRectContainsPoint(hitbox, [self convertTouchToNodeSpaceAR:touch]))) {
                CCLOG(@"first point touched!");
                //[self removeFromParentAndCleanup:YES]; // if missed beginning point, change color
                return YES;
            }
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
    
    if ([[self children] count] < 1)
        return;
    
    //CCLOG(@"stop touching me!");
    //[self removeFromParentAndCleanup:YES];
    
    // if touch is within the current node's hitbox or the current space between two nodes
    // hrm...
    // TODO: STOPPED HERE
    
    // sloppy implementation, checks entire nodegroup
    CGFloat x, y, w, h;
    for (int i = 0; i < [[self children] count]; i++) {
        Node* n = (Node*)[[self children] objectAtIndex:i];
        
        // if touching node
        CGRect nodeHitbox = CGRectMake(n.position.x - NODE_SIZE/2, n.position.y - NODE_SIZE/2, NODE_SIZE, NODE_SIZE);
        
        if ((CGRectContainsPoint(nodeHitbox, [self convertTouchToNodeSpaceAR:touch]))) {
            //CCLOG(@"you're still touching a node in the nodegroup");
            return;
        }
        
        // if touching between two nodes
        
        if ([[self children] count] == 1)
            return;
        
        if (i == [[self children] count])
            return;
        
        //Node* n2 = (Node*)[[self children] objectAtIndex:i + 1];
        
        //x = n.position.x
        //CGRect lineHitbox = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        // would need to use pointInPoly
        
    }
    
    //CCLOG(@"you lose, good day sir!");
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    // if touch ended on last node
    for (int i = 0; i < [[self children] count]; i++) {
        Node* n = (Node*)[[self children] objectAtIndex:i];
        
        if (n.type == kLast) { // todo: optimize: just access the last child
            CGRect hitbox = CGRectMake(n.position.x - NODE_SIZE/2, n.position.y - NODE_SIZE/2, NODE_SIZE, NODE_SIZE);
            
            if ((CGRectContainsPoint(hitbox, [self convertTouchToNodeSpaceAR:touch]))) {
                CCLOG(@"successfully ended touch on last node");
            }
        }
    }
    
}
- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    
}

@end
