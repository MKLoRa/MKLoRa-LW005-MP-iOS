//
//  MKMPSDKDataAdopter.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/11/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPSDKDataAdopter.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

@implementation MKMPSDKDataAdopter

+ (NSString *)lorawanRegionString:(mk_mp_loraWanRegion)region {
    switch (region) {
        case mk_mp_loraWanRegionAS923:
            return @"00";
        case mk_mp_loraWanRegionAU915:
            return @"01";
        case mk_mp_loraWanRegionCN470:
            return @"02";
        case mk_mp_loraWanRegionCN779:
            return @"03";
        case mk_mp_loraWanRegionEU433:
            return @"04";
        case mk_mp_loraWanRegionEU868:
            return @"05";
        case mk_mp_loraWanRegionKR920:
            return @"06";
        case mk_mp_loraWanRegionIN865:
            return @"07";
        case mk_mp_loraWanRegionUS915:
            return @"08";
        case mk_mp_loraWanRegionRU864:
            return @"09";
    }
}

+ (NSString *)fetchTxPower:(mk_mp_txPower)txPower {
    switch (txPower) {
        case mk_mp_txPower4dBm:
            return @"04";
            
        case mk_mp_txPower3dBm:
            return @"03";
            
        case mk_mp_txPower0dBm:
            return @"00";
            
        case mk_mp_txPowerNeg4dBm:
            return @"fc";
            
        case mk_mp_txPowerNeg8dBm:
            return @"f8";
            
        case mk_mp_txPowerNeg12dBm:
            return @"f4";
            
        case mk_mp_txPowerNeg16dBm:
            return @"f0";
            
        case mk_mp_txPowerNeg20dBm:
            return @"ec";
            
        case mk_mp_txPowerNeg40dBm:
            return @"d8";
    }
}

+ (BOOL)checkLEDColorParams:(mk_mp_ledColorType)colorType
              colorProtocol:(nullable id <mk_mp_ledColorConfigProtocol>)protocol
               productModel:(mk_mp_productModel)productModel {
    if (colorType == mk_mp_ledColorTransitionSmoothly || colorType == mk_mp_ledColorTransitionDirectly) {
        if (!protocol || ![protocol conformsToProtocol:@protocol(mk_mp_ledColorConfigProtocol)]) {
            return NO;
        }
        NSInteger maxValue = 4416;
        if (productModel == mk_mp_productModel_America) {
            maxValue = 2160;
        }else if (productModel == mk_mp_productModel_UK) {
            maxValue = 3588;
        }
        if (protocol.b_color < 1 || protocol.b_color > (maxValue - 5)) {
            return NO;
        }
        if (protocol.g_color <= protocol.b_color || protocol.g_color > (maxValue - 4)) {
            return NO;
        }
        if (protocol.y_color <= protocol.g_color || protocol.y_color > (maxValue - 3)) {
            return NO;
        }
        if (protocol.o_color <= protocol.y_color || protocol.o_color > (maxValue - 2)) {
            return NO;
        }
        if (protocol.r_color <= protocol.o_color || protocol.r_color > (maxValue - 1)) {
            return NO;
        }
        if (protocol.p_color <= protocol.r_color || protocol.p_color > maxValue) {
            return NO;
        }
    }
    return YES;
}

@end
