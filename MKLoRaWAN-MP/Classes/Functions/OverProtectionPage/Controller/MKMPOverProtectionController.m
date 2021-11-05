//
//  MKMPOverProtectionController.m
//  MKLoRaWAN-MP_Example
//
//  Created by aa on 2021/10/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKMPOverProtectionController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKTableSectionLineHeader.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"
#import "MKTextFieldCell.h"

#import "MKMPOverProtectionModel.h"

@interface MKMPOverProtectionController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate,
MKTextFieldCellDelegate>

@property (nonatomic, assign)mp_overProtectionType pageType;

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKMPOverProtectionModel *dataModel;

@end

@implementation MKMPOverProtectionController

- (void)dealloc {
    NSLog(@"MKMPOverProtectionController销毁");
}

- (instancetype)initWithPageType:(mp_overProtectionType)type {
    if (self = [self init]) {
        self.pageType = type;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Protection
        self.dataModel.isOn = isOn;
        MKTextSwitchCellModel *cellModel = self.section0List[0];
        cellModel.isOn = isOn;
        return;
    }
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //Over Threshold
        self.dataModel.overThreshold = value;
        MKTextFieldCellModel *cellModel = self.section1List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 1) {
        //Time Threshold
        self.dataModel.timeThreshold = value;
        MKTextFieldCellModel *cellModel = self.section2List[0];
        cellModel.textFieldValue = value;
        return;
    }
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)saveDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    for (NSInteger i = 0; i < 3; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    if (self.pageType == mp_overProtectionType_load) {
        [self loadOverLoadDatas];
    }else if (self.pageType == mp_overProtectionType_voltage) {
        [self loadOverVoltageDatas];
    }else if (self.pageType == mp_overProtectionType_sagVoltage) {
        [self loadSagVoltageDatas];
    }else {
        [self loadOverCurrentDatas];
    }
    [self.tableView reloadData];
}

- (void)loadOverLoadDatas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Over-Load Protection";
    cellModel1.isOn = self.dataModel.isOn;
    [self.section0List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 0;
    cellModel2.msg = @"Over-Load Threshold";
    cellModel2.maxLength = 4;
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.unit = @"W";
    cellModel2.textFieldValue = self.dataModel.overThreshold;
    [self.section1List addObject:cellModel2];
    
    MKTextFieldCellModel *cellModel3 = [[MKTextFieldCellModel alloc] init];
    cellModel3.index = 1;
    cellModel3.msg = @"Time Threshold";
    cellModel3.maxLength = 2;
    cellModel3.textPlaceholder = @"1 - 30";
    cellModel3.textFieldType = mk_realNumberOnly;
    cellModel3.unit = @"S";
    cellModel3.textFieldValue = self.dataModel.timeThreshold;
    [self.section2List addObject:cellModel3];
}

- (void)loadOverVoltageDatas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Over-Voltage Protection";
    cellModel1.isOn = self.dataModel.isOn;
    [self.section0List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 0;
    cellModel2.msg = @"Over-Voltage Threshold";
    cellModel2.maxLength = 3;
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.unit = @"V";
    cellModel2.textFieldValue = self.dataModel.overThreshold;
    [self.section1List addObject:cellModel2];
    
    MKTextFieldCellModel *cellModel3 = [[MKTextFieldCellModel alloc] init];
    cellModel3.index = 1;
    cellModel3.msg = @"Time Threshold";
    cellModel3.maxLength = 2;
    cellModel3.textPlaceholder = @"1 - 30";
    cellModel3.textFieldType = mk_realNumberOnly;
    cellModel3.unit = @"S";
    cellModel3.textFieldValue = self.dataModel.timeThreshold;
    [self.section2List addObject:cellModel3];
}

- (void)loadSagVoltageDatas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Sag-Voltage Protection";
    cellModel1.isOn = self.dataModel.isOn;
    [self.section0List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 0;
    cellModel2.msg = @"Sag-Voltage Threshold";
    cellModel2.maxLength = 3;
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.unit = @"V";
    cellModel2.textFieldValue = self.dataModel.overThreshold;
    [self.section1List addObject:cellModel2];
    
    MKTextFieldCellModel *cellModel3 = [[MKTextFieldCellModel alloc] init];
    cellModel3.index = 1;
    cellModel3.msg = @"Time Threshold";
    cellModel3.maxLength = 2;
    cellModel3.textPlaceholder = @"1 - 30";
    cellModel3.textFieldType = mk_realNumberOnly;
    cellModel3.unit = @"S";
    cellModel3.textFieldValue = self.dataModel.timeThreshold;
    [self.section2List addObject:cellModel3];
}

- (void)loadOverCurrentDatas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Over-Current Protection";
    cellModel1.isOn = self.dataModel.isOn;
    [self.section0List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 0;
    cellModel2.msg = @"Over-Current Threshold";
    cellModel2.maxLength = 3;
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.unit = @" x0.1 A";
    cellModel2.textFieldValue = self.dataModel.overThreshold;
    [self.section1List addObject:cellModel2];
    
    MKTextFieldCellModel *cellModel3 = [[MKTextFieldCellModel alloc] init];
    cellModel3.index = 1;
    cellModel3.msg = @"Time Threshold";
    cellModel3.maxLength = 2;
    cellModel3.textPlaceholder = @"1 - 30";
    cellModel3.textFieldType = mk_realNumberOnly;
    cellModel3.unit = @"S";
    cellModel3.textFieldValue = self.dataModel.timeThreshold;
    [self.section2List addObject:cellModel3];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = [self currentTitle];
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-MP", @"MKMPOverProtectionController", @"mp_slotSaveIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
    }];
}

- (NSString *)currentTitle {
    switch (self.pageType) {
        case mp_overProtectionType_load:
            return @"Over-Load Protection";
        case mp_overProtectionType_voltage:
            return @"Over-Voltage Protection";
        case mp_overProtectionType_sagVoltage:
            return @"Sag-Voltage Protection";
        case mp_overProtectionType_current:
            return @"Over-Current Protection";
    }
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKMPOverProtectionModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKMPOverProtectionModel alloc] initWithType:self.pageType];
    }
    return _dataModel;
}

@end
