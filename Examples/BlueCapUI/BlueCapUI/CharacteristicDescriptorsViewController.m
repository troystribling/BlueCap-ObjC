//
//  CharacteristicDescriptorsViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 9/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "CharacteristicDescriptorsViewController.h"
#import "DescriptorCell.h"

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
    [self.characteristic discoverAllDescriptors:^(NSArray* __discoveredDescriptors){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.characteristic.descriptors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DescriptorCell";
    DescriptorCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    BlueCapDescriptor* descriptor = [self.characteristic.descriptors objectAtIndex:indexPath.row];
    cell.typeLabel.text = [descriptor typeStringValue];
    [descriptor read:^(BlueCapDescriptor* __descriptor, NSError* __error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            DescriptorCell* cell = (DescriptorCell*)[self.tableView cellForRowAtIndexPath:indexPath];
            if (cell) {
                cell.valuelabel.text = [__descriptor stringValue];
                [cell setNeedsLayout];
            }
        });
    }];
    return cell;
}

#pragma mark - UITableViewDelegate


@end
