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

@end
