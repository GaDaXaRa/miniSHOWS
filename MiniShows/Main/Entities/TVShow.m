//
//  TVShows.m
//  entitys4thWeek
//
//  Created by Miguel Santiago Rodríguez on 23/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "TVShow.h"

NSString *const showIdField = @"showId";
NSString *const nameField = @"name";
NSString *const summaryField = @"summary";
NSString *const creatorField = @"creator";
NSString *const castField = @"cast";
NSString *const posterImageField = @"posterImage";
NSString *const bannerImageField = @"bannerImage";
NSString *const ratingField = @"rating";

@implementation TVShow

#pragma mark -
#pragma mark Initialing

- (id)initWithId:(NSString *)showId Name:(NSString *)name AndSummary:(NSString *)summary {
    self = [super init];
    
    if (self) {
        _showId = showId;
        _name = name;
        _summary = summary;
    }
    
    return self;
}

#pragma mark -
#pragma mark Class methods

+ (TVShow *)tvShowWithId:(NSString *)showId
                    Name:(NSString *)name
                 Summary:(NSString *)summary
               PosterUrl:(NSString *)posterUrl
            AndBannerUrl:(NSString *)bannerUrl {
    TVShow *show = [[TVShow alloc] initWithId:showId Name:name AndSummary:summary];
    show.posterImage = posterUrl;
    show.bannerImage = bannerUrl;
    
    return show;
}

#pragma mark -
#pragma mark Equality

- (BOOL)isEqualToTVShow:(TVShow *)show {
    return [self.showId isEqualToString:show.showId];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[TVShow class]]) {
        return NO;
    }
    
    return [self isEqualToTVShow:object];
}

- (NSUInteger)hash {
    return [_showId hash];
}

@end

@implementation TVShow(NSCoding)

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        self.showId = [aDecoder decodeObjectForKey:showIdField];
        self.name = [aDecoder decodeObjectForKey:nameField];
        self.summary = [aDecoder decodeObjectForKey:summaryField];
        self.creator = [aDecoder decodeObjectForKey:creatorField];
        self.cast = [aDecoder decodeObjectForKey:castField];
        self.posterImage = [aDecoder decodeObjectForKey:posterImageField];
        self.bannerImage = [aDecoder decodeObjectForKey:bannerImageField];
        
        NSNumber *ratingNumber = [aDecoder decodeObjectForKey:ratingField];
        self.rating = CGFLOAT_IS_DOUBLE ? [ratingNumber doubleValue] : [ratingNumber floatValue];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if (self.showId) [aCoder encodeObject:self.showId forKey:showIdField];
    if (self.name) [aCoder encodeObject:self.name forKey:nameField];
    if (self.summary) [aCoder encodeObject:self.summary forKey:summaryField];
    if (self.creator) [aCoder encodeObject:self.creator forKey:creatorField];
    if (self.cast) [aCoder encodeObject:self.cast forKey:castField];
    if (self.posterImage) [aCoder encodeObject:self.posterImage forKey:posterImageField];
    if (self.bannerImage) [aCoder encodeObject:self.bannerImage forKey:bannerImageField];
    
    NSNumber *ratingNumber = CGFLOAT_IS_DOUBLE ? [NSNumber numberWithDouble:self.rating] : [NSNumber numberWithFloat:self.rating];
    
    [aCoder encodeObject:ratingNumber forKey:ratingField];
}

@end

@implementation TVShow(NSCopying)

- (id)copyWithZone:(NSZone *)zone {
    TVShow *show = [[TVShow allocWithZone:zone] init];
    
    if (show) {
        show.showId = [self.name copyWithZone:zone];
        show.name = [self.name copyWithZone:zone];
        show.summary = [self.summary copyWithZone:zone];
        show.creator = [self.creator copyWithZone:zone];
        show.cast = [self.cast copyWithZone:zone];
        show.posterImage = [self.posterImage copyWithZone:zone];
        show.bannerImage = [self.bannerImage copyWithZone:zone];
        show.rating = self.rating;
    }
    
    return show;
}

@end
