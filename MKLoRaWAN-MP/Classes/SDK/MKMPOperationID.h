
typedef NS_ENUM(NSInteger, mk_mp_taskOperationID) {
    mk_mp_defaultTaskOperationID,
    
#pragma mark - Read
    mk_mp_taskReadDeviceModelOperation,        //读取产品型号
    mk_mp_taskReadFirmwareOperation,           //读取固件版本
    mk_mp_taskReadHardwareOperation,           //读取硬件类型
    mk_mp_taskReadSoftwareOperation,           //读取软件版本
    mk_mp_taskReadManufacturerOperation,       //读取厂商信息
    mk_mp_taskReadDeviceTypeOperation,         //读取产品类型
    
#pragma mark - 密码特征
    mk_mp_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 设备LoRa参数读取
    mk_mp_taskReadLorawanModemOperation,        //读取LoRaWAN入网类型
    mk_mp_taskReadLorawanDEVEUIOperation,           //读取LoRaWAN DEVEUI
    mk_mp_taskReadLorawanAPPEUIOperation,           //读取LoRaWAN APPEUI
    mk_mp_taskReadLorawanAPPKEYOperation,           //读取LoRaWAN APPKEY
    mk_mp_taskReadLorawanDEVADDROperation,          //读取LoRaWAN DEVADDR
    mk_mp_taskReadLorawanAPPSKEYOperation,          //读取LoRaWAN APPSKEY
    mk_mp_taskReadLorawanNWKSKEYOperation,          //读取LoRaWAN NWKSKEY
    mk_mp_taskReadLorawanRegionOperation,           //读取LoRaWAN频段
    mk_mp_taskReadLorawanClassTypeOperation,       //读取LoRaWAN工作模式
    mk_mp_taskReadLorawanMessageTypeOperation,      //读取上行数据类型
    mk_mp_taskReadLorawanCHOperation,               //读取LoRaWAN CH
    mk_mp_taskReadLorawanDutyCycleStatusOperation,  //读取dutycyle
    mk_mp_taskReadLorawanDROperation,               //读取LoRaWAN DR
    mk_mp_taskReadLorawanUplinkStrategyOperation,   //读取LoRaWAN数据发送策略
    mk_mp_taskReadLorawanMaxRetransmissionTimesOperation,   //读取LoRaWAN重传次数
    mk_mp_taskReadLorawanDevTimeSyncIntervalOperation,  //读取同步时间同步间隔
    mk_mp_taskReadLorawanNetworkCheckIntervalOperation, //读取网络确认间隔
    
#pragma mark - 蓝牙参数读取
    mk_mp_taskReadDeviceNameOperation,                  //读取设备广播名称
    mk_mp_taskReadAdvIntervalOperation,                 //读取广播间隔
    mk_mp_taskReadTxPowerOperation,                     //读取发射功率
    mk_mp_taskReadDeviceConnectableOperation,           //读取可连接状态
    mk_mp_taskReadConnectationNeedPasswordOperation,    //读取密码开关
    mk_mp_taskReadPasswordOperation,                    //读取设备连接密码
    
#pragma mark - 功能参数读取
    mk_mp_taskReadRepoweredDefaultModeOperation,        //读取设备开关默认上电状态
    mk_mp_taskReadReportIntervalOfSwitchPayloadsOperation,  //读取开关状态上报间隔
    mk_mp_taskReadReportIntervalOfElectricityOperation,     //读取电量上报间隔
    mk_mp_taskReadEnergyIntervalParamsOperation,            //读取电能存储与上报间隔
    mk_mp_taskReadPowerChangeValueOperation,                //读取功率变化存储阈值
    mk_mp_taskReadSpecificationsOfDeviceOperation,          //读取设备规格
    mk_mp_taskReadOverVoltageProtectionOperation,           //读取过压保护信息
    mk_mp_taskReadSagVoltageProtectionOperation,            //读取欠压保护信息
    mk_mp_taskReadOverCurrentProtectionOperation,           //读取过流保护信息
    mk_mp_taskReadOverLoadProtectionOperation,              //读取过载保护信息
    mk_mp_taskReadLoadStatusNotificationsOperation,         //读取负载通知开关
    mk_mp_taskReadLoadStatusThresholdOperation,             //读取P0状态
    mk_mp_taskReadPowerIndicatorColorOperation,             //读取功率指示灯
    mk_mp_taskReadTimeZoneOperation,                        //读取设备时区
    mk_mp_taskReadCountDownReportIntervalOperation,         //读取倒计时通知间隔
    mk_mp_taskReadLEDIndicatorStatusOperation,              //读取网络和电源指示灯开关状态
    
#pragma mark - 设备控制参数读取
    mk_mp_taskReadSwitchStatusOperation,            //读取设备开关状态
    mk_mp_taskReadLorawanNetworkStatusOperation,    //读取LoRaWAN网络状态
    mk_mp_taskReadLoadStatusOperation,              //读取负载状态
    mk_mp_taskReadElectricityDataOperation,         //读取电量信息
    mk_mp_taskReadEnergyDataOperation,              //读取电能信息
    mk_mp_taskReadMacAddressOperation,              //读取mac地址
    
#pragma mark - 设备LoRa参数配置
    mk_mp_taskConfigModemOperation,                     //配置LoRaWAN的入网类型
    mk_mp_taskConfigDEVEUIOperation,                    //配置LoRaWAN的devEUI
    mk_mp_taskConfigAPPEUIOperation,                    //配置LoRaWAN的appEUI
    mk_mp_taskConfigAPPKEYOperation,                    //配置LoRaWAN的appKey
    mk_mp_taskConfigDEVADDROperation,                   //配置LoRaWAN的DevAddr
    mk_mp_taskConfigAPPSKEYOperation,                   //配置LoRaWAN的APPSKEY
    mk_mp_taskConfigNWKSKEYOperation,                   //配置LoRaWAN的NwkSKey
    mk_mp_taskConfigRegionOperation,                    //配置LoRaWAN的region
    mk_mp_taskConfigClassTypeOperation,                 //配置LoRaWAN的Class type
    mk_mp_taskConfigMessageTypeOperation,               //配置LoRaWAN的message type
    mk_mp_taskConfigCHValueOperation,                   //配置LoRaWAN的CH值
    mk_mp_taskConfigDutyCycleStatusOperation,           //配置LoRaWAN的duty cycle
    mk_mp_taskConfigDRValueOperation,                   //配置LoRaWAN的DR值
    mk_mp_taskConfigUplinkStrategyOperation,            //配置LoRaWAN数据发送策略
    mk_mp_taskConfigMaxRetransmissionTimesOperation,    //配置LoRaWAN的重传次数
    mk_mp_taskConfigTimeSyncIntervalOperation,          //配置LoRaWAN的同步指令间隔
    mk_mp_taskConfigNetworkCheckIntervalOperation,      //配置LoRaWAN的LinkCheckReq间隔
    
#pragma mark - 蓝牙参数
    mk_mp_taskConfigDeviceNameOperation,                //配置设备广播名称
    mk_mp_taskConfigAdvIntervalOperation,               //配置广播间隔
    mk_mp_taskConfigTxPowerOperation,                   //配置txPower
    mk_mp_taskConfigConnectableStatusOperation,         //配置可连接状态
    mk_mp_taskConfigNeedPasswordOperation,              //配置密码开关
    mk_mp_taskConfigPasswordOperation,                  //配置密码
    
#pragma mark - 功能参数
    mk_mp_taskConfigRepoweredDefaultModeOperation,      //配置设备开关默认上电状态
    mk_mp_taskConfigReportIntervalOfSwitchPayloadsOperation,  //配置开关状态上报间隔
    mk_mp_taskConfigReportIntervalOfElectricityOperation,       //配置电量上报间隔
    mk_mp_taskConfigEnergyIntervalParamsOperation,              //配置电能存储与上报间隔
    mk_mp_taskConfigPowerChangeValueOperation,                  //配置功率变化存储阈值
    mk_mp_taskConfigOverVoltageOperation,                       //配置过压保护信息
    mk_mp_taskConfigSagVoltageOperation,                        //配置欠压保护信息
    mk_mp_taskConfigOverCurrentOperation,                       //配置过流保护信息
    mk_mp_taskConfigOverLoadOperation,                          //配置过载保护信息
    mk_mp_taskConfigLoadStatusNotificationsOperation,           //配置负载通知开关
    mk_mp_taskConfigLoadStatusThresholdOperation,               //配置P0
    mk_mp_taskConfigPowerIndicatorColorOperation,               //配置功率指示灯
    mk_mp_taskConfigTimeZoneOperation,                          //配置时区
    mk_mp_taskConfigCountDownReportIntervalOperation,           //配置倒计时通知间隔
    mk_mp_taskConfigLEDIndicatorOperation,                      //配置网络和电源指示灯状态
        
#pragma mark - 设备控制参数配置
    mk_mp_taskConfigSwitchStatusOperation,              //配置设备开关状态
    mk_mp_taskRestartDeviceOperation,                   //配置设备重新入网
    mk_mp_taskFactoryResetOperation,                    //设备恢复出厂设置
};
