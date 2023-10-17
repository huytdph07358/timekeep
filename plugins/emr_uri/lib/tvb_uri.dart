/*
* Class này chỉ chứa các const là các api gọi đến backend tương ứng với tên class
* Tên constant không viết theo chuẩn thông thường là lowerCamelCase nhằm mục đích khi nhìn vào tên (ở nơi sử dụng) có thể dễ dàng nhận biết được api nào được gọi
* Khi replace ký tự _ trong tên constant bằng ký tự / thì ta được đường dẫn api
* */

class TvbUri {
  static const String api_TvbRole_GetMyAuthorize =
      '/api/TvbRole/GetMyAuthorize';
  static const String api_TvbScreen_GetAll = '/api/TvbScreen/GetAll';
  static const String api_TvbPatient_Create = '/api/TvbPatient/Create';
  static const String api_TvbPatient_Delete = '/api/TvbPatient/Delete';
  static const String api_TvbPatient_GetByPeople =
      '/api/TvbPatient/GetByPeople';
}
