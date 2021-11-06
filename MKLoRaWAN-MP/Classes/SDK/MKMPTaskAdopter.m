//
//  MKMPTaskAdopter.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/11/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKMPOperationID.h"
#import "MKMPSDKDataAdopter.h"

@implementation MKMPTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
        //产品型号
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"modeID":tempString} operationID:mk_mp_taskReadDeviceModelOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_mp_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_mp_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
        //soft ware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"software":tempString} operationID:mk_mp_taskReadSoftwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
        //manufacturerKey
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"manufacturer":tempString} operationID:mk_mp_taskReadManufacturerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //密码相关
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *state = @"";
        if (content.length == 10) {
            state = [content substringWithRange:NSMakeRange(8, 2)];
        }
        return [self dataParserGetDataSuccess:@{@"state":state} operationID:mk_mp_connectPasswordOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]] || [characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        return [self parseCustomData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    return @{};
}

#pragma mark - 数据解析
+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    if (![[readString substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"ed"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(6, 2)];
    if (readData.length != dataLen + 4) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    NSString *content = [readString substringWithRange:NSMakeRange(8, dataLen * 2)];
    if ([flag isEqualToString:@"00"]) {
        //读取
        return [self parseCustomReadData:content cmd:cmd data:readData];
    }
    if ([flag isEqualToString:@"01"]) {
        return [self parseCustomConfigData:content cmd:cmd];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_mp_taskOperationID operationID = mk_mp_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@"01"]) {
        //读取LoRaWAN入网类型
        resultDic = @{
            @"modem":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadLorawanModemOperation;
    }else if ([cmd isEqualToString:@"02"]) {
        //读取LoRaWAN DEVEUI
        resultDic = @{
            @"devEUI":content,
        };
        operationID = mk_mp_taskReadLorawanDEVEUIOperation;
    }else if ([cmd isEqualToString:@"03"]) {
        //读取LoRaWAN APPEUI
        resultDic = @{
            @"appEUI":content
        };
        operationID = mk_mp_taskReadLorawanAPPEUIOperation;
    }else if ([cmd isEqualToString:@"04"]) {
        //读取LoRaWAN APPKEY
        resultDic = @{
            @"appKey":content
        };
        operationID = mk_mp_taskReadLorawanAPPKEYOperation;
    }else if ([cmd isEqualToString:@"05"]) {
        //读取LoRaWAN DEVADDR
        resultDic = @{
            @"devAddr":content
        };
        operationID = mk_mp_taskReadLorawanDEVADDROperation;
    }else if ([cmd isEqualToString:@"06"]) {
        //读取LoRaWAN APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_mp_taskReadLorawanAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"07"]) {
        //读取LoRaWAN nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_mp_taskReadLorawanNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"08"]) {
        //读取LoRaWAN频段
        resultDic = @{
            @"region":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadLorawanRegionOperation;
    }else if ([cmd isEqualToString:@"09"]) {
        //读取LoRaWAN工作模式
        resultDic = @{
            @"classType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadLorawanClassTypeOperation;
    }else if ([cmd isEqualToString:@"0a"]) {
        //读取LoRaWAN 上行数据类型
        resultDic = @{
            @"messageType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadLorawanMessageTypeOperation;
    }else if ([cmd isEqualToString:@"0b"]) {
        //读取LoRaWAN CH
        resultDic = @{
            @"CHL":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"CHH":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)]
        };
        operationID = mk_mp_taskReadLorawanCHOperation;
    }else if ([cmd isEqualToString:@"0c"]) {
        //读取LoRaWAN duty cycle
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mp_taskReadLorawanDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"0d"]) {
        //读取LoRaWAN DR
        resultDic = @{
            @"DR":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadLorawanDROperation;
    }else if ([cmd isEqualToString:@"0e"]) {
        //读取LoRaWAN 数据发送策略
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *transmissions = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        NSString *DRL = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
        NSString *DRH = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"transmissions":transmissions,
            @"DRL":DRL,
            @"DRH":DRH,
        };
        operationID = mk_mp_taskReadLorawanUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"0f"]) {
        //读取LoRaWAN 重传次数
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadLorawanMaxRetransmissionTimesOperation;
    }else if ([cmd isEqualToString:@"10"]) {
        //读取LoRaWAN devtime指令同步间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadLorawanDevTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"11"]) {
        //读取LoRaWAN LinkCheckReq指令间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadLorawanNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"21"]) {
        //读取设备广播名称
        NSData *nameData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *deviceName = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"deviceName":(MKValidStr(deviceName) ? deviceName : @""),
        };
        operationID = mk_mp_taskReadDeviceNameOperation;
    }else if ([cmd isEqualToString:@"22"]) {
        //读取广播间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"23"]) {
        //读取设备Tx Power
        NSString *txPower = [self fetchTxPowerValueString:content];
        resultDic = @{@"txPower":txPower};
        operationID = mk_mp_taskReadTxPowerOperation;
    }else if ([cmd isEqualToString:@"24"]) {
        //读取可连接状态
        BOOL connectable = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"connectable":@(connectable)
        };
        operationID = mk_mp_taskReadDeviceConnectableOperation;
    }else if ([cmd isEqualToString:@"25"]) {
        //读取密码开关
        BOOL need = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"need":@(need)
        };
        operationID = mk_mp_taskReadConnectationNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"26"]) {
        //读取密码
        NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_mp_taskReadPasswordOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //读取设备上电后模式选择
        NSString *mode = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"mode":mode,
        };
        operationID = mk_mp_taskReadRepoweredDefaultModeOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //读取开关状态上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadReportIntervalOfSwitchPayloadsOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //读取电量上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadReportIntervalOfElectricityOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //读取电能存储与上报间隔
        resultDic = @{
            @"saveInterval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"repoertInterval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)],
        };
        operationID = mk_mp_taskReadEnergyIntervalParamsOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //读取功率变化存储阈值
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadPowerChangeValueOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //读取设备规格
        resultDic = @{
            @"specification":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadSpecificationsOfDeviceOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //读取过压保护信息
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *overThreshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *timeThreshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"overThreshold":overThreshold,
            @"timeThreshold":timeThreshold,
        };
        operationID = mk_mp_taskReadOverVoltageProtectionOperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //读取欠压保护信息
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *overThreshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        NSString *timeThreshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"overThreshold":overThreshold,
            @"timeThreshold":timeThreshold,
        };
        operationID = mk_mp_taskReadSagVoltageProtectionOperation;
    }else if ([cmd isEqualToString:@"49"]) {
        //读取过流保护信息
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *overThreshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        NSString *timeThreshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"overThreshold":overThreshold,
            @"timeThreshold":timeThreshold,
        };
        operationID = mk_mp_taskReadOverCurrentProtectionOperation;
    }else if ([cmd isEqualToString:@"4a"]) {
        //读取过载保护信息
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *overThreshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *timeThreshold = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"overThreshold":overThreshold,
            @"timeThreshold":timeThreshold,
        };
        operationID = mk_mp_taskReadOverLoadProtectionOperation;
    }else if ([cmd isEqualToString:@"4b"]) {
        //读取负载通知开关
        BOOL loadStart = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        BOOL loadStop = ([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"]);
        resultDic = @{
            @"loadStart":@(loadStart),
            @"loadStop":@(loadStop),
        };
        operationID = mk_mp_taskReadLoadStatusNotificationsOperation;
    }else if ([cmd isEqualToString:@"4c"]) {
        //读取P0
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadLoadStatusThresholdOperation;
    }else if ([cmd isEqualToString:@"4d"]) {
        //读取功率指示灯
        NSString *colorType = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSString *blue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        NSString *green = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 4)];
        NSString *yellow = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(10, 4)];
        NSString *orange = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(14, 4)];
        NSString *red = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(18, 4)];
        NSString *purple = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(22, 4)];
        resultDic = @{
            @"colorType":colorType,
            @"blue":blue,
            @"green":green,
            @"yellow":yellow,
            @"orange":orange,
            @"red":red,
            @"purple":purple,
        };
        operationID = mk_mp_taskReadPowerIndicatorColorOperation;
    }else if ([cmd isEqualToString:@"4e"]) {
        //读取时区
        resultDic = @{
            @"timeZone":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_mp_taskReadTimeZoneOperation;
    }else if ([cmd isEqualToString:@"4f"]) {
        //读取倒计时通知间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadCountDownReportIntervalOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //读取指示灯开关
        BOOL powerStatus = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        BOOL networkStatus = ([[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"]);
        resultDic = @{
            @"powerStatus":@(powerStatus),
            @"networkStatus":@(networkStatus),
        };
        operationID = mk_mp_taskReadLEDIndicatorStatusOperation;
    }else if ([cmd isEqualToString:@"61"]) {
        //读取开关状态
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_mp_taskReadSwitchStatusOperation;
    }else if ([cmd isEqualToString:@"62"]) {
        //读取LoRaWAN网络状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_mp_taskReadLorawanNetworkStatusOperation;
    }else if ([cmd isEqualToString:@"63"]) {
        //读取负载状态
        BOOL load = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"load":@(load)
        };
        operationID = mk_mp_taskReadLoadStatusOperation;
    }else if ([cmd isEqualToString:@"64"]) {
        //读取电量信息
        NSString *voltage = [NSString stringWithFormat:@"%.1f",([MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 4)] * 0.1)];
        NSString *current = [NSString stringWithFormat:@"%.3f",([MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(4, 4)] * 0.001)];
        NSString *power = [NSString stringWithFormat:@"%.1f",([MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(8, 8)] * 0.1)];
        NSString *frequencyOfCurrent = [NSString stringWithFormat:@"%.3f",([MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(16, 4)] * 0.001)];
        NSString *powerFactor = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(20, 2)];
        
        resultDic = @{
            @"voltage":voltage,
            @"current":current,
            @"power":power,
            @"frequencyOfCurrent":frequencyOfCurrent,
            @"powerFactor":powerFactor,
        };
        operationID = mk_mp_taskReadElectricityDataOperation;
    }else if ([cmd isEqualToString:@"65"]) {
        //读取电能信息
        NSString *totalRounds = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 8)];
        NSString *lastHourRounds = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 4)];
        NSString *EC = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(12, 4)];
        resultDic = @{
            @"totalRounds":totalRounds,
            @"lastHourRounds":lastHourRounds,
            @"EC":EC,
        };
        operationID = mk_mp_taskReadEnergyDataOperation;
    }else if ([cmd isEqualToString:@"68"]) {
        //读取MAC地址
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
        operationID = mk_mp_taskReadMacAddressOperation;
    }
    
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_mp_taskOperationID operationID = mk_mp_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    
    if ([cmd isEqualToString:@"01"]) {
        //配置LoRaWAN入网类型
        operationID = mk_mp_taskConfigModemOperation;
    }else if ([cmd isEqualToString:@"02"]) {
        //配置LoRaWAN DEVEUI
        operationID = mk_mp_taskConfigDEVEUIOperation;
    }else if ([cmd isEqualToString:@"03"]) {
        //配置LoRaWAN APPEUI
        operationID = mk_mp_taskConfigAPPEUIOperation;
    }else if ([cmd isEqualToString:@"04"]) {
        //配置LoRaWAN APPKEY
        operationID = mk_mp_taskConfigAPPKEYOperation;
    }else if ([cmd isEqualToString:@"05"]) {
        //配置LoRaWAN DEVADDR
        operationID = mk_mp_taskConfigDEVADDROperation;
    }else if ([cmd isEqualToString:@"06"]) {
        //配置LoRaWAN APPSKEY
        operationID = mk_mp_taskConfigAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"07"]) {
        //配置LoRaWAN nwkSkey
        operationID = mk_mp_taskConfigNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"08"]) {
        //配置LoRaWAN频段
        operationID = mk_mp_taskConfigRegionOperation;
    }else if ([cmd isEqualToString:@"09"]) {
        //配置LoRaWAN工作模式
        operationID = mk_mp_taskConfigClassTypeOperation;
    }else if ([cmd isEqualToString:@"0a"]) {
        //配置LoRaWAN 上行数据类型
        operationID = mk_mp_taskConfigMessageTypeOperation;
    }else if ([cmd isEqualToString:@"0b"]) {
        //配置LoRaWAN CH
        operationID = mk_mp_taskConfigCHValueOperation;
    }else if ([cmd isEqualToString:@"0c"]) {
        //配置LoRaWAN duty cycle
        operationID = mk_mp_taskConfigDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"0d"]) {
        //配置LoRaWAN DR
        operationID = mk_mp_taskConfigDRValueOperation;
    }else if ([cmd isEqualToString:@"0e"]) {
        //配置LoRaWAN 数据发送策略
        operationID = mk_mp_taskConfigUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"0f"]) {
        //配置LoRaWAN 重传次数
        operationID = mk_mp_taskConfigMaxRetransmissionTimesOperation;
    }else if ([cmd isEqualToString:@"10"]) {
        //配置LoRaWAN devtime指令同步间隔
        operationID = mk_mp_taskConfigTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"11"]) {
        //配置LoRaWAN LinkCheckReq指令间隔
        operationID = mk_mp_taskConfigNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"21"]) {
        //配置广播名称
        operationID = mk_mp_taskConfigDeviceNameOperation;
    }else if ([cmd isEqualToString:@"22"]) {
        //配置广播间隔
        operationID = mk_mp_taskConfigAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"23"]) {
        //配置发射功率
        operationID = mk_mp_taskConfigTxPowerOperation;
    }else if ([cmd isEqualToString:@"24"]) {
        //配置可连接状态
        operationID = mk_mp_taskConfigConnectableStatusOperation;
    }else if ([cmd isEqualToString:@"25"]) {
        //配置密码开关
        operationID = mk_mp_taskConfigNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"26"]) {
        //配置密码
        operationID = mk_mp_taskConfigPasswordOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //配置默认开关上电状态
        operationID = mk_mp_taskConfigRepoweredDefaultModeOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //配置开关状态上报间隔
        operationID = mk_mp_taskConfigReportIntervalOfSwitchPayloadsOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //配置电量上报间隔
        operationID = mk_mp_taskConfigReportIntervalOfElectricityOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //配置电能存储与上报间隔
        operationID = mk_mp_taskConfigEnergyIntervalParamsOperation;
    }else if ([cmd isEqualToString:@"45"]) {
        //配置功率变化存储阈值
        operationID = mk_mp_taskConfigPowerChangeValueOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //配置过压保护信息
        operationID = mk_mp_taskConfigOverVoltageOperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //配置欠压保护信息
        operationID = mk_mp_taskConfigSagVoltageOperation;
    }else if ([cmd isEqualToString:@"49"]) {
        //配置过流保护信息
        operationID = mk_mp_taskConfigOverCurrentOperation;
    }else if ([cmd isEqualToString:@"4a"]) {
        //配置过载保护信息
        operationID = mk_mp_taskConfigOverLoadOperation;
    }else if ([cmd isEqualToString:@"4b"]) {
        //配置负载通知开关
        operationID = mk_mp_taskConfigLoadStatusNotificationsOperation;
    }else if ([cmd isEqualToString:@"4c"]) {
        //配置P0
        operationID = mk_mp_taskConfigLoadStatusThresholdOperation;
    }else if ([cmd isEqualToString:@"4d"]) {
        //配置功率指示灯
        operationID = mk_mp_taskConfigPowerIndicatorColorOperation;
    }else if ([cmd isEqualToString:@"4e"]) {
        //配置时区
        operationID = mk_mp_taskConfigTimeZoneOperation;
    }else if ([cmd isEqualToString:@"4f"]) {
        //配置倒计时通知间隔
        operationID = mk_mp_taskConfigCountDownReportIntervalOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //配置网络和电源指示灯状态
        operationID = mk_mp_taskConfigLEDIndicatorOperation;
    }else if ([cmd isEqualToString:@"61"]) {
        //配置开关状态
        operationID = mk_mp_taskConfigSwitchStatusOperation;
    }else if ([cmd isEqualToString:@"66"]) {
        //配置LoRaWAN 入网
        operationID = mk_mp_taskRestartDeviceOperation;
    }
    
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}



#pragma mark -

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_mp_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

+ (NSString *)fetchTxPowerValueString:(NSString *)content {
    if ([content isEqualToString:@"08"]) {
        return @"8dBm";
    }
    if ([content isEqualToString:@"07"]) {
        return @"7dBm";
    }
    if ([content isEqualToString:@"06"]) {
        return @"6dBm";
    }
    if ([content isEqualToString:@"05"]) {
        return @"5dBm";
    }
    if ([content isEqualToString:@"04"]) {
        return @"4dBm";
    }
    if ([content isEqualToString:@"03"]) {
        return @"3dBm";
    }
    if ([content isEqualToString:@"02"]) {
        return @"2dBm";
    }
    if ([content isEqualToString:@"00"]) {
        return @"0dBm";
    }
    if ([content isEqualToString:@"fc"]) {
        return @"-4dBm";
    }
    if ([content isEqualToString:@"f8"]) {
        return @"-8dBm";
    }
    if ([content isEqualToString:@"f4"]) {
        return @"-12dBm";
    }
    if ([content isEqualToString:@"f0"]) {
        return @"-16dBm";
    }
    if ([content isEqualToString:@"ec"]) {
        return @"-20dBm";
    }
    if ([content isEqualToString:@"d8"]) {
        return @"-40dBm";
    }
    return @"0dBm";
}

@end
