//
//  UIImageView+ImageWithUrl.h
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 26/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ImageWithUrl)

- (void)setImageWithUrl:(NSString *)url completion:(void (^)(BOOL finish))completionBlock;

@end
