//
//  SpriteGroupGroup.m
//  Mime
//
//  Created by Rahil Patel on 6/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpriteGroupGroup.h"


@implementation SpriteGroupGroup

#pragma mark - overridden functions
+ (id)spriteGroupGroup {
    return [[[self alloc] spriteGroupGroup] autorelease];
}

- (id)spriteGroupGroup {
	if (!(self = [super init]))
		return nil;
    
    return self;
}

@end
