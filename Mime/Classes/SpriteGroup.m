//
//  SpriteGroup.m
//  Mime
//
//  Created by Rahil Patel on 6/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteGroup.h"

@implementation SpriteGroup

#pragma mark - overridden functions
+ (id)spriteGroup {
    return [[[self alloc] spriteGroup] autorelease];
}

- (id)spriteGroup {
	if (!(self = [super init]))
		return nil;
    
    lineColor = ccc4f(CCRANDOM_0_1(), CCRANDOM_0_1(), CCRANDOM_0_1(), 1);
    
    return self;
}

- (void)draw {
    // draw a line between each sprite
    if ([[self children] count] < 2)
        return;
    
    // todo: changing color requires a bit of work in OpenGL 2
    ccDrawColor4F(lineColor.r, lineColor.g, lineColor.b, lineColor.a);
    glLineWidth(25.0f);
    
    for (int i = 0; i < [[self children] count] - 1; i++) {
        CGPoint p1 = ((CCNode*)[[self children] objectAtIndex:i]).position;
        CGPoint p2 = ((CCNode*)[[self children] objectAtIndex:i + 1]).position;
        ccDrawLine(p1, p2);
    }
    
    [super draw];
}

@end
