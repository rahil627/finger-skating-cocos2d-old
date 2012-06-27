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

// todo: later
//- (BOOL)isOffScreenWithPosition:(CGPoint)position  { // todo: move to cocos2d library
//    CGPoint sgp = spriteGroup.position;
//    CGSize sgs = spriteGroup.contentSize;
//    CGSize s = [[CCDirector sharedDirector] winSize];
//    
//    if (sgp.x + sgs.width < 0 || sgp.x - sgs.width > s.width || sgp.y + sgs.height < 0 || sgp.y - sgs.height > s.height)
//        return true;
//    return false;
//}

//- (void)removeOffScreenSpriteGroups {
//    for (int i = 0; i < [[self children] count]; i++) {
//        CCSprite *spriteGroup = [[self children] objectAtIndex:i]; // todo: unsure if this is safe, may be other children in side of there! oh noes, also not casting to CCSprite
//        CGPoint sgp = spriteGroup.position;
//        CGSize sgs = spriteGroup.contentSize;
//        CGSize s = [[CCDirector sharedDirector] winSize];
//        
//        if (sgp.x + sgs.width < 0 || sgp.x - sgs.width > s.width || sgp.y + sgs.height < 0 || sgp.y - sgs.height > s.height) {
//            // todo: cleanup?
//            [[self children] removeObjectAtIndex:i];
//            return;
//        }
//    }
//}

@end
