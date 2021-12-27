//
//  Target_LoRaWANMP_Module.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_LoRaWANMP_Module : NSObject

/// 扫描页面
- (UIViewController *)Action_LoRaWANMP_Module_ScanController:(NSDictionary *)params;

/// 关于页面
- (UIViewController *)Action_LoRaWANMP_Module_AboutController:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
