//
//  MKMPLoadStatusModel.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMPLoadStatusModel : NSObject

@property (nonatomic, assign)BOOL loadStatus;

@property (nonatomic, assign)BOOL loadStart;

@property (nonatomic, assign)BOOL loadStop;

@property (nonatomic, copy)NSString *threshold;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
