//
//  MKMPLoRaSettingAccountCell.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2025/3/3.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMPLoRaSettingAccountCellModel : NSObject

@property (nonatomic, copy)NSString *account;

@end

@protocol MKMPLoRaSettingAccountCellDelegate <NSObject>

- (void)mp_loRaSettingAccountCell_logoutBtnPressed;

@end

@interface MKMPLoRaSettingAccountCell : MKBaseCell

@property (nonatomic, strong)MKMPLoRaSettingAccountCellModel *dataModel;

@property (nonatomic, weak)id <MKMPLoRaSettingAccountCellDelegate>delegate;

+ (MKMPLoRaSettingAccountCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
