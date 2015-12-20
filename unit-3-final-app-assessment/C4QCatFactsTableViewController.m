//
//  C4QCatsTableViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "C4QCatFactsTableViewController.h"
#import "C4QCatFactsCustomTableViewCell.h"
#import "C4QCatFactsDetailViewController.h"
#import "C4QSavedFactsTableViewController.h"
#define CAT_API_URL @"http://catfacts-api.appspot.com/api/facts?number=100"
#define savedFactsKey @"SavedFacts"

const CGFloat estimatedRowHeight = 240.0;

@interface C4QCatFactsTableViewController ()<C4QCatFactsCustomTableViewCellDelegate>
@property (nonatomic) NSMutableArray *catFactsArray;
@property (nonatomic) NSMutableArray *savedFacts;

@end

@implementation C4QCatFactsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.catFactsArray = [[NSMutableArray alloc] init];
    self.savedFacts = [[NSMutableArray alloc] init];

    [self setupTableViewUI];
    [self fetchingCatsData];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"saved fcts %@", self.savedFacts);
    [self showSavedFacts];
    [self.tableView reloadData];

}

-(void)showSavedFacts {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.savedFacts = [NSMutableArray arrayWithArray:[defaults objectForKey:savedFactsKey]];
}

#pragma mark - Fetch data

-(void)fetchFactsWithCompletionBlock:(void (^)(NSArray *catFacts))onCompletion{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/javascript"];
    
    [manager GET:CAT_API_URL
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        onCompletion(responseObject[@"facts"]);
             
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error.userInfo);
    }];
    
}

-(void)fetchingCatsData{
    [self fetchFactsWithCompletionBlock:^(NSArray *catFacts) {
        self.catFactsArray = [NSMutableArray arrayWithArray: catFacts];
        [self.tableView reloadData];
    }];
}

#pragma mark - TableView UI
-(void)setupTableViewUI{
    UINib *nib = [UINib nibWithNibName:@"C4QCatFactsTvc" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CatFactIdentifier"];
    self.tableView.allowsSelection = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteCat"]];
    [tempImageView setFrame:self.tableView.frame];
    tempImageView.alpha = 0.5;
    self.tableView.backgroundView = tempImageView;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.catFactsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   C4QCatFactsCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatFactIdentifier"];
     cell.delegate = self;
    cell.index = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
    [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    cell.catFactsDescription.text = self.catFactsArray[indexPath.row];

    if ([self.savedFacts containsObject:cell.catFactsDescription.text]) {
        [cell.catboxChecked setImage:[UIImage imageNamed:@"checkboxSelected"] forState:UIControlStateNormal ];
        cell.catboxChecked.enabled = NO;
    } else {
        cell.catboxChecked.enabled = YES;

    }


    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    C4QCatFactsDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FactsDetailIdentifier"];
    detailVC.catFactCellSelected = (NSString *)self.catFactsArray[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

-(void)selectedFactToSave:(NSInteger)index {

    [self.savedFacts addObject:self.self.catFactsArray[index]];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.savedFacts forKey:savedFactsKey];
    
     [self savedNewFactAlert];
}

- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender {
    
    C4QSavedFactsTableViewController *savedVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SavedFactsID"];
    savedVC.savedFacts = self.savedFacts;
    [self.navigationController pushViewController:savedVC animated:YES];
}

-(void) savedNewFactAlert {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved!" message:@"Successfully saved new story" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
