//
//  PeripheralAdvertisementsTableViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 3/26/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

#import "PeripheralAdvertisementsTableViewController.h"

@interface PeripheralAdvertisementsTableViewController ()

@end

@implementation PeripheralAdvertisementsTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PeripheralAdvertisementCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - Navigation -

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
