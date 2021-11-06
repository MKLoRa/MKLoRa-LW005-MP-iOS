//
//  MKMPIndicatorColorModel.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPIndicatorColorModel.h"

#import "MKMacroDefines.h"

#import "MKMPInterface.h"
#import "MKMPInterface+MKMPConfig.h"

@interface MKMPIndicatorColorModel ()

@property (nonatomic, assign)mp_productModel productModel;

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKMPIndicatorColorModel
- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readSpecification]) {
            [self operationFailedBlockWithMsg:@"Read Product Model Error" block:failedBlock];
            return;
        }
        if (![self readColorDatas]) {
            [self operationFailedBlockWithMsg:@"Read Power Indicator Color Error" block:failedBlock];
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
        if (![self configColorDatas]) {
            [self operationFailedBlockWithMsg:@"Config Power Indicator Color Error" block:failedBlock];
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
- (BOOL)readSpecification {
    __block BOOL success = NO;
    [MKMPInterface mp_readSpecificationsOfDeviceWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.productModel = [returnData[@"result"][@"specification"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readColorDatas {
    __block BOOL success = NO;
    [MKMPInterface mp_readPowerIndicatorColorWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.colorType = [returnData[@"result"][@"colorType"] integerValue];
        self.b_color = [returnData[@"result"][@"blue"] integerValue];
        self.g_color = [returnData[@"result"][@"green"] integerValue];
        self.y_color = [returnData[@"result"][@"yellow"] integerValue];
        self.o_color = [returnData[@"result"][@"orange"] integerValue];
        self.r_color = [returnData[@"result"][@"red"] integerValue];
        self.p_color = [returnData[@"result"][@"purple"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configColorDatas {
    __block BOOL success = NO;
    [MKMPInterface mp_configPowerIndicatorColor:self.colorType colorProtocol:self productModel:self.productModel sucBlock:^{
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
        NSError *error = [[NSError alloc] initWithDomain:@"IndicatorColorParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
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
        _readQueue = dispatch_queue_create("IndicatorColorQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
