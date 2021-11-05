//
//  MKMPLoadStatusCell.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMPLoadStatusCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)UIImage *icon;

@end

@interface MKMPLoadStatusCell : MKBaseCell

@property (nonatomic, strong)MKMPLoadStatusCellModel *dataModel;

+ (MKMPLoadStatusCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
