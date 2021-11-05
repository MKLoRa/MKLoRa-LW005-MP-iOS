//
//  MKMPInterface+MKMPConfig.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/11/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPInterface+MKMPConfig.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKMPCentralManager.h"
#import "MKMPOperationID.h"
#import "MKMPOperation.h"
#import "CBPeripheral+MKMPAdd.h"
#import "MKMPSDKDataAdopter.h"

#define centralManager [MKMPCentralManager shared]

@implementation MKMPInterface (MKMPConfig)

#pragma mark ****************************************设备lorawan信息设置************************************************

+ (void)mp_configModem:(mk_mp_loraWanModem)modem
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (modem == mk_mp_loraWanModemABP) ? @"ed01010101" : @"ed01010102";
    [self configDataWithTaskID:mk_mp_taskConfigModemOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configDEVEUI:(NSString *)devEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(devEUI) || devEUI.length != 16 || ![MKBLEBaseSDKAdopter checkHexCharacter:devEUI]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed010208" stringByAppendingString:devEUI];
    [self configDataWithTaskID:mk_mp_taskConfigDEVEUIOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configAPPEUI:(NSString *)appEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(appEUI) || appEUI.length != 16 || ![MKBLEBaseSDKAdopter checkHexCharacter:appEUI]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed010308" stringByAppendingString:appEUI];
    [self configDataWithTaskID:mk_mp_taskConfigAPPEUIOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configAPPKEY:(NSString *)appKey
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(appKey) || appKey.length != 32 || ![MKBLEBaseSDKAdopter checkHexCharacter:appKey]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed010410" stringByAppendingString:appKey];
    [self configDataWithTaskID:mk_mp_taskConfigAPPKEYOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configDEVADDR:(NSString *)devAddr
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(devAddr) || devAddr.length != 8 || ![MKBLEBaseSDKAdopter checkHexCharacter:devAddr]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed010504" stringByAppendingString:devAddr];
    [self configDataWithTaskID:mk_mp_taskConfigDEVADDROperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configAPPSKEY:(NSString *)appSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(appSkey) || appSkey.length != 32 || ![MKBLEBaseSDKAdopter checkHexCharacter:appSkey]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed010610" stringByAppendingString:appSkey];
    [self configDataWithTaskID:mk_mp_taskConfigAPPSKEYOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configNWKSKEY:(NSString *)nwkSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(nwkSkey) || nwkSkey.length != 32 || ![MKBLEBaseSDKAdopter checkHexCharacter:nwkSkey]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed010710" stringByAppendingString:nwkSkey];
    [self configDataWithTaskID:mk_mp_taskConfigNWKSKEYOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configRegion:(mk_mp_loraWanRegion)region
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed010801",[MKMPSDKDataAdopter lorawanRegionString:region]];
    [self configDataWithTaskID:mk_mp_taskConfigRegionOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configClassType:(mk_mp_loraWanClassType)classType
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (classType == mk_mp_loraWanClassTypeC) ? @"ed01090102" : @"ed01090100";
    [self configDataWithTaskID:mk_mp_taskConfigClassTypeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configMessageType:(mk_mp_loraWanMessageType)messageType
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (messageType == mk_mp_loraWanUnconfirmMessage) ? @"ed010a0100" : @"ed010a0101";
    [self configDataWithTaskID:mk_mp_taskConfigMessageTypeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configCHL:(NSInteger)chlValue
                 CHH:(NSInteger)chhValue
            sucBlock:(void (^)(void))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock {
    if (chlValue < 0 || chlValue > 95 || chhValue < chlValue || chhValue > 95) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *lowValue = [MKBLEBaseSDKAdopter fetchHexValue:chlValue byteLen:1];
    NSString *highValue = [MKBLEBaseSDKAdopter fetchHexValue:chhValue byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed010b02",lowValue,highValue];
    [self configDataWithTaskID:mk_mp_taskConfigCHValueOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configDutyCycleStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed010c0101" : @"ed010c0100");
    [self configDataWithTaskID:mk_mp_taskConfigDutyCycleStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configDR:(NSInteger)drValue
           sucBlock:(void (^)(void))sucBlock
        failedBlock:(void (^)(NSError *error))failedBlock {
    if (drValue < 0 || drValue > 5) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:drValue byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed010d01",value];
    [self configDataWithTaskID:mk_mp_taskConfigDRValueOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configUplinkStrategy:(BOOL)isOn
                            DRL:(NSInteger)DRL
                            DRH:(NSInteger)DRH
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (!isOn && (DRL < 0 || DRL > 5 || DRH < DRL || DRH > 5)) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    
    NSString *lowValue = [MKBLEBaseSDKAdopter fetchHexValue:DRL byteLen:1];
    NSString *highValue = [MKBLEBaseSDKAdopter fetchHexValue:DRH byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",@"ed010e04",(isOn ? @"01" : @"00"),@"01",lowValue,highValue];
    [self configDataWithTaskID:mk_mp_taskConfigUplinkStrategyOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mk_configLorawanMaxRetransmissionTimes:(NSInteger)times
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (times < 1 || times > 8) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:times byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed010f01",value];
    [self configDataWithTaskID:mk_mp_taskConfigMaxRetransmissionTimesOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configTimeSyncInterval:(NSInteger)interval
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 0 || interval > 255) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed011001" stringByAppendingString:value];
    [self configDataWithTaskID:mk_mp_taskConfigTimeSyncIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configLorawanNetworkCheckInterval:(NSInteger)interval
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 0 || interval > 255) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed011101" stringByAppendingString:value];
    [self configDataWithTaskID:mk_mp_taskConfigNetworkCheckIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark **************************************** BLE Params ************************************************


#pragma mark **************************************** 功能参数 ************************************************

+ (void)mp_configRepoweredDefaultMode:(mk_mp_repoweredDefaultMode)mode
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *modeString = @"00";
    if (mode == mk_mp_repoweredDefaultMode_onMode) {
        modeString = @"01";
    }else if (mode == mk_mp_repoweredDefaultMode_revertToLastMode) {
        modeString = @"02";
    }
    NSString *commandString = [@"ed014101" stringByAppendingString:modeString];
    [self configDataWithTaskID:mk_mp_taskConfigRepoweredDefaultModeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configReportIntervalOfSwitchPayloads:(NSInteger)interval
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 10 || interval > 600) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:2];
    NSString *commandString = [@"ed014202" stringByAppendingString:value];
    [self configDataWithTaskID:mk_mp_taskConfigReportIntervalOfSwitchPayloadsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configReportIntervalOfElectricity:(NSInteger)interval
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 5 || interval > 600) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:2];
    NSString *commandString = [@"ed014302" stringByAppendingString:value];
    [self configDataWithTaskID:mk_mp_taskConfigReportIntervalOfElectricityOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configEnergyReportInterval:(NSInteger)reportInterval
                         saveInterval:(NSInteger)saveInterval
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    if (reportInterval < 1 || reportInterval > 60 || saveInterval < 1 || saveInterval > 60) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *reportValue = [MKBLEBaseSDKAdopter fetchHexValue:reportInterval byteLen:1];
    NSString *saveValue = [MKBLEBaseSDKAdopter fetchHexValue:saveInterval byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed014402",saveValue,reportValue];
    [self configDataWithTaskID:mk_mp_taskConfigEnergyIntervalParamsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configPowerChangeValue:(NSInteger)value
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (value < 1 || value > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *valueString = [MKBLEBaseSDKAdopter fetchHexValue:value byteLen:1];
    NSString *commandString = [@"ed014501" stringByAppendingString:valueString];
    [self configDataWithTaskID:mk_mp_taskConfigPowerChangeValueOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configOverVoltage:(BOOL)isOn
                productModel:(mk_mp_productModel)productModel
               overThreshold:(NSInteger)overThreshold
               timeThreshold:(NSInteger)timeThreshold
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSInteger minValue = 231;
    NSInteger maxValue = 264;
    if (productModel == mk_mp_productModel_America) {
        //美规
        minValue = 121;
        maxValue = 138;
    }
    if (overThreshold < minValue || overThreshold > maxValue || timeThreshold < 1 || timeThreshold > 30) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *status = (isOn ? @"01" : @"00");
    NSString *overValueString = [MKBLEBaseSDKAdopter fetchHexValue:overThreshold byteLen:2];
    NSString *timeValueString = [MKBLEBaseSDKAdopter fetchHexValue:timeThreshold byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ed014704",status,overValueString,timeValueString];
    [self configDataWithTaskID:mk_mp_taskConfigOverVoltageOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configSagVoltage:(BOOL)isOn
               productModel:(mk_mp_productModel)productModel
              overThreshold:(NSInteger)overThreshold
              timeThreshold:(NSInteger)timeThreshold
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    NSInteger minValue = 196;
    NSInteger maxValue = 229;
    if (productModel == mk_mp_productModel_America) {
        //美规
        minValue = 102;
        maxValue = 119;
    }
    if (overThreshold < minValue || overThreshold > maxValue || timeThreshold < 1 || timeThreshold > 30) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *status = (isOn ? @"01" : @"00");
    NSString *overValueString = [MKBLEBaseSDKAdopter fetchHexValue:overThreshold byteLen:1];
    NSString *timeValueString = [MKBLEBaseSDKAdopter fetchHexValue:timeThreshold byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ed014803",status,overValueString,timeValueString];
    [self configDataWithTaskID:mk_mp_taskConfigSagVoltageOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configOverCurrent:(BOOL)isOn
                productModel:(mk_mp_productModel)productModel
               overThreshold:(NSInteger)overThreshold
               timeThreshold:(NSInteger)timeThreshold
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSInteger minValue = 1;
    NSInteger maxValue = 192;
    if (productModel == mk_mp_productModel_America) {
        //美规
        minValue = 1;
        maxValue = 180;
    }else if (productModel == mk_mp_productModel_UK) {
        //英规
        minValue = 1;
        maxValue = 156;
    }
    if (overThreshold < minValue || overThreshold > maxValue || timeThreshold < 1 || timeThreshold > 30) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *status = (isOn ? @"01" : @"00");
    NSString *overValueString = [MKBLEBaseSDKAdopter fetchHexValue:overThreshold byteLen:1];
    NSString *timeValueString = [MKBLEBaseSDKAdopter fetchHexValue:timeThreshold byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ed014903",status,overValueString,timeValueString];
    [self configDataWithTaskID:mk_mp_taskConfigOverCurrentOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configOverLoad:(BOOL)isOn
             productModel:(mk_mp_productModel)productModel
            overThreshold:(NSInteger)overThreshold
            timeThreshold:(NSInteger)timeThreshold
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    NSInteger minValue = 10;
    NSInteger maxValue = 4416;
    if (productModel == mk_mp_productModel_America) {
        //美规
        minValue = 10;
        maxValue = 2216;
    }else if (productModel == mk_mp_productModel_UK) {
        //英规
        minValue = 10;
        maxValue = 3558;
    }
    if (overThreshold < minValue || overThreshold > maxValue || timeThreshold < 1 || timeThreshold > 30) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *status = (isOn ? @"01" : @"00");
    NSString *overValueString = [MKBLEBaseSDKAdopter fetchHexValue:overThreshold byteLen:2];
    NSString *timeValueString = [MKBLEBaseSDKAdopter fetchHexValue:timeThreshold byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ed014a04",status,overValueString,timeValueString];
    [self configDataWithTaskID:mk_mp_taskConfigOverLoadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configLoadStatusNotifications:(BOOL)startIsOn
                                stopIsOn:(BOOL)stopIsOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *startValue = (startIsOn ? @"01" : @"00");
    NSString *stopValue = (stopIsOn ? @"01" : @"00");
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed014b02",startValue,stopValue];
    [self configDataWithTaskID:mk_mp_taskConfigLoadStatusNotificationsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)mp_configLoadStatusThreshold:(NSInteger)threshold
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (threshold < 1 || threshold > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:threshold byteLen:1];
    NSString *commandString = [@"ed014c01" stringByAppendingString:value];
    [self configDataWithTaskID:mk_mp_taskConfigLoadStatusThresholdOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark **************************************** Device Control ************************************************

+ (void)mp_configSwitchStatus:(BOOL)isOn
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01610101" : @"ed01610100");
    [self configDeviceControlDataWithTaskID:mk_mp_taskConfigSwitchStatusOperation
                                       data:commandString
                                   sucBlock:sucBlock
                                failedBlock:failedBlock];
}

+ (void)mp_restartDeviceWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed016600";
    [self configDeviceControlDataWithTaskID:mk_mp_taskRestartDeviceOperation
                                       data:commandString
                                   sucBlock:sucBlock
                                failedBlock:failedBlock];
}

#pragma mark - private method
+ (void)configDataWithTaskID:(mk_mp_taskOperationID)taskID
                        data:(NSString *)data
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addTaskWithTaskID:taskID characteristic:centralManager.peripheral.mp_custom commandData:data successBlock:^(id  _Nonnull returnData) {
        BOOL success = [returnData[@"result"][@"success"] boolValue];
        if (!success) {
            [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
            return ;
        }
        if (sucBlock) {
            sucBlock();
        }
    } failureBlock:failedBlock];
}

+ (void)configDeviceControlDataWithTaskID:(mk_mp_taskOperationID)taskID
                                     data:(NSString *)data
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addTaskWithTaskID:taskID characteristic:centralManager.peripheral.mp_deviceControl commandData:data successBlock:^(id  _Nonnull returnData) {
        BOOL success = [returnData[@"result"][@"success"] boolValue];
        if (!success) {
            [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
            return ;
        }
        if (sucBlock) {
            sucBlock();
        }
    } failureBlock:failedBlock];
}

@end
