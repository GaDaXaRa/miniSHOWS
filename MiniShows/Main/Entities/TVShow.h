//
//  TVShows.h
//  entitys4thWeek
//
//  Created by Miguel Santiago Rodríguez on 23/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const showIdField;
FOUNDATION_EXPORT NSString *const nameField;
FOUNDATION_EXPORT NSString *const summaryField;
FOUNDATION_EXPORT NSString *const creatorField;
FOUNDATION_EXPORT NSString *const castField;
FOUNDATION_EXPORT NSString *const posterImageField;
FOUNDATION_EXPORT NSString *const ratingField;

@interface TVShow : NSObject

@property (copy, nonatomic) NSString *showId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *creator;
@property (copy, nonatomic) NSArray *cast;
@property (copy, nonatomic) NSString *posterImage;
@property (copy, nonatomic) NSString *bannerImage;
@property (assign, nonatomic) CGFloat rating;

- (id)initWithId:(NSString *)id Name:(NSString *)name AndSummary:(NSString *)summary;

+ (TVShow *)tvShowWithId:(NSString *)showId
                    Name:(NSString *)name
                 Summary:(NSString *)summary
               PosterUrl:(NSString *)posterUrl
            AndBannerUrl:(NSString *)bannerUrl;

- (BOOL)isEqualToTVShow:(TVShow *)show;

@end

@interface TVShow(NSCoding)<NSCoding>

@end

@interface TVShow(NSCopying)<NSCopying>

@end
