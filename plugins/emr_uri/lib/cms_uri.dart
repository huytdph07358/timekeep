/*
* Class này chỉ chứa các const là các api gọi đến backend tương ứng với tên class
* Tên constant không viết theo chuẩn thông thường là lowerCamelCase nhằm mục đích khi nhìn vào tên (ở nơi sử dụng) có thể dễ dàng nhận biết được api nào được gọi
* Khi replace ký tự _ trong tên constant bằng ký tự / thì ta được đường dẫn api
* */

class CmsUri {
  static const api_CktCashinNapas_Cashin_Get = '/CktCashinNapas/Cashin';
  static const api_CktCashin_Request = '/api/CktCashin/Request';
  static const api_CktCashin_Recharge = '/api/CktCashin/Recharge';
}
