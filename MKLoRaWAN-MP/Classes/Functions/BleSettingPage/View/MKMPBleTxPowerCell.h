//
//  MKMPBleTxPowerCell.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_mp_deviceTxPower) {
    mk_mp_deviceTxPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_mp_deviceTxPowerNeg20dBm,   //-20dBm
    mk_mp_deviceTxPowerNeg16dBm,   //-16dBm
    mk_mp_deviceTxPowerNeg12dBm,   //-12dBm
    mk_mp_deviceTxPowerNeg8dBm,    //-8dBm
    mk_mp_deviceTxPowerNeg4dBm,    //-4dBm
    mk_mp_deviceTxPower0dBm,       //0dBm
    mk_mp_deviceTxPower3dBm,       //3dBm
    mk_mp_deviceTxPower4dBm,       //4dBm
};

@interface MKMPBleTxPowerCellModel : NSObject

@property (nonatomic, assign)mk_mp_deviceTxPower txPower;

@end

@protocol MKMPBleTxPowerCellDelegate <NSObject>

- (void)mk_mp_txPowerValueChanged:(mk_mp_deviceTxPower)txPower;

@end

@interface MKMPBleTxPowerCell : MKBaseCell

@property (nonatomic, strong)MKMPBleTxPowerCellModel *dataModel;

@property (nonatomic, weak)id <MKMPBleTxPowerCellDelegate>delegate;

+ (MKMPBleTxPowerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
