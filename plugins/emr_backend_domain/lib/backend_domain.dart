import 'package:vss_environment/environment_enum.dart';
import 'package:vss_environment/environment_switch.dart';

import 'dev_domain.dart';
import 'live_domain.dart';

class BackendDomain {
  static String get emr {
    return EnvironmentSwitch.environment == EnvironmentEnum.dev.env
        ? DevDomain.emr
        : LiveDomain.emr;
  }

  static String get acs {
    return EnvironmentSwitch.environment == EnvironmentEnum.dev.env
        ? DevDomain.acs
        : LiveDomain.acs;
  }

  static String get fss {
    return EnvironmentSwitch.environment == EnvironmentEnum.dev.env
        ? DevDomain.fss
        : LiveDomain.fss;
  }

  static String get nms {
    return EnvironmentSwitch.environment == EnvironmentEnum.dev.env
        ? DevDomain.nms
        : LiveDomain.nms;
  }

  static String get vplus {
    return EnvironmentSwitch.environment == EnvironmentEnum.dev.env
        ? DevDomain.vplus
        : LiveDomain.vplus;
  }

  static String get sda {
    return EnvironmentSwitch.environment == EnvironmentEnum.dev.env
        ? DevDomain.sda
        : LiveDomain.sda;
  }

  static String get sda_init {
    return EnvironmentSwitch.environment == EnvironmentEnum.dev.env
        ? DevDomain.sda_init
        : LiveDomain.sda_init;
  }

  static void setEmrUri(String uri) {
    LiveDomain.emr = uri;
  }

  static void setAcsUri(String uri) {
    LiveDomain.acs = uri;
  }

  static void setSdaUri(String uri) {
    LiveDomain.sda = uri;
  }
}
