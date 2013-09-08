//
//  CharacteristicDescriptorsViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 9/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "CharacteristicDescriptorsViewController.h"
#import "DescriptorDetailCell.h"

@interface CharacteristicDescriptorsViewController ()

@end

@implementation CharacteristicDescriptorsViewController

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

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.characteristic.descriptors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DescriptorDetailCell";
    __block DescriptorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    BlueCapDescriptor* descriptor = [self.characteristic.descriptors objectAtIndex:indexPath.row];
    cell.typeLabel.text = [descriptor typeStringValue];
    [descriptor read:^(NSError* error) {
        cell = (DescriptorDetailCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            cell.valuelabel.text = [descriptor stringValue];
            [cell setNeedsLayout];
        }
    }];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate


@end