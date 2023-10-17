/*
* Class này chỉ chứa các const là các api gọi đến backend tương ứng với tên class
* Tên constant không viết theo chuẩn thông thường là lowerCamelCase nhằm mục đích khi nhìn vào tên (ở nơi sử dụng) có thể dễ dàng nhận biết được api nào được gọi
* Khi replace ký tự _ trong tên constant bằng ký tự / thì ta được đường dẫn api
* */

class EmrUri {
  static const String api_VtxRole_GetMyAuthorize =
      '/api/VtxRole/GetMyAuthorize';
  static const String api_VtxScreen_GetAll = '/api/VtxScreen/GetAll';
  static const String api_VtxLineEmployee_Get = '/api/VtxLineEmployee/Get';
  static const String api_EmrConfig_Get = '/api/EmrConfig/Get';
  static const String api_EmrSign_GetView = '/api/EmrSign/GetView';

  static const String api_EmrDocument_GetWatermark =
      '/api/EmrDocument/GetWatermark';
  static const String api_EmrDocument_GetView = '/api/EmrDocument/GetView';
  static const String api_EmrDocument_Cancel = '/api/EmrDocument/Cancel';
  static const String api_VEmrmployee_Get = '/api/VEmrmployee/Get';
  static const String api_EmrDevice_Register = '/api/EmrDevice/Register';
  static const String api_EmrDocumentType_Get = '/api/EmrDocumentType/Get';
  static const String api_EmrSign_Finish = '/api/EmrSign/Finish';
  static const String api_EmrSign_SignPdfSimCa = '/api/EmrSign/SignPdfSimCa';
  static const String api_EmrSign_SignPdfHsm = '/api/EmrSign/SignPdfHsm';
  static const String api_EmrSign_Get = '/api/EmrSign/Get';
  static const String api_SdaConfigApp_Get = '/api/SdaConfigApp/Get';
}
