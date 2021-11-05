//
//  CBPeripheral+MKMPAdd.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/11/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKMPAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *mp_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *mp_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *mp_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *mp_sofeware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *mp_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *mp_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *mp_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *mp_custom;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *mp_deviceControl;

- (void)mp_updateCharacterWithService:(CBService *)service;

- (void)mp_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)mp_connectSuccess;

- (void)mp_setNil;

@end

NS_ASSUME_NONNULL_END
