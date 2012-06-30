//
//  GameManager.m
//  Mime
//
//  Created by Rahil Patel on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager
static GameManager* _sharedGameManager = nil;

+(GameManager*)sharedGameManager
{
	@synchronized([GameManager class])
	{
		if (!_sharedGameManager)
			[[self alloc] init];
        
		return _sharedGameManager;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([GameManager class])
	{
		NSAssert(_sharedGameManager == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedGameManager = [super alloc];
		return _sharedGameManager;
	}
    
	return nil;
}

-(id)init {
	if(!(self=[super init]))
		return nil;
    
    // init stuff here
    
	return self;
}

@end
