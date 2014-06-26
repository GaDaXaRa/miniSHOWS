//
//  ShowImageCacheManager.m
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 26/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ShowImageCacheManager.h"

static NSString *const imageCachePath = @"showImages";
static NSString *const plistFile = @"showImages.plist";

@interface ShowImageCacheManager ()

@property (strong, nonatomic)NSDictionary *cacheDictionary;
@property (strong, nonatomic)NSString *imagesPath;

@end

@implementation ShowImageCacheManager

- (NSString *)imagesPath {
    if(!_imagesPath) {
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _imagesPath = [cachePath stringByAppendingPathComponent:imageCachePath];
    }
    
    return _imagesPath;
}

- (NSDictionary *)cacheDictionary {
    if(!_cacheDictionary) {
        NSString *plistPath = [self.imagesPath stringByAppendingPathComponent:plistFile];
        _cacheDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        if (!_cacheDictionary) {
            _cacheDictionary = [[NSDictionary alloc] init];
        }
    }
    
    return _cacheDictionary;
}

+ (instancetype)sharedCacheManager {
    static dispatch_once_t onceToken;
    static ShowImageCacheManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ShowImageCacheManager alloc] init];
        NSFileManager *manager = [NSFileManager defaultManager];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *finalPath = [cachePath stringByAppendingPathComponent:imageCachePath];
        if (![manager fileExistsAtPath:finalPath]) {
            [manager createDirectoryAtPath:finalPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
    });
    
    return  instance;
}

- (UIImage *)imageByKey:(NSString *)key {
    NSString *imageFile = [self.cacheDictionary objectForKey:key];
    
    if (imageFile) {
        NSData *imageData = [NSData dataWithContentsOfFile:imageFile];
        UIImage *image = [UIImage imageWithData:imageData];
        
        return image;
    }
    
    return nil;
}

- (void)seTImage:(UIImage *)image forKey:(NSString *)key {    
    NSString *filePath = [self.imagesPath stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);;
    [manager createFileAtPath:filePath contents:imageData attributes:nil];
    
    NSMutableDictionary *auxDictionary = self.cacheDictionary.mutableCopy;
    [auxDictionary setObject:filePath forKey:key];
    
    self.cacheDictionary = auxDictionary.copy;
    [self.cacheDictionary writeToFile:[self.imagesPath stringByAppendingPathComponent:plistFile] atomically:YES];
}

@end
