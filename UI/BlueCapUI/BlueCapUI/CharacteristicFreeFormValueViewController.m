//
//  CharacteristicFreeFormValueViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 10/13/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "CharacteristicFreeFormValueViewController.h"
#import "UIAlertView+Extensions.h"

@interface CharacteristicFreeFormValueViewController ()

@end

@implementation CharacteristicFreeFormValueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.title = self.characteristic.profile.name;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    NSString* value = self.valueTextField.text;
    if (value) {
        [self.characteristic writeObject:value afterWriteCall:^(BlueCapCharacteristic* __characteristic, NSError* __error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (__error) {
                    [UIAlertView showMessage:@"Unknown Error Occured"];
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
        }];
    }
    return YES;
}

@end
