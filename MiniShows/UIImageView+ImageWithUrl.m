//
//  UIImageView+ImageWithUrl.m
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 26/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "UIImageView+ImageWithUrl.h"
#import "ImageDownloader.h"
#import <objc/runtime.h>

@interface UIImageView (Private)

@property (strong, nonatomic, readonly) NSOperationQueue *opertationQueue;

@end

@implementation UIImageView (ImageWithUrl)

#pragma mark -
#pragma mark Lazy getting

- (NSOperationQueue *)opertationQueue {
    NSOperationQueue *operationQueue = objc_getAssociatedObject(self, @"opertationQueue");
    if (!operationQueue) {
        operationQueue = [[NSOperationQueue alloc] init];
        objc_setAssociatedObject(self, @"opertationQueue", operationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return operationQueue;
}

#pragma mark -
#pragma mark Set image by downloading it

- (void)setImageWithUrl:(NSString *)url completion:(void (^)(BOOL finish))completionBlock {
    self.image = nil;
    //Check if there where another image downloading for this imageView, and cancell it
    if (self.opertationQueue.operations.count) {
        NSLog(@"Operation cancelled");
        [self.opertationQueue cancelAllOperations];
    }
    
    NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        __block BOOL finished = NO;
        [[ImageDownloader sharedImageDownloader] imageFromUrl:url completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    self.image = image;
                }
                completionBlock(image ? YES : NO);
                finished = YES;
            });
        }];
        while (!finished) {
            //Back here in 1 millisecond
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.001]];
        }
    }];
    
    [self.opertationQueue addOperation:operation];
}

@end
