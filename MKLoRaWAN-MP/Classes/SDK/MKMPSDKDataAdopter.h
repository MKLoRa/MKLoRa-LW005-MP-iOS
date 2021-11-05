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

@end

NS_ASSUME_NONNULL_END
