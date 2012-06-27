//
//  Sprite.m
//  Mime
//
//  Created by Rahil Patel on 6/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Sprite.h"
#import "Library.h"
#import "GameManager.h"

@implementation Sprite

#pragma mark - overridden functions
+ (id)spriteWithPosition:(CGPoint)position {
    return [[[self alloc] spriteWithPosition:position] autorelease];
}

- (id)spriteWithPosition:(CGPoint)position {
	if (!(self = [super initWithFile:@"circle.png"])) // todo: optimize: use OpenGL to draw a circle, [CCSprite node] gave error 
		return nil;
    
    [self setPosition:position];
    
    hitbox = CGRectMake(0, 0, 25, 25);
    
    [self schedule: @selector(update:)];
    
    return self;
}

- (void)update:(ccTime)dt {
    // move up
    self.position = ccp(self.position.x, self.position.y + POINT_MOVE_SPEED * dt * FRAME_RATE);
    
    // if off screen, remove
    if ([Library isOffScreenWithCCSprite:self])
        [self removeFromParentAndCleanup:YES];
    
    // if matched, remove
    
    
}

- (void)draw {
    ccDrawColor4F(1, 1, 1, 1);
    // todo: need to get negate the difference between touch point and creation point
    ccDrawPoint([self convertToNodeSpaceAR:self.position]);
}

@end