//
//  C4QSavedFactsTableViewController.m
//  unit-3-final-app-assessment
//
//  Created by Diana Elezaj on 12/20/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QSavedFactsTableViewController.h"
#define savedFactsKey @"SavedFacts"

@interface C4QSavedFactsTableViewController ()
@property (nonatomic) NSMutableArray *savedFactsArray;

@end

@implementation C4QSavedFactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    [self loadSavedData];
    [self setupUI];
    
}

-(void)loadSavedData {
    NSArray *savedFactsCopy = [[NSUserDefaults standardUserDefaults] objectForKey:savedFactsKey];
    
    self.savedFactsArray = savedFactsCopy ? [NSMutableArray arrayWithArray:savedFactsCopy] : [NSMutableArray new];
    [self.tableView reloadData];
}

-(void) setupUI {
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"catsss"]];
     [tempImageView setFrame:self.tableView.frame];
    tempImageView.alpha = 0.5;
    self.tableView.backgroundView = tempImageView;
    self.tableView.allowsSelection = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedFactsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"savedID" forIndexPath:indexPath];
    
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
    [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];

    
    cell.textLabel.text = self.savedFactsArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.savedFactsArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:savedFactsKey];
    [[NSUserDefaults standardUserDefaults] setObject:self.savedFactsArray forKey:savedFactsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
