//
//  Library.h
//  Mime
//
//  Created by Rahil Patel on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Library : NSObject

// Objective-C functions
+ (BOOL)isOffScreenWithPoint:(CGPoint)p;
+ (BOOL)isOffScreenWithCCSprite:(CCSprite*)sprite;

// C functions
+ (int)isPointInPolygonWithNumberOfVerticies:(int)nvert xVerticies:(float *)vertx yVerticies:(float *)verty testPointX:(float)testx testPointY:(float)testy;
@end
