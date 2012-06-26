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
    
    return self;
}

@end
