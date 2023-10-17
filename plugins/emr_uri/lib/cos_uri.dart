/*
* Class này chỉ chứa các const là các api gọi đến backend tương ứng với tên class
* Tên constant không viết theo chuẩn thông thường là lowerCamelCase nhằm mục đích khi nhìn vào tên (ở nơi sử dụng) có thể dễ dàng nhận biết được api nào được gọi
* Khi replace ký tự _ trong tên constant bằng ký tự / thì ta được đường dẫn api
* */

class CosUri {
  static const api_CosPeople_GetByBasicInfo = '/api/CosPeople/GetByBasicInfo';
  static const api_CosPeople_GetUserByIdentifyInfo =
      '/api/CosPeople/GetUserByIdentifyInfo';
  static const api_CosPeople_GetMyInfo = '/api/CosPeople/GetMyInfo';
  static const api_CosCard_GetView = '/api/CosCard/GetView';
  static const api_CosCard_GetMyCard = '/api/CosCard/GetMyCard';
  static const api_CosPeople_RegisterUser = '/api/CosPeople/RegisterUser';
  static const api_CosPeople_AgentRegister = '/api/CosPeople/AgentRegister';
  static const api_CosPeople_CheckExists = '/api/CosPeople/CheckExists';
  static const api_CosPeople_GetAgentInfo = '/api/CosPeople/GetAgentInfo';
  static const api_CosPeople_GetTQRCode = '/api/CosPeople/GetTQRCode';
  static const api_CosCard_Recognition = '/api/CosCard/Recognition';
  static const api_CosPeople_AgentIssueCard = '/api/CosPeople/AgentIssueCard';
  static const api_CosCard_VerifyUnissued = '/api/CosCard/VerifyUnissued';
  static const api_CosPeople_SelfIssueCard = '/api/CosPeople/SelfIssueCard';
  static const api_CosPeople_CheckQRCode = '/api/CosPeople/CheckQRCode';
  static const api_CosOrderReq_Take = '/api/CosOrderReq/Take';
  static const api_CosOrderReq_GetMyOrder = '/api/CosOrderReq/GetMyOrder';
  static const api_CosPeople_GetInfoByCardOrService =
      '/api/CosPeople/GetInfoByCardOrService';
}
