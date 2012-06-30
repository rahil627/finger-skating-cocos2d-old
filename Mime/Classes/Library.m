//
//  Library.m
//  Mime
//
//  Created by Rahil Patel on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Library.h"

@implementation Library

#pragma mark - objective-C functions
+ (BOOL)isOffScreenWithPoint:(CGPoint)p  {
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    if (p.x < 0 || p.x > s.width || p.y < 0 || p.y > s.height)
        return true;
    return false;
}

+ (BOOL)isOffScreenWithCCSprite:(CCSprite*)sprite  {
    CGPoint sgp = sprite.position;
    CGSize sgs = sprite.contentSize;
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    if (sgp.x + sgs.width < 0 || sgp.x - sgs.width > s.width || sgp.y + sgs.height < 0 || sgp.y - sgs.height > s.height)
        return true;
    return false;
}

#pragma mark - C functions
+ (int)isPointInPolygonWithNumberOfVerticies:(int)nvert xVerticies:(float *)vertx yVerticies:(float *)verty testPointX:(float)testx testPointY:(float)testy {
	int i, j, c = 0;
	for (i = 0, j = nvert-1; i < nvert; j = i++) {
		if ( ((verty[i]>testy) != (verty[j]>testy)) &&
			(testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i]) )
			c = !c;
    }
	return c;
}

@end
