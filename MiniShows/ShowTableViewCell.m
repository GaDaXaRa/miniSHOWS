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
    self.clipsToBounds = YES;
    self.frame = CGRectInset(self.bounds, 20, 20);
    
    self.layer.cornerRadius = 20;
    
    
    UIImage *image = [UIImage imageNamed:@"Best-script"];
    self.showImage.image = image;
    
    self.showImage.layer.cornerRadius = self.showImage.frame.size.width/2;
    self.showImage.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark -
#pragma mark - Public Methods
- (void) redrawShows{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationPortrait) {
        self.bottomConstrainRemaining.constant = 20;
        self.trailingConstrainRemaining.constant = 117;
    } else if (orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft) {
        self.bottomConstrainRemaining.constant = 20 + 39;
        self.trailingConstrainRemaining.constant = 117 - 97;
    }
}

@end
