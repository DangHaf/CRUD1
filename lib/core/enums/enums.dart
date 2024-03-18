/// =================== Base Enum ===================//

enum TypeOfDevice {
  bigDevice,
  smallDevice,
  normalDevice,
  mediumSmallDevice,
}

enum IZIButtonType {
  DEFAULT,
  OUTLINE,
}

enum IZIImageType {
  SVG,
  IMAGE,
  NOT_IMAGE,
}

enum IZIImageUrlType {
  NETWORK,
  ASSET,
  FILE,
  ICON,
  IMAGE_CIRCLE,
}

enum IZIInputType {
  TEXT,
  PASSWORD,
  NUMBER,
  DOUBLE,
  PRICE,
  EMAIL,
  PHONE,
  INCREMENT,
  MULTILINE,
  DATE,
}

enum IZIPickerDate {
  MATERIAL,
  CUPERTINO,
}

enum TypeOfAlert {
  ERROR,
  SUCCESS,
  INFO,
  WARRING,
}

enum AppTypeEnum {
  A3_AI_CHAT,
  A1_VPS,
  A2_ASK_AI,
}

enum UnitTypeDiscountEnum {
  MONEY,
  PERCENT,
}

enum TypeVoucherEnum {
  ALL,
  GROUP,
}

enum EvaluationType {
  ALL,
  HAVE_CONTENT,
  NEAREST,
  TALLEST,
  SHORTEST,
}

enum TypeBottomProduct { CART, BUY_NOW }

enum OrderTap {
  WAIT_FOR_CONFIRMATION,
  CONFIRMED,
  PACKING,
  DELIVERING,
  DELIVERED,
  RECEIVED, 
  CANCELED,
  RETURN,
}
