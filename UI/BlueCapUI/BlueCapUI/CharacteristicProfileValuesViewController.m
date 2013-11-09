//
//  CharacteristicProfileValuesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 10/30/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "CharacteristicProfileValuesViewController.h"

@interface CharacteristicProfileValuesViewController ()

@end

@implementation CharacteristicProfileValuesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.navigationItem.title = self.characteristicProfile.name;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.characteristicProfile allValues] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CharacteristicProfileValueCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.characteristicProfile allValues] objectAtIndex:indexPath.row];
    return cell;
}

@end
