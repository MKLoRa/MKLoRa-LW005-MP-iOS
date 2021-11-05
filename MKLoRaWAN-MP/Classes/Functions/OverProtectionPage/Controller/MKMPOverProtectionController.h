//
//  MKMPOverProtectionController.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

#import "MKMPEnumerateDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKMPOverProtectionController : MKBaseViewController

- (instancetype)initWithPageType:(mp_overProtectionType)type;

@end

NS_ASSUME_NONNULL_END
