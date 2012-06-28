//
//  NodeGroup.h
//  Mime
//
//  Created by Rahil Patel on 6/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface NodeGroup: CCNode <CCTargetedTouchDelegate> {
    ccColor4F lineColor;
}

+ (id)nodeGroup;

@end
