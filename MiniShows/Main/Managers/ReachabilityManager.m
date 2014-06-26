//
//  ReichabilityManager.m
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ReachabilityManager.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>

NSString *const ReachabilityServiceChangeWifiConnection = @"ReachabilityServiceChangeWifiConnection";
NSString *const ReachabilityServiceChangeWANConnection = @"ReachabilityServiceChangeWANConnection";
NSString *const ReachabilityServiceChangeNotConnection = @"ReachabilityServiceChangeNotConnection";
@implementation ReachabilityManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    [[NSNotificationCenter defaultCenter] postNotificationName:ReachabilityServiceChangeNotConnection object:nil];
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [[NSNotificationCenter defaultCenter] postNotificationName:ReachabilityServiceChangeWifiConnection object:nil];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    [[NSNotificationCenter defaultCenter] postNotificationName:ReachabilityServiceChangeWANConnection object:nil];
                    break;
                default:
                    [[NSNotificationCenter defaultCenter] postNotificationName:ReachabilityServiceChangeNotConnection object:nil];
                    break;
            }
        }];
    }
    return self;
}

@end
