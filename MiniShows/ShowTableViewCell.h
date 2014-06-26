//
//  ShowTableViewCell.h
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 18/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowTableViewCell : UITableViewCell

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

- (void) redrawShows;

@end
