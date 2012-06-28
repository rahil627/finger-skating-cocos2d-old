//
//  Sprite.h
//  Mime
//
//  Created by Rahil Patel on 6/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Node : CCNode {
    CGRect hitbox;
}

@property (nonatomic, readwrite, assign) CGRect hitbox;

+ (id)node;

@end