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
    CGRect insetFrame = CGRectInset(self.bounds, 2.5, 2.5);
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1].CGColor;
    layer.frame = insetFrame;
    layer.cornerRadius = 10;
    
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
    if (orientation == UIDeviceOrientationPortrait) {
        self.bottomConstrainRemaining.constant = 20;
        self.trailingConstrainRemaining.constant = 128;
    } else if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft) {
        self.bottomConstrainRemaining.constant = 20 + self.bounds.size.height / 4;
        self.trailingConstrainRemaining.constant = 128 - 100;
    }
    
    CALayer *layer = [self.layer.sublayers objectAtIndex:0];
    layer.frame = CGRectInset(self.bounds, 2.5, 2.5);
}

@end
