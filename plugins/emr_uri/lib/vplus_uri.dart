/*
* Class này chỉ chứa các const là các api gọi đến backend tương ứng với tên class
* Tên constant không viết theo chuẩn thông thường là lowerCamelCase nhằm mục đích khi nhìn vào tên (ở nơi sử dụng) có thể dễ dàng nhận biết được api nào được gọi
* Khi replace ký tự _ trong tên constant bằng ký tự / thì ta được đường dẫn api
* */

class VplusUri {
  static const String hoidap_hoidap = '/hoidap/hoidap';
  static const String baiviet_baiviet = '/baiviet/baiviet';
  static const String phanbohoahong_phanbohoahong =
      '/phanbohoahong/phanbohoahong';
  static const String phanbohoahong_doitac = '/phanbohoahong/doitac';
  static const String phanbohoahong_tonghopdoitac =
      '/phanbohoahong/tonghopdoitac';
  static const String hoahong_the = '/hoahong/the';
  static const String hoahong_merchant = '/hoahong/merchant';
  static const String hotrochuthe_hotrochuthe = '/hotrochuthe/hotrochuthe';
  static const String doitac_captren = '/doitac/captren';
  static const String doitac_capduoi = '/doitac/capduoi';
  static const String doitac_doitac = '/doitac/doitac';
}
