//
//  GameManager.h
//  Mime
//
//  Created by Rahil Patel on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FRAME_RATE 60.0f
#define POINT_MOVE_SPEED 4.0f
#define NODE_SIZE 100.0f

@interface GameManager : NSObject {
    
}

+ (GameManager*)sharedGameManager;

@end