//
//  MKMPScanPageCell.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKMPScanPageCellDelegate <NSObject>

/// 连接按钮点击事件
/// @param index 当前cell的row
- (void)mp_scanCellConnectButtonPressed:(NSInteger)index;

@end

@class MKMPScanPageModel;
@interface MKMPScanPageCell : MKBaseCell

@property (nonatomic, strong)MKMPScanPageModel *dataModel;

@property (nonatomic, weak)id <MKMPScanPageCellDelegate>delegate;

+ (MKMPScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
