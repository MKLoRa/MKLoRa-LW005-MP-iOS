//
//  MKMPSDKDataAdopter.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/11/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKMPSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKMPSDKDataAdopter : NSObject

+ (NSString *)lorawanRegionString:(mk_mp_loraWanRegion)region;

+ (NSString *)fetchTxPower:(mk_mp_txPower)txPower;

+ (BOOL)checkLEDColorParams:(mk_mp_ledColorType)colorType
              colorProtocol:(nullable id <mk_mp_ledColorConfigProtocol>)protocol
               productModel:(mk_mp_productModel)productModel;

@end

NS_ASSUME_NONNULL_END
