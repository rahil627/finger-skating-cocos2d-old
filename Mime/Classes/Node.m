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

@synthesize hitbox;

#pragma mark - overridden functions
+ (id)node {
    return [[[self alloc] node] autorelease];
}

- (id)node {
	if (!(self = [super init]))
		return nil;
    
    hitbox = CGRectMake(0, 0, 25, 25);
    
    [self schedule: @selector(update:)];
    
    return self;
}

- (void)update:(ccTime)dt {
    // move up
    self.position = ccp(self.position.x, self.position.y + POINT_MOVE_SPEED * dt * FRAME_RATE);
    
    // if off screen, remove
    if ([Library isOffScreenWithPoint:self.position])
        [self removeFromParentAndCleanup:YES];
    
    // if matched, remove
    
    
}

- (void)draw {
    ccDrawColor4F(1, 1, 1, 1);
    // todo: need to get negate the difference between touch point and creation point
    ccDrawPoint([self convertToNodeSpaceAR:self.position]);
}

@end