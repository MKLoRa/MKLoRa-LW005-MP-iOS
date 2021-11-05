//
//  MKMPLoadStatusModel.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPLoadStatusModel.h"

#import "MKMacroDefines.h"

#import "MKMPInterface.h"
#import "MKMPInterface+MKMPConfig.h"

@interface MKMPLoadStatusModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKMPLoadStatusModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readLoadStatus]) {
            [self operationFailedBlockWithMsg:@"Read Load Status Error" block:failedBlock];
            return;
        }
        if (![self readNotifications]) {
            [self operationFailedBlockWithMsg:@"Read Load Status Notifications Error" block:failedBlock];
            return;
        }
        if (![self readStatusThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Load Status Threshold Error" block:failedBlock];
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
        if (![self configNotifications]) {
            [self operationFailedBlockWithMsg:@"Config Load Status Notifications Error" block:failedBlock];
            return;
        }
        if (![self configStatusThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Load Status Threshold Error" block:failedBlock];
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
- (BOOL)readLoadStatus {
    __block BOOL success = NO;
    [MKMPInterface mp_readLoadStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.loadStatus = [returnData[@"result"][@"load"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readNotifications {
    __block BOOL success = NO;
    [MKMPInterface mp_readLoadStatusNotificationsWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.loadStart = [returnData[@"result"][@"loadStart"] boolValue];
        self.loadStop = [returnData[@"result"][@"loadStop"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configNotifications {
    __block BOOL success = NO;
    [MKMPInterface mp_configLoadStatusNotifications:self.loadStart stopIsOn:self.loadStop sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readStatusThreshold {
    __block BOOL success = NO;
    [MKMPInterface mp_readLoadStatusThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.threshold = returnData[@"result"][@"value"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configStatusThreshold {
    __block BOOL success = NO;
    [MKMPInterface mp_configLoadStatusThreshold:[self.threshold integerValue] sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"LoadStatusParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.threshold) || [self.threshold integerValue] < 1 || [self.threshold integerValue] > 10) {
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
        _readQueue = dispatch_queue_create("OverProtectionQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
