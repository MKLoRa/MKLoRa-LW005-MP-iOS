//
//  Target_LoRaWANMP_Module.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "Target_LoRaWANMP_Module.h"

#import "MKMPScanController.h"

#import "MKMPAboutController.h"

@implementation Target_LoRaWANMP_Module

/// 扫描页面
- (UIViewController *)Action_LoRaWANMP_Module_ScanController:(NSDictionary *)params {
    return [[MKMPScanController alloc] init];
}

/// 关于页面
- (UIViewController *)Action_LoRaWANMP_Module_AboutController:(NSDictionary *)params {
    return [[MKMPAboutController alloc] init];
}

@end
