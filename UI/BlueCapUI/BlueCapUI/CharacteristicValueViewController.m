//
//  CharacteristicValueViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 10/13/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "CharacteristicValueViewController.h"

@interface CharacteristicValueViewController ()

@end

@implementation CharacteristicValueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    NSString* value = self.valueTextField.text;
    if (value) {
        [self.characteristic writeObject:value];
        [self.navigationController popViewControllerAnimated:YES];
    }
    return YES;
}

@end
