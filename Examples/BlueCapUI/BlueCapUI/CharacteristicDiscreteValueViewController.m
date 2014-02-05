//
//  CharacteristicDiscreteValueViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 10/22/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "CharacteristicDiscreteValueViewController.h"
#import "UIAlertView+Extensions.h"
#import "ProgressView.h"

@interface CharacteristicDiscreteValueViewController ()

@property(nonatomic, strong) ProgressView* progressView;

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
    self.navigationItem.title = self.characteristic.profile.name;
    self.progressView = [ProgressView progressView];
    [super viewDidLoad];
}

- (NSString*)selectedValue {
    NSDictionary* value = [self.characteristic stringValue];
    return [value objectForKey:self.characteristic.profile.name];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.characteristic allValues] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CharacteristicDiscreteValueCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString* value = [[self.characteristic allValues] objectAtIndex:indexPath.row];
    cell.textLabel.text = value;
    if ([value isEqualToString:[self selectedValue]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.progressView progressWithMessage:@"Writing" inView:[[UIApplication sharedApplication] keyWindow]];
    [self.characteristic writeValueObject:cell.textLabel.text afterWriteCall:^(BlueCapCharacteristic* __characteristic, NSError* __error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (__error) {
                [UIAlertView alertOnError:__error];
            }
            [self.progressView remove];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];

}

@end
