//
//  MKMPIndicatorColorCell.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKMPIndicatorColorCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *placeholder;

@property (nonatomic, copy)NSString *textValue;

@property (nonatomic, assign)NSInteger index;

@end

@protocol MKMPIndicatorColorCellDelegate <NSObject>

- (void)mp_ledColorChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKMPIndicatorColorCell : MKBaseCell

@property (nonatomic, strong)MKMPIndicatorColorCellModel *dataModel;

@property (nonatomic, weak)id <MKMPIndicatorColorCellDelegate>delegate;

+ (MKMPIndicatorColorCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
