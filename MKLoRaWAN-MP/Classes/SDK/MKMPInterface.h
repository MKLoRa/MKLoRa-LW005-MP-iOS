//
//  MKMPInterface.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/11/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKMPSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKMPInterface : NSObject

#pragma mark ****************************************Device Service Information************************************************

/// Read product model
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device firmware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device hardware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device software information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device manufacturer information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** LoRaWAN ************************************************

/// Read LoRaWAN network access type.
/*
 1:ABP
 2:OTAA
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVADDR of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the NWKSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the region information of LoRaWAN.
/*
 0:AS923 
 1:AU915
 2:CN470
 3:CN779
 4:EU433
 5:EU868
 6:KR920
 7:IN865
 8:US915
 9:RU864
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the work mode of LoRaWAN.
/*
 0:Class A. 
 2:Class C.
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanClassTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan upstream data type.
/*
 0:Non-acknowledgement frame.
 1:Confirm the frame.
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan CH.It is only used for US915,AU915,CN470.
/*
 @{
 @"CHL":0
 @"CHH":2
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan duty cycle status.It is only used for EU868,CN779, EU433 and RU864.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan DR.It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.
/*
 @{
 @"DR":1
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Uplink Strategy  Of Lorawan.
/*
 @{
 @"ADR":@(YES),
 @"DRFPL":@"0",         //DR For Payload Low.
 @"DRFPH":@"1",         //DR For Payload High.
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read The Max retransmission times  Of Lorawan.(Only for the message type is confirmed.)
/*
 @{
 @"number":@"2"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanMaxRetransmissionTimesWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;


/// Read lorawan devtime command synchronization interval.(Hour)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Network Check Interval Of Lorawan.(Hour)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** BLE Params ************************************************
/// Read the broadcast name of the device.
/*
 @{
 @"deviceName":@"MOKO"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device broadcast time interval.(Unit:100ms)
/*
 @{
 @"interval":@"10"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the txPower of device.
/*
 @{
 @"txPower":@"0dBm"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Bluetooth connection status of the device.When the device is set to be unconnectable, 3min is allowed to connect after the beacon mode is turned on.
/*
 @{
 @"connectable":@(YES),
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readDeviceConnectableWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Is a password required when the device is connected.
/*
 @{
 @"need":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// When the connected device requires a password, read the current connection password.
/*
 @{
 @"password":@"xxxxxxxxx"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** 功能参数 ************************************************

/// Default Operating mode after the device is repowered.
/*
 @{
 @"mode":@"1"
 }
 0: Off mode
 1:On mode
 2:Revert to last mode
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readRepoweredDefaultModeWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// The report interval of switch payloads.
/*
 @{
 @"interval":@"66"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readReportIntervalOfSwitchPayloadsWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock;

/// The report interval of electricity payloads.
/*
 @{
 @"interval":@"66"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readReportIntervalOfElectricityWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the energy storage and reporting interval.
/*
 @{
     @"saveInterval":@"60",
     @"repoertInterval":@"60",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readEnergyIntervalParamsWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// When the percentage change in power exceeds power change value, device will immediately store the energy data.
/*
 @{
 @"value":@"10"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readPowerChangeValueWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the specifications of the device.
/*
 @{
 @"specification":0             //0:European and French specifications    1:U.S. specifications   2:U.K specifications
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readSpecificationsOfDeviceWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device overvoltage protection information.
/*
 @{
     @"isOn":@(isOn),
     @"overThreshold":@"100",           //V
     @"timeThreshold":@"10",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readOverVoltageProtectionWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device sagvoltage protection information.
/*
 @{
     @"isOn":@(isOn),
     @"overThreshold":@"10",            //V
     @"timeThreshold":@"10",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readSagVoltageProtectionWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device overcurrent protection information.
/*
 @{
     @"isOn":@(isOn),
     @"overThreshold":@"10",        //Unit:0.1A
     @"timeThreshold":@"10",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readOverCurrentProtectionWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device overload protection information.
/*
 @{
     @"isOn":@(isOn),
     @"overThreshold":@"100",           //W
     @"timeThreshold":@"10",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readOverLoadProtectionWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the notification status when the device load status changes.
/*
 @{
     @"loadStart":@(NO),
     @"loadStop":@(YES),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLoadStatusNotificationsWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the negative number P0 of the socket when the socket is not included in the load.
/*
 @{
 @"value":@"6"
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLoadStatusThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Power Indicator Color
/*
 @{
     @"colorType":@"0",
     @"blue":@"66",
     @"green":@"77",
     @"yellow":@"88",
     @"orange":@"99",
     @"red":@"100",
     @"purple":@"110",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readPowerIndicatorColorWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the time zone of the device.
/*
 @{
 @"timeZone":@(-23)       //UTC-11:30
 }
 //-24~28((The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00))
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// The report interval of countdown payloads.
/*
 @{
 @"interval":@(15)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readCountDownReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Network Indicator Status/Power Indicator Status
/*
 @{
     @"powerStatus":@(YES),
     @"networkStatus":@(NO),
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLEDIndicatorStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** Device Control ************************************************

/// Read the switch status of device.
/*
 @{
 @"isOn":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readSwitchStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the current network status of LoRaWAN.
/*
    0:Connecting
    1:OTAA network access or ABP mode.
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device load status.
/*
 @{
 @"load":@(YES)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readLoadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Electricity of the device.
/*
 @{
 @"voltage":@"110.2",           //(V)
 @"current":@"0.001",           //(A)
 @"power":@"1.1",               //(W)
 @"frequencyOfCurrent":@"1.111",//Frequency of current(Hz)
 @"powerFactor":@"1",           //Power factor(%)
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readElectricityDataWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Energy of the device.
/*
 @{
     @"totalRounds":@"10000",
     @"lastHourRounds":@"100",
     @"EC":@"50",
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readEnergyDataWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the mac address of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
