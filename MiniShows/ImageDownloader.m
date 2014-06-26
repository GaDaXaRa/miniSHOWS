//
//  ImageDownloader.m
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 26/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ImageDownloader.h"

@interface ImageDownloader ()

@property (nonatomic)dispatch_queue_t dispatchQueue;

@end

@implementation ImageDownloader

- (dispatch_queue_t)dispatchQueue {
    if (!_dispatchQueue) {
        _dispatchQueue = dispatch_queue_create("com.minishows.imagedownloader.queue", DISPATCH_QUEUE_CONCURRENT);
    }
    
    return _dispatchQueue;
}

+ (instancetype)sharedImageDownloader {
    static dispatch_once_t onceToken;
    static ImageDownloader *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ImageDownloader alloc] init];
    });
    
    return instance;
}

- (void)imageFromUrl:(NSString *)url completion:(void (^)(UIImage *image))completion {
    dispatch_async(self.dispatchQueue, ^{
        UIImage *image = [self imageFromUrl:url];
        
        completion(image);
    });
}

- (UIImage *)imageFromUrl:(NSString *)imageUrl {
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:data];
}

@end