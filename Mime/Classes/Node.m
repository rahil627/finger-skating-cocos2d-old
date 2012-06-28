//
//  Sprite.m
//  Mime
//
//  Created by Rahil Patel on 6/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Node.h"
#import "Library.h"
#import "GameManager.h"

@implementation Node

@synthesize hitbox, type;

#pragma mark - overridden functions
+ (id)node {
    return [[[self alloc] node] autorelease];
}

- (id)node {
	if (!(self = [super init]))
		return nil;
    
    hitbox = CGRectMake(0, 0, 25, 25);
    type = -1;
    
    [self schedule: @selector(update:)];
    
    return self;
}

- (void)update:(ccTime)dt {
    // move up
    self.position = ccp(self.position.x, self.position.y + POINT_MOVE_SPEED * dt * FRAME_RATE);
    
    // if off screen, remove
    if ([Library isOffScreenWithPoint:self.position])
        [self removeFromParentAndCleanup:YES];
    
    // todo: if matched, remove
    
    
}

- (void)draw {
    CGPoint p = [self convertToNodeSpaceAR:self.position];
    
    switch (type) {
        case kMiddle:
            ccDrawColor4F(1, 1, 1, 1);
            p = ccp(p.x - 10/4, p.y - 10/4);
            ccDrawSolidCircle(p, 10/2, 90, 50, NO);
            break;
            
        case kFirst:
            ccDrawColor4F(0, 1, 0, 1);
            p = ccp(p.x - 25/4, p.y - 25/4);
            ccDrawSolidCircle(p, 25/2, 90, 50, NO);
            break;
            
        case kLast:
            ccDrawColor4F(1, 0, 0, 1);
            p = ccp(p.x - 25/4, p.y - 25/4);
            ccDrawSolidCircle(p, 25/2, 90, 50, NO);
            break;
            
        default:
            CCLOGWARN(@"[Node draw] you forgot to set the node type!");
            break;
    }
}

@end