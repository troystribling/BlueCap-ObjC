//
//  CharacteristicDescriptorsViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 9/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "CharacteristicDescriptorsViewController.h"
#import "DescriptorDetailViewController.h"

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

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DescriptorDetail"]) {
        NSIndexPath* selectedIndex = [self.tableView indexPathForCell:sender];
        BlueCapDescriptor* descriptor = [self.characteristic.descriptors objectAtIndex:selectedIndex.row];
        DescriptorDetailViewController* viewController = segue.destinationViewController;
        viewController.descriptor = descriptor;
    }
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
    static NSString *CellIdentifier = @"CharacteristicDescriptorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    BlueCapDescriptor* descriptor = [self.characteristic.descriptors objectAtIndex:indexPath.row];
    cell.textLabel.text = descriptor.UUID.stringValue;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate


@end
