import 'package:vss_ivt_api/api_consumer.dart';
import 'package:vss_ivt_api/api_result_model.dart';
import 'package:emr_backend_domain/backend_domain.dart';
import 'package:emr_uri/emr_uri.dart';

import 'model/vtx_role_model.dart';
import 'role_enum.dart';

class RoleStore {
  static final List<String> _roleCodeList =
      <String>[]; //không cho lớp bên ngoài có thể set trực tiếp giá trị (tránh sai sót)

  static List<String> get roleCodeList {
    return List<String>.from(
        _roleCodeList); //clone ra list mới để không cho bên ngoài tự ý sửa dữ liệu trong _roleCodeList
  }

  static Future<void> checkRole() async {
    final ApiResultModel apiResultModel = await ApiConsumer.dotNetApi
        .get('${BackendDomain.emr}${EmrUri.api_VtxRole_GetMyAuthorize}');
    if (apiResultModel.Data != null) {
      final List<VtxRoleModel> roleList = (apiResultModel.Data as List)
          .map((e) => VtxRoleModel.fromJson(e as Map<String, dynamic>))
          .toList();
      if (roleList.isNotEmpty) {
        _roleCodeList.clear();
        for (final VtxRoleModel role in roleList) {
          if (role.roleCode != null && role.roleCode != '') {
            _roleCodeList.add(role.roleCode!);
          }
        }
      } else {
        _roleCodeList.clear();
      }
    } else {
      _roleCodeList.clear();
    }
  }

  static bool existsRole(RoleEnum roleEnum) {
    return _roleCodeList.contains(roleEnum.roleCode);
  }

  static String getRoleCode() {
    return _roleCodeList.join(',');
  }

  static int getRoleCount() {
    return _roleCodeList.length;
  }
}
