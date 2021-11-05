//
//  MKMPOverProtectionModel.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKMPEnumerateDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKMPOverProtectionModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, copy)NSString *overThreshold;

@property (nonatomic, copy)NSString *timeThreshold;

- (instancetype)initWithType:(mp_overProtectionType)type;

@end

NS_ASSUME_NONNULL_END
