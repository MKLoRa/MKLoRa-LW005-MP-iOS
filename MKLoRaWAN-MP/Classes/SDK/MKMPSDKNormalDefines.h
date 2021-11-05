
#pragma mark ****************************************Enumerate************************************************

#pragma mark - MKMPCentralManager

typedef NS_ENUM(NSInteger, mk_mp_centralConnectStatus) {
    mk_mp_centralConnectStatusUnknow,                                           //未知状态
    mk_mp_centralConnectStatusConnecting,                                       //正在连接
    mk_mp_centralConnectStatusConnected,                                        //连接成功
    mk_mp_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_mp_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_mp_centralManagerStatus) {
    mk_mp_centralManagerStatusUnable,                           //不可用
    mk_mp_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_mp_loraWanRegion) {
    mk_mp_loraWanRegionAS923,
    mk_mp_loraWanRegionAU915,
    mk_mp_loraWanRegionCN470,
    mk_mp_loraWanRegionCN779,
    mk_mp_loraWanRegionEU433,
    mk_mp_loraWanRegionEU868,
    mk_mp_loraWanRegionKR920,
    mk_mp_loraWanRegionIN865,
    mk_mp_loraWanRegionUS915,
    mk_mp_loraWanRegionRU864,
};

typedef NS_ENUM(NSInteger, mk_mp_loraWanModem) {
    mk_mp_loraWanModemABP,
    mk_mp_loraWanModemOTAA,
};

typedef NS_ENUM(NSInteger, mk_mp_loraWanMessageType) {
    mk_mp_loraWanUnconfirmMessage,          //Non-acknowledgement frame.
    mk_mp_loraWanConfirmMessage,            //Confirm the frame.
};

typedef NS_ENUM(NSInteger, mk_mp_loraWanClassType) {
    mk_mp_loraWanClassTypeA,
    mk_mp_loraWanClassTypeC,
};

typedef NS_ENUM(NSInteger, mk_mp_repoweredDefaultMode) {
    mk_mp_repoweredDefaultMode_onMode,              //On mode
    mk_mp_repoweredDefaultMode_offMode,             //Off mode
    mk_mp_repoweredDefaultMode_revertToLastMode,    //Revert To Last Mode
};

typedef NS_ENUM(NSInteger, mk_mp_productModel) {
    mk_mp_productModel_FE,                        //Europe and France
    mk_mp_productModel_America,                  //America
    mk_mp_productModel_UK,                      //UK
};

#pragma mark ****************************************Delegate************************************************

@protocol mk_mp_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
- (void)mk_mp_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_mp_startScan;

/// Stops scanning equipment.
- (void)mk_mp_stopScan;

@end
