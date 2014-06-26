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
#import "ReachabilityManager.h"

@interface TableViewController ()

@property (strong, nonatomic) NSArray* showsArray;
@property (strong, nonatomic) NSArray* bannerArrayOfUIIMage;
@property (strong, nonatomic) NSDictionary* bannersDictionary;

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
    [self subscribeReachability];
    
    
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
#pragma mark Lazy getting

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
        //        [self buildBannersArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.tableView reloadData];
        });
    } errorBlock:^(NSError *error) {
        [self showErrorAlert:error.localizedDescription];
    }];
}

#pragma mark -
#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass: [ShowDetailViewController class]]) {
        ShowTableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        TVShow *show = [self.showsArray objectAtIndex:indexPath.row];
        
        ShowDetailViewController *controller = segue.destinationViewController;
        controller.showImageUrl = show.posterImage;
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
    [cell.showImageView setImageWithUrl:show.bannerImage completion:^(BOOL finish) {
        
    }];
    
    [cell redrawShows];
    
    return cell;
}

#pragma mark -
#pragma mark Helping methods

- (void) showErrorAlert:(NSString *)error {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [errorAlert show];
}

- (void)subscribeReachability {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionLost:) name:ReachabilityServiceChangeNotConnection object:nil];
}

- (void)connectionLost:(NSNotification *)notification {
    [self showErrorAlert:@"Connection Lost"];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

@end
