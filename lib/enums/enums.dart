// ignore_for_file: constant_identifier_names

enum Layout { grid, list }

enum RewardTypes { regular, tiered }

enum PointsExpire { never, everyMonth, everyWeek, yearly }

enum RedeemDay {
  everySunday,
  everyMonday,
  everyTuesday,
  everyWednesday,
  everyThursday,
  everyFriday,
  everySaturday,
  everyday,
}

enum WeekDays { sunday, monday, tuesday, wednesday, thursday, friday, saturday }

enum PerksRewardTypes { flatDiscount, percentageDiscount, freeItems }

enum StageLevel { business, location, register }

enum PostedStatus
{
    all,
    draft,
    posted,
    hold,
}

enum TransactionType
{
    all,
    sale,
    refund
}

enum DataItem
{
  appLanguageResource,
  mainMenuPageConfiguration,
  functionButtons,
  discounts,
  products,
  customers,
  invoices,
  stocks,
  departments,
  unit,
  unitClass,
  business,
  location,
  register,
  rolesRights,
  electronicTender,
  userUpdate,
  userFingerPrint,
  userPin,
  userQRCode,
  userCard,
  userOverrideCode,
  screenSetting,
  configuration,
  tenderConfig
}

enum SignInType
{
    password,
    userCard,
    qrCode,
    pin,
    fingerPrint
}

enum ButtonActionType
{
    product,
    department,
    category,
}

enum UserPageActions
{
    UserPin,
    UserCard,
    EnrollFinger,
    ChangePassword
}
