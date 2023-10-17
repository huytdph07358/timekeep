/*
* Class này chỉ chứa các const là các api gọi đến backend tương ứng với tên class
* Tên constant không viết theo chuẩn thông thường là lowerCamelCase nhằm mục đích khi nhìn vào tên (ở nơi sử dụng) có thể dễ dàng nhận biết được api nào được gọi
* Khi replace ký tự _ trong tên constant bằng ký tự / thì ta được đường dẫn api
* */

class EhrUri {
  static const String api_EHR_LoadDMCSKCBbyMaTinhThanh =
      '/api/EHR/LoadDMCSKCBbyMaTinhThanh';
  static const String api_EHR_GetDanhSachCacLanVaoVien =
      '/api/EHR/GetDanhSachCacLanVaoVien';
}
