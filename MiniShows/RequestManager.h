//
//  RequestManager.h
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>

typedef void (^RequestManagerSuccess)(id);
typedef void (^RequestManagerError)(NSError *);

@interface RequestManager : NSObject

@property (strong, nonatomic)NSString *baseDomain;

- (void)GET:(NSString *)path parameters:(id)parameters successBlock:(RequestManagerSuccess)successBlock errorBlock:(RequestManagerError)errorBlock;

@end
