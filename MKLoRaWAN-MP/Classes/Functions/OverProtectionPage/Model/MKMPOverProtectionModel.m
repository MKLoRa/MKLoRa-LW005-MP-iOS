//
//  MKMPOverProtectionModel.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPOverProtectionModel.h"

@interface MKMPOverProtectionModel ()

@property (nonatomic, assign)mp_overProtectionType type;

@property (nonatomic, assign)mp_productModel productModel;

@end

@implementation MKMPOverProtectionModel

- (instancetype)initWithType:(mp_overProtectionType)type {
    if (self = [self init]) {
        self.type = type;
    }
    return self;
}

@end
