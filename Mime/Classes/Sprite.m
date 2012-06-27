//
//  Sprite.m
//  Mime
//
//  Created by Rahil Patel on 6/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Sprite.h"
#import "Library.h"

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
    
    [self schedule: @selector(update:)];
    
    return self;
}

- (void)update:(ccTime)dt {
    // move up
    self.position = ccp(self.position.x, self.position.y + 1);
    
    // if off screen, remove
    if ([Library isOffScreenWithCCSprite:self])
        [self removeFromParentAndCleanup:YES];
    
    // if matched, remove
    
    
}

//- (void) draw {
//    ccDrawColor4B(0, 0, 0, 255); // openGL ES 2.0 is crazy, don't look inside!
//    ccDrawCircle(touchPoint, 10, CC_DEGREES_TO_RADIANS(90), 40, NO); // no draw color filled circle function in CCDrawingPrimitives =(
//
//    // rectangles are cool too, right?
//
//        for (int i = 0; i < [touchPoints count]; i++) {
//            CGPoint tp = [[touchPoints objectAtIndex:i] CGPointValue];
//            
//            CGPoint p1 = ccp(tp.x - 25, tp.y - 25);
//            CGPoint p2 = ccp(tp.x + 25, tp.y + 25);
//            ccDrawSolidRect(p1, p2, ccc4f(1, 1, 0, 1)); // drawing white doesn't work?
//        }
//    
//}

#pragma mark - touch handlers
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
}
- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    
}

@end