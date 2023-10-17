/*
* Class này chỉ chứa các const là các api gọi đến backend tương ứng với tên class
* Tên constant không viết theo chuẩn thông thường là lowerCamelCase nhằm mục đích khi nhìn vào tên (ở nơi sử dụng) có thể dễ dàng nhận biết được api nào được gọi
* Khi replace ký tự _ trong tên constant bằng ký tự / thì ta được đường dẫn api
* */

class NmsUri {
  static const api_NmsDeviceToken_Register = '/api/NmsDeviceToken/Register';
  static const api_NmsDeviceToken_RegisterWithoutLogin = '/api/NmsDeviceToken/RegisterWithoutLogin';
  static const api_NmsNotification_GetByUser = '/api/NmsNotification/GetByUser';
  static const api_NmsCategory_GetAll = '/api/NmsCategory/GetAll';
  static const api_NmsCategoryGroup_Get = '/api/NmsCategoryGroup/Get';
  static const api_NmsNotifyConfig_GetMyConfig = '/api/NmsNotifyConfig/GetMyConfig';
  static const api_NmsNotifyConfig_Update = '/api/NmsNotifyConfig/Update';
}