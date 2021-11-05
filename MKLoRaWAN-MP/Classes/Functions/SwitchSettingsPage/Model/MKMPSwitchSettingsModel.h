//
//  MKMPSwitchSettingsModel.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMPSwitchSettingsModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, copy)NSString *interval;

/// 0:On   1:Off    2:Resore Last Mode
@property (nonatomic, assign)NSInteger mode;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
