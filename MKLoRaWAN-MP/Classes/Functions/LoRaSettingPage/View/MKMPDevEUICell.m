//
//  MKMPDevEUICell.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2025/3/5.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKMPDevEUICell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"
#import "UIView+MKAdd.h"

@implementation MKMPDevEUICellModel
@end

@interface MKMPDevEUICell ()

@property (nonatomic, strong)UILabel *msgLabel;

@end

@implementation MKMPDevEUICell

+ (MKMPDevEUICell *)initCellWithTableView:(UITableView *)tableView {
    MKMPDevEUICell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKMPDevEUICellIdenty"];
    if (!cell) {
        cell = [[MKMPDevEUICell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKMPDevEUICellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKMPDevEUICellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKMPDevEUICellModel.class]) {
        return;
    }
    self.msgLabel.text = [@"DevEUI:" stringByAppendingString:SafeStr(_dataModel.devEUI)];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

@end
