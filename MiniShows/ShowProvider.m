//
//  ShowProvider.m
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ShowProvider.h"
#import "TVShow.h"

@implementation ShowProvider

- (void)getAllShowsWithSuccessBlock:(RequestManagerSuccess)successBlock errorBlock:(RequestManagerError)errorBlock {
    NSMutableArray *showsArray = [[NSMutableArray alloc] init];
    RequestManager *manager = [[RequestManager alloc] init];
    [manager GET:@"shows.json" parameters:nil successBlock:^(id responseObject) {
        for (NSDictionary *showDictionary in [responseObject valueForKey:@"shows"]) {
            TVShow *show = [TVShow tvShowWithId:[showDictionary valueForKey:@"id"]
                                           Name:[showDictionary valueForKey:@"title"]
                                        Summary:[showDictionary valueForKey:@"description"]
                                      PosterUrl:[showDictionary valueForKey:@"posterURL"]
                                   AndBannerUrl:[showDictionary valueForKey:@"bannerURL"]];
            [showsArray addObject:show];
        }
        successBlock(showsArray);
    } errorBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end