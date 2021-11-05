//
//  MKMPOverProtectionModel.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPOverProtectionModel.h"

#import "MKMacroDefines.h"

#import "MKMPInterface.h"
#import "MKMPInterface+MKMPConfig.h"

@interface MKMPOverProtectionModel ()

@property (nonatomic, assign)mp_overProtectionType type;

@property (nonatomic, assign)mp_productModel productModel;

/// 0:欧法   1:美规  2:英规
@property (nonatomic, assign)NSInteger specification;

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKMPOverProtectionModel

- (instancetype)initWithType:(mp_overProtectionType)type {
    if (self = [self init]) {
        self.type = type;
    }
    return self;
}

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readSpecification]) {
            [self operationFailedBlockWithMsg:@"Read Specification Error" block:failedBlock];
            return;
        }
        if (self.type == mp_overProtectionType_load) {
            //过载
            if (![self readOverLoadProtectionData]) {
                [self operationFailedBlockWithMsg:@"Read Over Value Error" block:failedBlock];
                return;
            }
        }else if (self.type == mp_overProtectionType_voltage) {
            //过压
            if (![self readOverVoltageProtectionData]) {
                [self operationFailedBlockWithMsg:@"Read Over Value Error" block:failedBlock];
                return;
            }
        }else if (self.type == mp_overProtectionType_sagVoltage) {
            //欠压
            if (![self readSagVoltageProtectionData]) {
                [self operationFailedBlockWithMsg:@"Read Over Value Error" block:failedBlock];
                return;
            }
        }else if (self.type == mp_overProtectionType_current) {
            //过流
            if (![self readOverCurrentProtectionData]) {
                [self operationFailedBlockWithMsg:@"Read Over Value Error" block:failedBlock];
                return;
            }
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
        if (self.type == mp_overProtectionType_load) {
            //过载
            if (![self configOverLoadProtection]) {
                [self operationFailedBlockWithMsg:@"Config Over Value Error" block:failedBlock];
                return;
            }
        }else if (self.type == mp_overProtectionType_voltage) {
            //过压
            if (![self configOverVoltageProtection]) {
                [self operationFailedBlockWithMsg:@"Config Over Value Error" block:failedBlock];
                return;
            }
        }else if (self.type == mp_overProtectionType_sagVoltage) {
            //欠压
            if (![self configSagVoltageProtection]) {
                [self operationFailedBlockWithMsg:@"Config Over Value Error" block:failedBlock];
                return;
            }
        }else if (self.type == mp_overProtectionType_current) {
            //过流
            if (![self configOverCurrentProtection]) {
                [self operationFailedBlockWithMsg:@"Config Over Value Error" block:failedBlock];
                return;
            }
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readSpecification {
    __block BOOL success = NO;
    [MKMPInterface mp_readSpecificationsOfDeviceWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.specification = [returnData[@"result"][@"specification"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readOverVoltageProtectionData {
    __block BOOL success = NO;
    [MKMPInterface mp_readOverVoltageProtectionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        self.overThreshold = returnData[@"result"][@"overThreshold"];
        self.timeThreshold = returnData[@"result"][@"timeThreshold"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configOverVoltageProtection {
    __block BOOL success = NO;
    [MKMPInterface mp_configOverVoltage:self.isOn productModel:self.specification overThreshold:[self.overThreshold integerValue] timeThreshold:[self.timeThreshold integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSagVoltageProtectionData {
    __block BOOL success = NO;
    [MKMPInterface mp_readSagVoltageProtectionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        self.overThreshold = returnData[@"result"][@"overThreshold"];
        self.timeThreshold = returnData[@"result"][@"timeThreshold"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSagVoltageProtection {
    __block BOOL success = NO;
    [MKMPInterface mp_configSagVoltage:self.isOn productModel:self.specification overThreshold:[self.overThreshold integerValue] timeThreshold:[self.timeThreshold integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readOverCurrentProtectionData {
    __block BOOL success = NO;
    [MKMPInterface mp_readOverCurrentProtectionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        self.overThreshold = returnData[@"result"][@"overThreshold"];
        self.timeThreshold = returnData[@"result"][@"timeThreshold"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configOverCurrentProtection {
    __block BOOL success = NO;
    [MKMPInterface mp_configOverCurrent:self.isOn productModel:self.specification overThreshold:[self.overThreshold integerValue] timeThreshold:[self.timeThreshold integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readOverLoadProtectionData {
    __block BOOL success = NO;
    [MKMPInterface mp_readOverLoadProtectionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        self.overThreshold = returnData[@"result"][@"overThreshold"];
        self.timeThreshold = returnData[@"result"][@"timeThreshold"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configOverLoadProtection {
    __block BOOL success = NO;
    [MKMPInterface mp_configOverLoad:self.isOn productModel:self.specification overThreshold:[self.overThreshold integerValue] timeThreshold:[self.timeThreshold integerValue] sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"OverProtectionParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.overThreshold) || !ValidStr(self.timeThreshold) || [self.timeThreshold integerValue] < 1 || [self.timeThreshold integerValue] > 30) {
        return NO;
    }
    NSInteger maxValue = 0;
    NSInteger minValue = 0;
    if (self.type == mp_overProtectionType_load) {
        //过载
        if (self.specification == 0) {
            //欧法
            minValue = 10;
            maxValue = 4416;
        }else if (self.specification == 1) {
            //美规
            minValue = 10;
            maxValue = 2216;
        }else if (self.specification == 2) {
            //英规
            minValue = 10;
            maxValue = 3558;
        }
    }else if (self.type == mp_overProtectionType_voltage) {
        //过压
        if (self.specification == 0) {
            //欧法
            minValue = 231;
            maxValue = 264;
        }else if (self.specification == 1) {
            //美规
            minValue = 121;
            maxValue = 138;
        }else if (self.specification == 2) {
            //英规
            minValue = 231;
            maxValue = 264;
        }
    }else if (self.type == mp_overProtectionType_sagVoltage) {
        //欠压
        if (self.specification == 0) {
            //欧法
            minValue = 196;
            maxValue = 229;
        }else if (self.specification == 1) {
            //美规
            minValue = 102;
            maxValue = 119;
        }else if (self.specification == 2) {
            //英规
            minValue = 196;
            maxValue = 229;
        }
    }else if (self.type == mp_overProtectionType_current) {
        //过流
        if (self.specification == 0) {
            //欧法
            minValue = 1;
            maxValue = 192;
        }else if (self.specification == 1) {
            //美规
            minValue = 1;
            maxValue = 180;
        }else if (self.specification == 2) {
            //英规
            minValue = 1;
            maxValue = 156;
        }
    }
    if ([self.overThreshold integerValue] < minValue || [self.overThreshold integerValue] > maxValue) {
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
