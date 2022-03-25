//
//  CBPeripheral+MKMPAdd.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/11/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKMPAdd.h"

#import <objc/runtime.h>

static const char *mp_manufacturerKey = "mp_manufacturerKey";
static const char *mp_deviceModelKey = "mp_deviceModelKey";
static const char *mp_hardwareKey = "mp_hardwareKey";
static const char *mp_softwareKey = "mp_softwareKey";
static const char *mp_firmwareKey = "mp_firmwareKey";

static const char *mp_passwordKey = "mp_passwordKey";
static const char *mp_disconnectTypeKey = "mp_disconnectTypeKey";
static const char *mp_customKey = "mp_customKey";
static const char *mp_deviceControlKey = "mp_deviceControlKey";

static const char *mp_passwordNotifySuccessKey = "mp_passwordNotifySuccessKey";
static const char *mp_disconnectTypeNotifySuccessKey = "mp_disconnectTypeNotifySuccessKey";
static const char *mp_customNotifySuccessKey = "mp_customNotifySuccessKey";
static const char *mp_deviceControlNotifySuccessKey = "mp_deviceControlNotifySuccessKey";

@implementation CBPeripheral (MKMPAdd)

- (void)mp_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &mp_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &mp_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &mp_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &mp_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &mp_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &mp_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &mp_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
                objc_setAssociatedObject(self, &mp_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &mp_deviceControlKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            [self setNotifyValue:YES forCharacteristic:characteristic];
        }
        return;
    }
}

- (void)mp_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &mp_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &mp_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        objc_setAssociatedObject(self, &mp_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        objc_setAssociatedObject(self, &mp_deviceControlNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)mp_connectSuccess {
    if (![objc_getAssociatedObject(self, &mp_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &mp_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &mp_disconnectTypeNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &mp_deviceControlNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.mp_manufacturer || !self.mp_deviceModel || !self.mp_hardware || !self.mp_software || !self.mp_firmware) {
        return NO;
    }
    if (!self.mp_password || !self.mp_disconnectType || !self.mp_custom || !self.mp_deviceControl) {
        return NO;
    }
    return YES;
}

- (void)mp_setNil {
    objc_setAssociatedObject(self, &mp_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mp_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mp_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mp_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mp_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &mp_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mp_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mp_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mp_deviceControlKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &mp_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mp_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mp_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &mp_deviceControlNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)mp_manufacturer {
    return objc_getAssociatedObject(self, &mp_manufacturerKey);
}

- (CBCharacteristic *)mp_deviceModel {
    return objc_getAssociatedObject(self, &mp_deviceModelKey);
}

- (CBCharacteristic *)mp_hardware {
    return objc_getAssociatedObject(self, &mp_hardwareKey);
}

- (CBCharacteristic *)mp_software {
    return objc_getAssociatedObject(self, &mp_softwareKey);
}

- (CBCharacteristic *)mp_firmware {
    return objc_getAssociatedObject(self, &mp_firmwareKey);
}

- (CBCharacteristic *)mp_password {
    return objc_getAssociatedObject(self, &mp_passwordKey);
}

- (CBCharacteristic *)mp_disconnectType {
    return objc_getAssociatedObject(self, &mp_disconnectTypeKey);
}

- (CBCharacteristic *)mp_custom {
    return objc_getAssociatedObject(self, &mp_customKey);
}

- (CBCharacteristic *)mp_deviceControl {
    return objc_getAssociatedObject(self, &mp_deviceControlKey);
}

@end
