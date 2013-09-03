//
//  ChracteristicDetailViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 9/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "CharacteristicDetailViewController.h"
#import "CharacteristicDescriptorsViewController.h"

@interface CharacteristicDetailViewController ()

@end

@implementation CharacteristicDetailViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.uuidLabel.text = self.characteristic.UUID.stringValue;
    self.broadcastingLabel.text = self.characteristic.isBroadcasted ? @"YES" : @"NO";
    self.notifyingLabel.text = self.characteristic.isNotifying ? @"YES" : @"NO";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CharacteristicDescriptors"]) {
        CharacteristicDescriptorsViewController* viewController = segue.destinationViewController;
        viewController.characteristic = self.characteristic;
    }
}

@end
