//
//  ShowProvider.h
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"


@interface ShowProvider : NSObject

- (void)getAllShowsWithSuccessBlock:(RequestManagerSuccess)successBlock errorBlock:(RequestManagerError)errorBlock;

@end
