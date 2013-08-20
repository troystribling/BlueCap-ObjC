//
//  PeriphrealViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "PeriphrealViewController.h"

@interface PeriphrealViewController ()

@end

@implementation PeriphrealViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameNavigationItem.title = self.periphreal.name;
    if (self.periphreal.RSSI) {
        self.rssiTextField.text = [NSString stringWithFormat:@"%@dB", self.periphreal.RSSI];
    } else {
        self.rssiTextField.text = @"Unknown";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)toggleConnection:(id)sender {    
}

@end
