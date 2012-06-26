//
//  MyCocos2DClass.h
//  Mime
//
//  Created by Rahil Patel on 6/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class SpriteGroup;
@class SpriteGroupGroup;

@interface GameScene : CCLayer {
    SpriteGroup *currentSpriteGroup;
    SpriteGroupGroup *spriteGroupGroup;
}

+ (CCScene *) scene;

@end
