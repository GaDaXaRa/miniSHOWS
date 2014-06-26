//
//  ImageDownloader.h
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 26/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowImageCacheManager.h"

@interface ImageDownloader : NSObject

+ (instancetype)sharedImageDownloader;
- (void)imageFromUrl:(NSString *)url completion:(void (^)(UIImage *image))completion;

@end
