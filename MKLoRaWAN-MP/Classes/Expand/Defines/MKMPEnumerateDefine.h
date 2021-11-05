

typedef NS_ENUM(NSInteger, mp_overProtectionType) {
    mp_overProtectionType_load,              //过载
    mp_overProtectionType_voltage,           //过压
    mp_overProtectionType_sagVoltage,        //欠压
    mp_overProtectionType_current,           //过流
};

typedef NS_ENUM(NSInteger, mp_productModel) {
    mp_productModel_fe,                 //欧法规
    mp_productModel_b,                  //美规
    mp_productModel_g,                 //英规
};

typedef NS_ENUM(NSInteger, mp_ledColorType) {
    mp_ledColorTransitionDirectly,
    mp_ledColorTransitionSmoothly,
    mp_ledColorWhite,
    mp_ledColorRed,
    mp_ledColorGreen,
    mp_ledColorBlue,
    mp_ledColorOrange,
    mp_ledColorCyan,
    mp_ledColorPurple,
};
