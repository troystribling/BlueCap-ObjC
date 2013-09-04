//
//  DescriptorDetailViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 9/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "DescriptorDetailViewController.h"

@interface DescriptorDetailViewController ()

@end

@implementation DescriptorDetailViewController

#pragma mark -
#pragma mark DescriptorDetailViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.uuidLabel.text = self.descriptor.UUID.stringValue;
    self.typeLabel.text = [self.descriptor typeStringValue];
    [self.descriptor read:^(NSError* error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark DescriptorDetailViewController Private API

@end
