//
//  Sprite.m
//  Mime
//
//  Created by Rahil Patel on 6/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite

#pragma mark - overridden functions
+ (id)spriteWithPosition:(CGPoint)position {
    return [[[self alloc] spriteWithPosition:position] autorelease];
}

- (id)spriteWithPosition:(CGPoint)position {
	if (!(self = [super initWithFile:@"circle.png"])) // todo: optimize: use OpenGL to draw a circle
		return nil;
    
    [self setPosition:position];
    
    // random color circle
    [self setColor:ccc3(CCRANDOM_0_1() * 230 + 25, CCRANDOM_0_1() * 230 + 25, CCRANDOM_0_1() * 230 + 25)];
    
    return self;
}

@end