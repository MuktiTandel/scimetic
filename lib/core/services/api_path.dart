class ApiPath {

  static const baseUrl = "https://api-staging.scimetic.net";
  // static const baseUrl = "https://9414-2405-201-2014-30fe-6967-4afc-1da3-f1c9.in.ngrok.io";

  static const login = "/auth/login";
  static const register = "/auth/register";
  static const verificationCode = "/auth/send_verification_code";
  static const verifyAccount = "/auth/verify_account";
  static const growController = "/grow_controller";
  static const growSheetGrowController = "/growsheet/grow_controller";
  static const device = "/device";
  static const company = "/company";
  static const growSheetLabeler = "/growsheet/growsheet_labeler";
  static const growSheetFormOptions = "/growsheet/form_options";
  static const growSheet = "/growsheet";
  static const report = "/report";
  static const todo = "/todo";
  static const companyUsers = "/company_users";
  static const events = "/events";
  static const temperatureControl = "/ctrl/temperature_control";
  static const circulationFanControl = "/ctrl/circulation_fan_control";
  static const switches = "/device_type/switch";
  static const humidityControl = "/ctrl/humidity_control";
  static const co2Control = "/ctrl/co2_control";
  static const lightingControl = "/ctrl/lighting_control";
  static const accessUser = "/access/user";
  static const user = "/user";
  static const notificationSettings = "/user/notification_settings";
  static const irrigationControl = "/ctrl/irrigation_control";
  static const fertigationControl = "/ctrl/fertigation_control";
  static const wetWallControl = "/ctrl/wet_wall_control";
  static const extractorFanControl = "/ctrl/extractor_fan_control";
  static const blackoutScreen = "/blackoutscreen";
  static const getNotifications = "/get_notifications";

}