//
//  UIImageView+ImageWithUrl.m
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 26/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "UIImageView+ImageWithUrl.h"
#import "ImageDownloader.h"

@implementation UIImageView (ImageWithUrl)

- (void)setImageWithUrl:(NSString *)url completion:(void (^)(BOOL finish))completionBlock {
    self.image = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [[ImageDownloader sharedImageDownloader] imageFromUrl:url completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    self.image = image;
                }                
                completionBlock(image ? YES : NO);
            });
        }];
    });
}

@end
