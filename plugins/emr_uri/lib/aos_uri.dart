/*
* Class này chỉ chứa các const là các api gọi đến backend tương ứng với tên class
* Tên constant không viết theo chuẩn thông thường là lowerCamelCase nhằm mục đích khi nhìn vào tên (ở nơi sử dụng) có thể dễ dàng nhận biết được api nào được gọi
* Khi replace ký tự _ trong tên constant bằng ký tự / thì ta được đường dẫn api
* */

class AosUri {
  static const String api_AosBank_Get = '/api/AosBank/Get';
  static const String api_AosAccount_GetByPeople =
      '/api/AosAccount/GetByPeople';
  static const String api_AosAccount_GetByCard = '/api/AosAccount/GetByCard';
  static const String api_AosAccount_GetLoyaltyByPeople =
      '/api/AosAccount/GetLoyaltyByPeople';
  static const String api_AosAccount_GetByPhone = '/api/AosAccount/GetByPhone';
  static const String api_AosAccount_GetHistory = '/api/AosAccount/GetHistory';
  static const String api_AosAccount_GetBankBalanceForPeople =
      '/api/AosAccount/GetBankBalanceForPeople';
}
