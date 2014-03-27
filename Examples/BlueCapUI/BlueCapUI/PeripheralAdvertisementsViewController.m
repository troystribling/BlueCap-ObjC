//
//  PeripheralAdvertisementsViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 3/26/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "PeripheralAdvertisementsViewController.h"
#import "PeripheralAdvertisementCell.h"

@interface PeripheralAdvertisementsViewController ()

@property(nonatomic, retain) NSMutableArray*    values;
@property(nonatomic, retain) NSMutableArray*    names;

- (void)addName:(NSString*)name andValue:(id)value;

@end

@implementation PeripheralAdvertisementsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.values = [NSMutableArray array];
    self.names = [NSMutableArray array];
    for (NSString* name in [self.advertisements allKeys]) {
        id value = [self.advertisements objectForKey:name];
        if ([value isKindOfClass:[NSArray class]]) {
            for (id val in value) {
                [self addName:name andValue:val];
            }
        } else {
            [self addName:name andValue:value];
        }
    }
    [super viewDidLoad];
}

- (void)addName:(NSString*)name andValue:(id)value {
    [self.names addObject:name];
    if ([value isKindOfClass:[NSString class]]) {
        [self.values addObject:value];
    } else {
        [self.values addObject:[value stringValue]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.names count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PeripheralAdvertisementCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PeripheralAdvertisementCell" forIndexPath:indexPath];
    cell.nameLabel.text = [self.names objectAtIndex:indexPath.row];
    cell.valueLabel.text = [self.values objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Navigation -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
