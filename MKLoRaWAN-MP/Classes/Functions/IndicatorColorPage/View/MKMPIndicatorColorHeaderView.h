//
//  MKMPIndicatorColorHeaderView.h
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKMPIndicatorColorHeaderViewDelegate <NSObject>

/// 用户选择了color
/// @param colorType 对应的结果如下:
/*
 mp_ledColorTransitionDirectly,
 mp_ledColorTransitionSmoothly,
 mp_ledColorWhite,
 mp_ledColorRed,
 mp_ledColorGreen,
 mp_ledColorBlue,
 mp_ledColorOrange,
 mp_ledColorCyan,
 mp_ledColorPurple,
 */
- (void)mp_colorSettingPickViewTypeChanged:(NSInteger)colorType;

@end

@interface MKMPIndicatorColorHeaderView : UIView

@property (nonatomic, weak)id <MKMPIndicatorColorHeaderViewDelegate>delegate;

/// 更新当前选中的color
/// @param colorType 对应的结果如下:
/*
 mp_ledColorTransitionDirectly,
 mp_ledColorTransitionSmoothly,
 mp_ledColorWhite,
 mp_ledColorRed,
 mp_ledColorGreen,
 mp_ledColorBlue,
 mp_ledColorOrange,
 mp_ledColorCyan,
 mp_ledColorPurple,
 */
- (void)updateColorType:(NSInteger)colorType;

@end

NS_ASSUME_NONNULL_END
