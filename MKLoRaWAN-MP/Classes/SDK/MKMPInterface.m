//
//  MKMPInterface.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/11/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPInterface.h"

#import "MKMPCentralManager.h"
#import "MKMPOperationID.h"
#import "MKMPOperation.h"
#import "CBPeripheral+MKMPAdd.h"

#define centralManager [MKMPCentralManager shared]
#define peripheral ([MKMPCentralManager shared].peripheral)

@implementation MKMPInterface

#pragma mark ****************************************Device Service Information************************************************

+ (void)mp_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_mp_taskReadDeviceModelOperation
                           characteristic:peripheral.mp_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)mp_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_mp_taskReadFirmwareOperation
                           characteristic:peripheral.mp_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)mp_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_mp_taskReadHardwareOperation
                           characteristic:peripheral.mp_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)mp_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_mp_taskReadSoftwareOperation
                           characteristic:peripheral.mp_sofeware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)mp_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_mp_taskReadManufacturerOperation
                           characteristic:peripheral.mp_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark **************************************** LoRaWAN ************************************************

+ (void)mp_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanModemOperation
                     cmdFlag:@"01"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanDEVEUIOperation
                     cmdFlag:@"02"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanAPPEUIOperation
                     cmdFlag:@"03"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanAPPKEYOperation
                     cmdFlag:@"04"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanDEVADDROperation
                     cmdFlag:@"05"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanAPPSKEYOperation
                     cmdFlag:@"06"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanNWKSKEYOperation
                     cmdFlag:@"07"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanRegionOperation
                     cmdFlag:@"08"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanClassTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanClassTypeOperation
                     cmdFlag:@"09"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanMessageTypeOperation
                     cmdFlag:@"0a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanCHOperation
                     cmdFlag:@"0b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanDutyCycleStatusOperation
                     cmdFlag:@"0c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanDROperation
                     cmdFlag:@"0d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanUplinkStrategyOperation
                     cmdFlag:@"0e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanMaxRetransmissionTimesWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanMaxRetransmissionTimesOperation
                     cmdFlag:@"0f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanDevTimeSyncIntervalOperation
                     cmdFlag:@"10"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLorawanNetworkCheckIntervalOperation
                     cmdFlag:@"11"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark **************************************** BLE Params ************************************************


#pragma mark **************************************** 功能参数 ************************************************

+ (void)mp_readRepoweredDefaultModeWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadRepoweredDefaultModeOperation
                     cmdFlag:@"41"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readReportIntervalOfSwitchPayloadsWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadReportIntervalOfSwitchPayloadsOperation
                     cmdFlag:@"42"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readReportIntervalOfElectricityWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadReportIntervalOfElectricityOperation
                     cmdFlag:@"43"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readEnergyIntervalParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadEnergyIntervalParamsOperation
                     cmdFlag:@"44"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readPowerChangeValueWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadPowerChangeValueOperation
                     cmdFlag:@"45"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readSpecificationsOfDeviceWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadSpecificationsOfDeviceOperation
                     cmdFlag:@"46"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readOverVoltageProtectionWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadOverVoltageProtectionOperation
                     cmdFlag:@"47"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readSagVoltageProtectionWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadSagVoltageProtectionOperation
                     cmdFlag:@"48"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readOverCurrentProtectionWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadOverCurrentProtectionOperation
                     cmdFlag:@"49"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readOverLoadProtectionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadOverLoadProtectionOperation
                     cmdFlag:@"4a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLoadStatusNotificationsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLoadStatusNotificationsOperation
                     cmdFlag:@"4b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)mp_readLoadStatusThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_mp_taskReadLoadStatusThresholdOperation
                     cmdFlag:@"4c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark **************************************** Device Control ************************************************
+ (void)mp_readSwitchStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_mp_taskReadSwitchStatusOperation
                                  cmdFlag:@"61"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)mp_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_mp_taskReadLorawanNetworkStatusOperation
                                  cmdFlag:@"62"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)mp_readLoadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_mp_taskReadLoadStatusOperation
                                  cmdFlag:@"63"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)mp_readElectricityDataWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_mp_taskReadElectricityDataOperation
                                  cmdFlag:@"64"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)mp_readEnergyDataWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_mp_taskReadEnergyDataOperation
                                  cmdFlag:@"65"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)mp_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_mp_taskReadMacAddressOperation
                                  cmdFlag:@"68"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

#pragma mark - private method

+ (void)readDataWithTaskID:(mk_mp_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.mp_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)readDeviceControlDataWithTaskID:(mk_mp_taskOperationID)taskID
                                cmdFlag:(NSString *)flag
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.mp_deviceControl
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
