//
//  MKMPEnergySettingsModel.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPEnergySettingsModel.h"

#import "MKMacroDefines.h"

#import "MKMPInterface.h"
#import "MKMPInterface+MKMPConfig.h"

@interface MKMPEnergySettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKMPEnergySettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readEnergyIntervalParams]) {
            [self operationFailedBlockWithMsg:@"Read Interval Error" block:failedBlock];
            return;
        }
        if (![self readPowerChangeValue]) {
            [self operationFailedBlockWithMsg:@"Read Power Change Value Error" block:failedBlock];
            return;
        }
        if (![self readEnergyDatas]) {
            [self operationFailedBlockWithMsg:@"Read Energy Datas Error" block:failedBlock];
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
        if (![self configEnergyIntervalParams]) {
            [self operationFailedBlockWithMsg:@"Config Interval Error" block:failedBlock];
            return;
        }
        if (![self configPowerChangeValue]) {
            [self operationFailedBlockWithMsg:@"Config Power Change Value Error" block:failedBlock];
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
- (BOOL)readEnergyIntervalParams {
    __block BOOL success = NO;
    [MKMPInterface mp_readEnergyIntervalParamsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.saveInterval = returnData[@"result"][@"saveInterval"];
        self.reportInterval = returnData[@"result"][@"repoertInterval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configEnergyIntervalParams {
    __block BOOL success = NO;
    [MKMPInterface mp_configEnergyReportInterval:[self.reportInterval integerValue] saveInterval:[self.saveInterval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPowerChangeValue {
    __block BOOL success = NO;
    [MKMPInterface mp_readPowerChangeValueWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.powerChangeValue = returnData[@"result"][@"value"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPowerChangeValue {
    __block BOOL success = NO;
    [MKMPInterface mp_configPowerChangeValue:[self.powerChangeValue integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readEnergyDatas {
    __block BOOL success = NO;
    [MKMPInterface mp_readEnergyDataWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger ec = [returnData[@"EC"] integerValue];
        if (ec == 0) {
            self.totalEnergy = @"0.0";
        }else {
            NSInteger totalValueRounds = [returnData[@"totalRounds"] integerValue];
            float  value = (totalValueRounds * 1.0) / ec;
            self.totalEnergy = [NSString stringWithFormat:@"%.1f",value];
        }
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
        NSError *error = [[NSError alloc] initWithDomain:@"EnergySettingsParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.reportInterval) || [self.reportInterval integerValue] < 1 || [self.reportInterval integerValue] > 60) {
        return NO;
    }
    if (!ValidStr(self.saveInterval) || [self.saveInterval integerValue] < 1 || [self.saveInterval integerValue] > 60) {
        return NO;
    }
    if (!ValidStr(self.saveInterval) || [self.saveInterval integerValue] < 1 || [self.saveInterval integerValue] > 60) {
        return NO;
    }
    if (!ValidStr(self.powerChangeValue) || [self.powerChangeValue integerValue] < 1 || [self.powerChangeValue integerValue] > 100) {
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
        _readQueue = dispatch_queue_create("EnergySettingsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
