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
@property (strong, nonatomic)NSLock *readWriteLock;

@end

@implementation ShowImageCacheManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveDictionary) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

#pragma mark -
#pragma mark Singleton factory

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

#pragma mark -
#pragma mark Lazy getting

- (NSLock *)readWriteLock {
    if (!_readWriteLock) {
        _readWriteLock = [[NSLock alloc] init];
    }
    
    return _readWriteLock;
}

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

#pragma mark -
#pragma mark Cache methods

- (UIImage *)imageByKey:(NSString *)key {
    UIImage *image;
    while(![self.readWriteLock tryLock]) {}
    
    NSString *imageFile = [self.cacheDictionary objectForKey:key];    
    if (imageFile) {
        NSData *imageData = [NSData dataWithContentsOfFile:imageFile];
        image = [UIImage imageWithData:imageData];
    }
    
    [self.readWriteLock unlock];
    
    return image;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    while(![self.readWriteLock tryLock]) {}
    
    NSString *filePath = [self.imagesPath stringByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
    NSFileManager *manager = [NSFileManager defaultManager];
    //Asuming jpeg images
    NSData *imageData = UIImageJPEGRepresentation(image, 1);;
    [manager createFileAtPath:filePath contents:imageData attributes:nil];
    
    NSMutableDictionary *auxDictionary = self.cacheDictionary.mutableCopy;
    [auxDictionary setObject:filePath forKey:key];
    
    self.cacheDictionary = auxDictionary.copy;
    
    [self.readWriteLock unlock];
    
}

#pragma mark -
#pragma mark Helping methods

- (void)saveDictionary {
    [self.cacheDictionary writeToFile:[self.imagesPath stringByAppendingPathComponent:plistFile] atomically:YES];
}

@end
