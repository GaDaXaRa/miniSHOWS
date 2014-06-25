//
//  TableViewController.m
//  MiniShows
//
//  Created by Miguel Santiago Rodríguez on 18/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "TableViewController.h"
#import "ShowTableViewCell.h"
#import "ShowDetailViewController.h"
#import "ShowTableViewCell.h"
#import "TVShow.h"
#import "ShowProvider.h"

static NSString *const showsUrl = @"";

@interface TableViewController ()

@property (strong, nonatomic) NSArray* showsArray;
@property (strong, nonatomic) NSArray* bannerArrayOfUIIMage;

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(2.5, 0, 2.5, 0);
    [self loadData];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Lazy get

- (NSArray *)showsArray {
    if (!_showsArray) {
        _showsArray = [[NSArray alloc] init];
    }
    
    return _showsArray;
}

- (NSArray *)bannerArrayOfUIIMage {
    if (!_bannerArrayOfUIIMage) {
        _bannerArrayOfUIIMage = [[NSArray alloc] init];
    }
    
    return _bannerArrayOfUIIMage;
}

#pragma mark -
#pragma mark Getting data

- (void)loadData {
    ShowProvider *provider = [[ShowProvider alloc] init];
    @weakify(self);
    [provider getAllShowsWithSuccessBlock:^(id showsArray) {
        @strongify(self);
        self.showsArray = showsArray;
        [self buildBannersArray];
        [self.tableView reloadData];
    } errorBlock:nil];
}

#pragma mark -
#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass: [ShowDetailViewController class]]) {
        ShowTableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        TVShow *show = [self.showsArray objectAtIndex:indexPath.row];
        
        ShowDetailViewController *controller = segue.destinationViewController;
        controller.showImage = [self imageFromUrl:show.posterImage];
        controller.showSummary = show.summary;
        controller.title = cell.title;
    }
}

- (IBAction)backFromSettings:(UIStoryboardSegue *)segue {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.showsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TVShow *show = [self.showsArray objectAtIndex:indexPath.row];
    ShowTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"showCell" forIndexPath:indexPath];
    
    cell.title = show.name;
    cell.description = show.summary;
    cell.showImage = [self.bannerArrayOfUIIMage objectAtIndex:indexPath.row];
    [cell redrawShows];
    
    return cell;
}

#pragma mark -
#pragma mark Helping methods

- (void)buildBannersArray {
    NSMutableArray *loadBannerArray = [[NSMutableArray alloc] init];
    for (TVShow *show in self.showsArray) {
        [loadBannerArray addObject:[self imageFromUrl:show.bannerImage]];
    }
    self.bannerArrayOfUIIMage = loadBannerArray.copy;
}

- (UIImage *)imageFromUrl:(NSString *)imageUrl {
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:data];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

@end
