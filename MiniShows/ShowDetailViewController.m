//
//  ShowDetailViewController.m
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 18/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "TableViewController.h"

@interface ShowDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UITextView *showSummaryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrainSummary;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstrainSummary;
@property (weak, nonatomic) IBOutlet UIToolbar *showToolbar;

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
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationUnknown) {
        [self setPortraitConstrains];
    } else {
        [self setLandscapeConstrains];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setConstrainsByFrameSize];
    [self.view layoutSubviews];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self setConstrainsByFrameSize];    
}

- (void)setConstrainsByFrameSize {
    if (self.view.frame.size.height > self.view.frame.size.width) {
        [self setPortraitConstrains];
    } else {
        [self setLandscapeConstrains];
    }
}

- (void)setLandscapeConstrains {
    self.topConstrainSummary.constant = 0;
    self.leadingConstrainSummary.constant = self.showImageView.frame.size.width;
    [self.showSummaryView setContentInset:UIEdgeInsetsZero];
    [self.showSummaryView scrollRangeToVisible:NSMakeRange(0, 0)];
}

- (void)setPortraitConstrains {
    self.topConstrainSummary.constant = self.showImageView.frame.size.height;
    self.leadingConstrainSummary.constant = 0;
    [self.showSummaryView setContentInset:UIEdgeInsetsMake(self.showToolbar.bounds.size.height, 0, 0, 0)];
    [self.showSummaryView scrollRangeToVisible:NSMakeRange(0, 0)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
