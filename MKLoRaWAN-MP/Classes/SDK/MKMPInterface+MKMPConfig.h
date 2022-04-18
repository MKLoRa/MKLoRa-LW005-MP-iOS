//
//  MKMPInterface+MKMPConfig.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/11/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKMPInterface (MKMPConfig)

#pragma mark ****************************************设备lorawan信息设置************************************************

/// Configure LoRaWAN network access type.
/// @param modem modem
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configModem:(mk_mp_loraWanModem)modem
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVEUI of LoRaWAN.
/// @param devEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configDEVEUI:(NSString *)devEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPEUI of LoRaWAN.
/// @param appEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configAPPEUI:(NSString *)appEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPKEY of LoRaWAN.
/// @param appKey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configAPPKEY:(NSString *)appKey
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVADDR of LoRaWAN.
/// @param devAddr Hexadecimal characters, length must be 8.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configDEVADDR:(NSString *)devAddr
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPSKEY of LoRaWAN.
/// @param appSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configAPPSKEY:(NSString *)appSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the NWKSKEY of LoRaWAN.
/// @param nwkSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configNWKSKEY:(NSString *)nwkSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the region information of LoRaWAN.
/// @param region region
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configRegion:(mk_mp_loraWanRegion)region
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN class type.
/// @param classType classType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configClassType:(mk_mp_loraWanClassType)classType
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the message type of LoRaWAN.
/// @param messageType messageType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configMessageType:(mk_mp_loraWanMessageType)messageType
                    sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the CH of LoRaWAN.It is only used for US915,AU915,CN470.
/// @param chlValue Minimum value of CH.0 ~ 95
/// @param chhValue Maximum value of CH. chlValue ~ 95
/// @param sucBlock Success callback
/// @param failedBlock  Failure callback
+ (void)mp_configCHL:(NSInteger)chlValue
                 CHH:(NSInteger)chhValue
            sucBlock:(void (^)(void))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock;

/// It is only used for EU868,CN779, EU433 and RU864. Off: The uplink report interval will not be limit by region freqency. On:The uplink report interval will be limit by region freqency.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configDutyCycleStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DR of LoRaWAN.It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.
/// @param drValue 0~5
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configDR:(NSInteger)drValue
           sucBlock:(void (^)(void))sucBlock
        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN uplink data sending strategy.
/// @param isOn ADR is on.
/// @param DRL When the ADR switch is off, the range is 0~6.
/// @param DRH When the ADR switch is off, the range is DRL~6
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configUplinkStrategy:(BOOL)isOn
                            DRL:(NSInteger)DRL
                            DRH:(NSInteger)DRH
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure The Max retransmission times  Of Lorawan.(Only for the message type is confirmed.)
/// @param times 1~8
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configLorawanMaxRetransmissionTimes:(NSInteger)times
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Time Sync Interval.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configTimeSyncInterval:(NSInteger)interval
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Network Check Interval Of Lorawan.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configLorawanNetworkCheckInterval:(NSInteger)interval
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** BLE Params ************************************************
/// Configure the broadcast name of the device.
/// @param deviceName 0~16 ascii characters
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configDeviceName:(NSString *)deviceName
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure beacon broadcast time interval.
/// @param interval 1 x 100ms ~ 100 x 100ms
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configAdvInterval:(NSInteger)interval
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the txPower of device.
/// @param txPower txPower
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configTxPower:(mk_mp_txPower)txPower
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the connectable status of the device.
/// @param connectable connectable
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configConnectableStatus:(BOOL)connectable
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Do you need a password when configuring the device connection.
/// @param need need
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configNeedPassword:(BOOL)need
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the connection password of device.
/// @param password 8-character ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configPassword:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** 功能参数 ************************************************
/// Default Operating mode after the device is repowered.
/// @param mode mode
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configRepoweredDefaultMode:(mk_mp_repoweredDefaultMode)mode
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// The report interval of switch payloads.
/// @param interval 10s~600s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configReportIntervalOfSwitchPayloads:(NSInteger)interval
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// The report interval of electricity payloads.
/// @param interval 5s~600s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configReportIntervalOfElectricity:(NSInteger)interval
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the energy storage and reporting interval.
/// @param reportInterval 1min~60mins
/// @param saveInterval 1min~60mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configEnergyReportInterval:(NSInteger)reportInterval
                         saveInterval:(NSInteger)saveInterval
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// When the percentage change in power exceeds power change value, device will immediately store the energy data.
/// @param value 1%~100%
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configPowerChangeValue:(NSInteger)value
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure device overvoltage protection information.
/// @param isOn Open function
/// @param productModel Specification and model of the equipment
/// @param overThreshold Overvoltage protection value, Europe and France: 231~264V, U.K: 231~264V, America: 121~138V.
/// @param timeThreshold 1s~30s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configOverVoltage:(BOOL)isOn
                productModel:(mk_mp_productModel)productModel
               overThreshold:(NSInteger)overThreshold
               timeThreshold:(NSInteger)timeThreshold
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure device sagvoltage protection information.
/// @param isOn Open function
/// @param productModel Specification and model of the equipment
/// @param overThreshold Sagvoltage protection value, Europe and France: 196~229V, U.K: 196~229V, America: 102~119V.
/// @param timeThreshold 1s~30s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configSagVoltage:(BOOL)isOn
               productModel:(mk_mp_productModel)productModel
              overThreshold:(NSInteger)overThreshold
              timeThreshold:(NSInteger)timeThreshold
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure device overcurrent protection information.
/// @param isOn Open function
/// @param productModel Specification and model of the equipment
/// @param overThreshold Overcurrent protection value, Europe and France: 1~192(0.1A), U.K: 1~156(0.1A), America: 1~180(0.1A).
/// @param timeThreshold 1s~30s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configOverCurrent:(BOOL)isOn
                productModel:(mk_mp_productModel)productModel
               overThreshold:(NSInteger)overThreshold
               timeThreshold:(NSInteger)timeThreshold
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure device overload protection information.
/// @param isOn Open function
/// @param productModel Specification and model of the equipment
/// @param overThreshold Overload protection value, Europe and France: 10~4416W, U.K: 10~3558W, America: 10~2160W.
/// @param timeThreshold 1s~30s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configOverLoad:(BOOL)isOn
             productModel:(mk_mp_productModel)productModel
            overThreshold:(NSInteger)overThreshold
            timeThreshold:(NSInteger)timeThreshold
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the notification status when the device load status changes.
/// @param startIsOn Load Start Notification Is On.
/// @param stopIsOn Load Stop Notification Is On.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configLoadStatusNotifications:(BOOL)startIsOn
                                stopIsOn:(BOOL)stopIsOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the negative number P0 of the socket when the socket is not included in the load.
/// @param threshold 1~10(0.1W)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configLoadStatusThreshold:(NSInteger)threshold
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Power Indicator Color
/// @param colorType colorType
/// @param protocol  mk_mp_ledColorConfigProtocol,Note: When colorType is one of mk_mp_ledColorTransitionSmoothly and mk_mp_ledColorTransitionDirectly, it cannot be empty, other types are not checked.
/// @param productModel Product model of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configPowerIndicatorColor:(mk_mp_ledColorType)colorType
                       colorProtocol:(nullable id <mk_mp_ledColorConfigProtocol>)protocol
                        productModel:(mk_mp_productModel)productModel
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the time zone of the device.
/// @param timeZone -24~28  //(The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00.eg:timeZone = -23 ,--> UTC-11:30)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configTimeZone:(NSInteger)timeZone
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;


/// The report interval of countdown payloads.
/// @param interval 10s~60s
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configCountDownReportInterval:(NSInteger)interval
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Network Indicator Status/Power Indicator Status
/// @param network isOn
/// @param power isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configNetworkIndicatorStatus:(BOOL)network
                   powerIndicatorStatus:(BOOL)power
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** Device Control ************************************************

/// Configure the switch status of device.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configSwitchStatus:(BOOL)isOn
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Restart the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_restartDeviceWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Sync device time.
/// @param timestamp UTC
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_configDeviceTime:(unsigned long)timestamp
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)mp_factoryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
