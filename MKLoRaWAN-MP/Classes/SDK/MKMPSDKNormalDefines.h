
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
    mk_mp_repoweredDefaultMode_offMode,             //Off mode
    mk_mp_repoweredDefaultMode_onMode,              //On mode
    mk_mp_repoweredDefaultMode_revertToLastMode,    //Revert To Last Mode
};

typedef NS_ENUM(NSInteger, mk_mp_txPower) {
    mk_mp_txPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_mp_txPowerNeg20dBm,   //-20dBm
    mk_mp_txPowerNeg16dBm,   //-16dBm
    mk_mp_txPowerNeg12dBm,   //-12dBm
    mk_mp_txPowerNeg8dBm,    //-8dBm
    mk_mp_txPowerNeg4dBm,    //-4dBm
    mk_mp_txPower0dBm,       //0dBm
    mk_mp_txPower3dBm,       //3dBm
    mk_mp_txPower4dBm,       //4dBm
};

typedef NS_ENUM(NSInteger, mk_mp_productModel) {
    mk_mp_productModel_FE,                        //Europe and France
    mk_mp_productModel_America,                  //America
    mk_mp_productModel_UK,                      //UK
};

typedef NS_ENUM(NSInteger, mk_mp_ledColorType) {
    mk_mp_ledColorTransitionDirectly,
    mk_mp_ledColorTransitionSmoothly,
    mk_mp_ledColorWhite,
    mk_mp_ledColorRed,
    mk_mp_ledColorGreen,
    mk_mp_ledColorBlue,
    mk_mp_ledColorOrange,
    mk_mp_ledColorCyan,
    mk_mp_ledColorPurple,
};

#pragma mark ****************************************Protocol************************************************

@protocol mk_mp_ledColorConfigProtocol <NSObject>

/*
 Blue.
 European and French specifications:1 <=  b_color <= 4411.
 American specifications:1 <=  b_color <= 2155.
 British specifications:1 <=  b_color <= 3584.
 */
@property (nonatomic, assign)NSInteger b_color;

/*
 Green.
 European and French specifications:b_color < g_color <= 4412.
 American specifications:b_color < g_color <= 2156.
 British specifications:b_color < g_color <= 3584.
 */
@property (nonatomic, assign)NSInteger g_color;

/*
 Yellow.
 European and French specifications:g_color < y_color <= 4413.
 American specifications:g_color < y_color <= 2157.
 British specifications:g_color < y_color <= 3585.
 */
@property (nonatomic, assign)NSInteger y_color;

/*
 Orange.
 European and French specifications:y_color < o_color <= 4414.
 American specifications:y_color < o_color <= 2158.
 British specifications:y_color < o_color <= 3586.
 */
@property (nonatomic, assign)NSInteger o_color;

/*
 Red.
 European and French specifications:o_color < r_color <= 4415.
 American specifications:o_color < r_color <= 2159.
 British specifications:o_color < r_color <= 3587.
 */
@property (nonatomic, assign)NSInteger r_color;

/*
 Purple.
 European and French specifications:r_color < p_color <=  4416.
 American specifications:r_color < p_color <=  2160.
 British specifications:r_color < p_color <=  3588.
 */
@property (nonatomic, assign)NSInteger p_color;

@end

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
