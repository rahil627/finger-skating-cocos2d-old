//
//  Sprite.h
//  Mime
//
//  Created by Rahil Patel on 6/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum NodeType { // todo: did this because I had troubles with the subclass not updating
    kFirst,
    kMiddle,
    kLast
};

@interface Node : CCNode {
    CGRect hitbox; // todo: currently not used
    int type;
}

@property (nonatomic, readwrite, assign) CGRect hitbox;
@property (nonatomic, readwrite, assign) int type;

+ (id)node;

@end