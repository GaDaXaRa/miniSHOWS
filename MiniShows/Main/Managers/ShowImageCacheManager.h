//
//  ShowImageCacheManager.h
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 26/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowImageCacheManager : NSObject

+ (instancetype)sharedCacheManager;

- (UIImage *)imageByKey:(NSString *)key;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;

@end
