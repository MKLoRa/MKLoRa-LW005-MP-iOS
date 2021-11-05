//
//  MKMPEnergySettingsModel.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMPEnergySettingsModel : NSObject

@property (nonatomic, copy)NSString *reportInterval;

@property (nonatomic, copy)NSString *saveInterval;

@property (nonatomic, copy)NSString *powerChangeValue;

@property (nonatomic, copy)NSString *totalEnergy;

@end

NS_ASSUME_NONNULL_END
