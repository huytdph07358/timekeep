/*
* Class này chỉ chứa các const là các api gọi đến backend tương ứng với tên class
* Tên constant không viết theo chuẩn thông thường là lowerCamelCase nhằm mục đích khi nhìn vào tên (ở nơi sử dụng) có thể dễ dàng nhận biết được api nào được gọi
* Khi replace ký tự _ trong tên constant bằng ký tự / thì ta được đường dẫn api
* */

class VtqUri {
  static const String api_VtqTicket_NormalBuy = '/api/VtqTicket/NormalBuy';
  static const String api_VtqTicket_PrintTicket = '/api/VtqTicket/PrintTicket';
  static const String api_VtqTicket_GetMyTicket = '/api/VtqTicket/GetMyTicket';
  static const String api_VtqEinvoice_LoadPdf = '/api/VtqEinvoice/LoadPdf';
}
