//
//  PeriphrealsViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "PeripheralsViewController.h"
#import "PeripheralViewController.h"
#import "PeripheralCell.h"

#define RECONNECT_DELAY         2.0f
#define MAX_FAILED_RECONNECTS   10

@interface PeripheralsViewController ()

@property(nonatomic, retain) UIBarButtonItem*       startScanBarButtonItem;
@property(nonatomic, retain) UIBarButtonItem*       stopScanBarButtonItem;
@property(nonatomic, retain) NSMutableDictionary*   peripheralConnectionSequenceNumbers;

- (IBAction)toggelScan;
- (void)reloadTableData;
- (void)setScanButton;
- (void)enterForground;
- (void)connectPeripheral:(BlueCapPeripheral*)peripheral;
- (void)reconnectPeripheral:(BlueCapPeripheral*)peripheral;
- (void)updatePeripheralConnectionSequenceNumber:(BlueCapPeripheral*)peripheral;
- (void)resetPeripheralConnectionSequenceNumber:(BlueCapPeripheral*)peripheral;
- (BOOL)periphralCanReconnect:(BlueCapPeripheral*)peripheral;

@end

@implementation PeripheralsViewController

#pragma mark - PeripheralsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.startScanBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(toggelScan)];
    self.stopScanBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(toggelScan)];
    [self reloadTableData];
    [self setScanButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForground) name:UIApplicationWillEnterForegroundNotification object:nil];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadTableData];
    self.peripheralConnectionSequenceNumbers = [NSMutableDictionary dictionary];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"PeripheralDetail"]) {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForCell:sender];
        PeripheralViewController *viewController = segue.destinationViewController;
        viewController.peripheral = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:selectedRowIndex.row];
    }
}

#pragma mark - Private

- (void)reloadTableData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (IBAction)toggelScan {
    BlueCapCentralManager* central = [BlueCapCentralManager sharedInstance];
    if (central.isScanning) {
        [central stopScanning];
        [self reloadTableData];
        [self setScanButton];
    } else {
        [central powerOn:^{
            [central disconnectAllPeripherals];
            [central startScanning:^(BlueCapPeripheral* peripheral, NSNumber* RSSI) {
                [self resetPeripheralConnectionSequenceNumber:peripheral];
                [self connectPeripheral:peripheral];
                [self reloadTableData];
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self setScanButton];
            });
        } afterPowerOff:^{
            [self reloadTableData];
        }];
    }
}

- (void)setScanButton {
    if ([BlueCapCentralManager sharedInstance].isScanning) {
        [self.navigationItem setRightBarButtonItem:self.stopScanBarButtonItem animated:NO];
    } else {
        [self.navigationItem setRightBarButtonItem:self.startScanBarButtonItem animated:NO];
    }
}

- (void)enterForground {
    [self setScanButton];
    [self.tableView reloadData];
}

- (void)connectPeripheral:(BlueCapPeripheral*)peripheral {
    [peripheral connect:^(BlueCapPeripheral* __peripheral, NSError* error) {
        if (error) {
            [self reconnectPeripheral:peripheral];
        } else {
            [self reloadTableData];
        }
    } afterPeripheralDisconnect:^(BlueCapPeripheral* peripheral) {
        [self reconnectPeripheral:peripheral];
    }];
}

- (void)reconnectPeripheral:(BlueCapPeripheral *)peripheral {
    [self reloadTableData];
    if ([self periphralCanReconnect:peripheral]) {
        DLog(@"Peripheal %@ disconnected. Attempting reconnect %d",
             peripheral.name, [[self.peripheralConnectionSequenceNumbers objectForKey:peripheral.identifier] integerValue]);
        [self updatePeripheralConnectionSequenceNumber:peripheral];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(RECONNECT_DELAY * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [self connectPeripheral:peripheral];
        });
    } else {
        DLog(@"Peripheal %@ maximum reconnection attempts exceededt", peripheral.name);
    }
}

- (void)updatePeripheralConnectionSequenceNumber:(BlueCapPeripheral*)peripheral {
    NSNumber* counter = [self.peripheralConnectionSequenceNumbers objectForKey:peripheral.identifier];
    if (counter) {
        counter = [NSNumber numberWithInteger:[counter integerValue] + 1];
    } else {
        counter = [NSNumber numberWithInteger:0];
    }
    [self.peripheralConnectionSequenceNumbers setObject:counter forKey:peripheral.identifier];
}

- (void)resetPeripheralConnectionSequenceNumber:(BlueCapPeripheral*)peripheral {
    [self.peripheralConnectionSequenceNumbers setObject:[NSNumber numberWithInteger:0] forKey:peripheral.identifier];
}

- (BOOL)periphralCanReconnect:(BlueCapPeripheral*)peripheral {
    BOOL status = NO;
    NSNumber* counter = [self.peripheralConnectionSequenceNumbers objectForKey:peripheral.identifier];
    if ([counter integerValue] < MAX_FAILED_RECONNECTS) {
        status = YES;
    }
    return status;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BlueCapCentralManager* blueCapManager = [BlueCapCentralManager sharedInstance];
    return [blueCapManager.periphreals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"PeripheralCell";
    PeripheralCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    BlueCapPeripheral* peripheral = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:indexPath.row];
    [cell.connectingActivityIndicator stopAnimating];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.peripheral = peripheral;
    if (peripheral.state == CBPeripheralStateConnected) {
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    } else if (peripheral.state == CBPeripheralStateConnecting) {
        [cell.connectingActivityIndicator startAnimating];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.nameLabel.text = peripheral.name;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    BlueCapPeripheral* peripheral = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:indexPath.row];
    PeripheralCell* cell = (PeripheralCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell.connectingActivityIndicator startAnimating];
    if (peripheral.state == CBPeripheralStateDisconnected) {
        [self resetPeripheralConnectionSequenceNumber:peripheral];
        [self connectPeripheral:peripheral];
    } else {
        [peripheral disconnect:^(BlueCapPeripheral* __peripheral){
            [self reloadTableData];
        }];
    }
}

@end
