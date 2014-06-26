//
//  ShowProvider.m
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ShowProvider.h"
#import "TVShow.h"

@interface ShowProvider ()

@property (nonatomic)dispatch_queue_t dispatchQueue;

@end

@implementation ShowProvider

#pragma mark -
#pragma mark Lazy getting

- (dispatch_queue_t)dispatchQueue {
    if (!_dispatchQueue) {
        _dispatchQueue = dispatch_queue_create("com.minishows.showprovider.queue", DISPATCH_QUEUE_SERIAL);
    }
    
    return _dispatchQueue;
}

#pragma mark -
#pragma mark Instance methods

- (void)getAllShowsWithSuccessBlock:(RequestManagerSuccess)successBlock errorBlock:(RequestManagerError)errorBlock {
    NSMutableArray *showsArray = [[NSMutableArray alloc] init];
    RequestManager *manager = [[RequestManager alloc] init];
    [manager GET:@"shows.json" parameters:nil successBlock:^(id responseObject) {
        dispatch_async(self.dispatchQueue, ^{
            for (NSDictionary *showDictionary in [responseObject valueForKey:@"shows"]) {
                TVShow *show = [TVShow tvShowWithId:[showDictionary valueForKey:@"id"]
                                               Name:[showDictionary valueForKey:@"title"]
                                            Summary:[showDictionary valueForKey:@"description"]
                                          PosterUrl:[showDictionary valueForKey:@"posterURL"]
                                       AndBannerUrl:[showDictionary valueForKey:@"bannerURL"]];
                [showsArray addObject:show];
            }
            successBlock(showsArray);
        });
    } errorBlock:^(NSError *error) {
        NSLog(@"%@", error);
        errorBlock(error);
    }];
}

@end