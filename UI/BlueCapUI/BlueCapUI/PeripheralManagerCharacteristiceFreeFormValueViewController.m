//
//  PeripheralManagerCharacteristiceFreeFormValueViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 11/10/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "PeripheralManagerCharacteristiceFreeFormValueViewController.h"

@interface PeripheralManagerCharacteristiceFreeFormValueViewController ()

@end

@implementation PeripheralManagerCharacteristiceFreeFormValueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.navigationItem.title = self.valueName;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    NSString* value = self.valueTextField.text;
    if (value) {
    }
    return YES;
}

@end
