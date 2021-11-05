//
//  MKMPSwitchSettingsModel.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPSwitchSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKMPInterface.h"
#import "MKMPInterface+MKMPConfig.h"

@interface MKMPSwitchSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKMPSwitchSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readSwitchStatus]) {
            [self operationFailedBlockWithMsg:@"Read Switch Status Error" block:failedBlock];
            return;
        }
        if (![self readReportInterval]) {
            [self operationFailedBlockWithMsg:@"Read Report Interval Error" block:failedBlock];
            return;
        }
        if (![self readDefauleMode]) {
            [self operationFailedBlockWithMsg:@"Read Power On Default Mode Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configSwitchStatus]) {
            [self operationFailedBlockWithMsg:@"Config Switch Status Error" block:failedBlock];
            return;
        }
        if (![self configReportInterval]) {
            [self operationFailedBlockWithMsg:@"Config Report Interval Error" block:failedBlock];
            return;
        }
        if (![self configDefauleMode]) {
            [self operationFailedBlockWithMsg:@"Config Power On Default Mode Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readSwitchStatus {
    __block BOOL success = NO;
    [MKMPInterface mp_readSwitchStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSwitchStatus {
    __block BOOL success = NO;
    [MKMPInterface configSwitchStatus:self.isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readReportInterval {
    __block BOOL success = NO;
    [MKMPInterface mp_readReportIntervalOfSwitchPayloadsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.interval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configReportInterval {
    __block BOOL success = NO;
    [MKMPInterface mp_configReportIntervalOfSwitchPayloads:[self.interval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDefauleMode {
    __block BOOL success = NO;
    [MKMPInterface mp_readRepoweredDefaultModeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger tempMode = [returnData[@"result"][@"mode"] integerValue];
        if (tempMode == 0) {
            //关闭
            self.mode = 1;
        }else if (tempMode == 1) {
            //打开
            self.mode = 0;
        }else if (tempMode == 2) {
            //断点之前的状态
            self.mode = 2;
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDefauleMode {
    __block BOOL success = NO;
    [MKMPInterface mp_configRepoweredDefaultMode:self.mode sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"SwitchSettingsParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.interval) || [self.interval integerValue] < 10 || [self.interval integerValue] > 600) {
        return NO;
    }
    return YES;
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("LoRaAppSettingQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
