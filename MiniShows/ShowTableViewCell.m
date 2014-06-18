//
//  ShowTableViewCell.m
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 18/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ShowTableViewCell.h"

@interface ShowTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *showTitle;
@property (weak, nonatomic) IBOutlet UILabel *showDescription;
@property (weak, nonatomic) IBOutlet UILabel *episodesRemaining;
@property (weak, nonatomic) IBOutlet UIImageView *showImage;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingConstrainRemaining;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstrainRemaining;

@end

@implementation ShowTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib
{
    [self setBackgroundLayer];
    [self setShowImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark Helping Methods

- (void)setBackgroundLayer
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1].CGColor;
    layer.cornerRadius = 20;
    
    [self.layer insertSublayer:layer atIndex:0];
}

- (void)setShowImage
{
    UIImage *image = [UIImage imageNamed:@"Best-script"];
    self.showImage.image = image;
    
    self.showImage.layer.cornerRadius = self.showImage.frame.size.width/2;
    self.showImage.clipsToBounds = YES;
}

#pragma mark -
#pragma mark - Public Methods

- (void) redrawShows{
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];    
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationUnknown) {
        [self setPortraitSettings];
    } else if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft) {
        [self setLandscapeSettings];
    }
}

- (void)setPortraitSettings {
    CALayer *layer = [self.layer.sublayers objectAtIndex:0];
    layer.frame = CGRectInset(self.bounds, 5, 2.5);
    [self setPortraitConstrains];
    [self setPortraitFonts];
}

- (void)setLandscapeSettings {
    CALayer *layer = [self.layer.sublayers objectAtIndex:0];
    layer.frame = CGRectInset(self.bounds, 10, 5);
    [self setLandscapeConstrains];
    [self setLandscapeFonts];
}

- (void)setPortraitConstrains {
    self.bottomConstrainRemaining.constant = 8;
    self.trailingConstrainRemaining.constant = 115;
}

- (void)setPortraitFonts {
    self.showTitle.font = [UIFont systemFontOfSize:20];
    self.showDescription.font = [UIFont systemFontOfSize:16];
}

- (void)setLandscapeConstrains {
    self.bottomConstrainRemaining.constant = self.bounds.size.height / 2 - 7;
    self.trailingConstrainRemaining.constant = 0;
}

- (void)setLandscapeFonts {
    self.showTitle.font = [UIFont systemFontOfSize:32];
    self.showDescription.font = [UIFont systemFontOfSize:24];
}

@end
