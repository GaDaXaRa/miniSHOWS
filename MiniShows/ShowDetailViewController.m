//
//  ShowDetailViewController.m
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 18/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ShowDetailViewController.h"

@interface ShowDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UITextView *showSummaryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrainSummary;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstrainSummary;

@end

@implementation ShowDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationPortrait) {
        [self setPortraitConstrains];
    } else {
        [self setLandscapeConstrains];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (self.view.frame.size.height > self.view.frame.size.width) {
        [self setPortraitConstrains];
    } else {
        [self setLandscapeConstrains];
    }
}

- (void)setLandscapeConstrains {
    self.topConstrainSummary.constant = 0;
    self.leadingConstrainSummary.constant = self.showImageView.frame.size.width;
}

- (void)setPortraitConstrains {
    self.topConstrainSummary.constant = 212;
    self.leadingConstrainSummary.constant = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
