//
//  CharacteristicDiscreteValueViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 10/22/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "CharacteristicDiscreteValueViewController.h"

@interface CharacteristicDiscreteValueViewController ()

- (NSString*)selectedValue;

@end

@implementation CharacteristicDiscreteValueViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.characteristic allValues] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[self.characteristic allValues] objectAtIndex:indexPath.row];
    return cell;
}


- (NSString*)selectedValue {
    
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
}

@end
