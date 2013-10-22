//
//  CharacteristicFreeFormValueViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 10/13/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "CharacteristicFreeFormValueViewController.h"

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
        [self.characteristic writeObject:value afterWriteCall:^(BlueCapCharacteristicData* __data, NSError* __error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }];
    }
    return YES;
}

@end
