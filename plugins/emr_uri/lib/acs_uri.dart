/*
* Class này chỉ chứa các const là các api gọi đến backend tương ứng với tên class
* Tên constant không viết theo chuẩn thông thường là lowerCamelCase nhằm mục đích khi nhìn vào tên (ở nơi sử dụng) có thể dễ dàng nhận biết được api nào được gọi
* Khi replace ký tự _ trong tên constant bằng ký tự / thì ta được đường dẫn api
* */

class AcsUri {
  static const api_Token_Login = '/api/Token/Login';
  static const api_Token_Logout = '/api/Token/Logout';
  static const api_AcsOtp_RequiredOnly = '/api/AcsOtp/RequiredOnly';
  static const api_AcsOtp_Required = '/api/AcsOtp/Required';
  static const api_AcsOtp_Verify = '/api/AcsOtp/Verify';
  static const api_AcsUser_ChangePasswordWithOtp = '/api/AcsUser/ChangePasswordWithOtp';
  static const api_AcsUser_ChangePassword = '/api/AcsUser/ChangePassword';
  static const api_AcsUser_CheckActive = '/api/AcsUser/CheckActive';
  static const api_AcsUser_ActivationRequired = '/api/AcsUser/ActivationRequired';
  static const api_AcsUser_Activate = '/api/AcsUser/Activate';
}